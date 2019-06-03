// Copyright 2016 The Closure Rules Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package io.bazel.rules.closure.webfiles;

import static com.google.common.base.Strings.nullToEmpty;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.base.Joiner;
import com.google.common.base.Optional;
import com.google.common.base.Supplier;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.HashMultimap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Multimap;
import com.google.common.collect.Ordering;
import com.google.common.css.JobDescriptionBuilder;
import com.google.common.css.compiler.ast.BasicErrorManager;
import com.google.common.css.compiler.ast.CssFunctionNode;
import com.google.common.css.compiler.ast.CssTree;
import com.google.common.css.compiler.ast.CssValueNode;
import com.google.common.css.compiler.ast.DefaultTreeVisitor;
import com.google.common.css.compiler.passes.PassRunner;
import io.bazel.rules.closure.Tarjan;
import io.bazel.rules.closure.Webpath;
import io.bazel.rules.closure.webfiles.BuildInfo.Webfiles;
import io.bazel.rules.closure.webfiles.BuildInfo.WebfilesSource;
import io.bazel.rules.closure.webfiles.compiler.CssParser;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.Set;
import javax.inject.Inject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Node;
import org.jsoup.parser.Parser;
import org.jsoup.select.NodeVisitor;

/**
 * Sanity checker for HTML and CSS srcs in a webfiles rule.
 *
 * <p>This checks that all the href, src, etc. attributes in the HTML and CSS point to srcs defined
 * by the current rule, or direct children rules. It checks for cycles. It validates the syntax of
 * the HTML and CSS.
 */
public class WebfilesValidator {

  // Changing these values will break any build code that references them.
  public static final String ABSOLUTE_PATH_ERROR = "absolutePaths";
  public static final String CSS_SYNTAX_ERROR = "cssSyntax";
  public static final String CSS_VALIDATION_ERROR = "cssValidation";
  public static final String CYCLES_ERROR = "cycles";
  public static final String PATH_NORMALIZATION_ERROR = "pathNormalization";
  public static final String STRICT_DEPENDENCIES_ERROR = "strictDependencies";

  private final FileSystem fs;
  private final CssParser cssParser;
  private final Set<Webpath> accessibleAssets = new HashSet<>();
  private final Multimap<Webpath, Webpath> relationships = HashMultimap.create();
  private Multimap<String, String> errors;
  private Supplier<? extends Iterable<Webfiles>> transitiveDeps;

  @Inject
  WebfilesValidator(FileSystem fs, CssParser cssParser) {
    this.fs = fs;
    this.cssParser = cssParser;
  }

  /** Validates {@code srcs} in {@code manifest} and returns error messages in categories. */
  Multimap<String, String> validate(
      Webfiles target,
      Iterable<Webfiles> directDeps,
      Supplier<? extends Iterable<Webfiles>> transitiveDeps)
      throws IOException {
    this.errors = ArrayListMultimap.create();
    this.transitiveDeps = transitiveDeps;
    accessibleAssets.clear();
    relationships.clear();
    for (WebfilesSource src : target.getSrcList()) {
      accessibleAssets.add(Webpath.get(src.getWebpath()));
    }
    for (Webfiles dep : directDeps) {
      for (WebfilesSource src : dep.getSrcList()) {
        accessibleAssets.add(Webpath.get(src.getWebpath()));
      }
    }
    for (WebfilesSource src : target.getSrcList()) {
      Path path = fs.getPath(src.getPath());
      if (src.getPath().endsWith(".html")) {
        validateHtml(path, Webpath.get(src.getWebpath()));
      } else if (src.getPath().endsWith(".css")) {
        validateCss(
            path, Webpath.get(src.getWebpath()), new String(Files.readAllBytes(path), UTF_8));
      }
    }
    for (ImmutableSet<Webpath> scc : Tarjan.run(relationships).getStronglyConnectedComponents()) {
      errors.put(
          CYCLES_ERROR,
          String.format(
              "These webpaths are strongly connected; please make your html acyclic\n\n  - %s\n",
              Joiner.on("\n  - ").join(Ordering.natural().sortedCopy(scc))));
    }
    return errors;
  }

  private void validateHtml(final Path path, final Webpath origin) throws IOException {
    HtmlParser.parse(
        path,
        new HtmlParser.Callback() {
          @Override
          public void onReference(Webpath destination) {
            addRelationship(path, origin, destination);
          }
        });
  }

  private void validateCss(final Path path, final Webpath origin, String source) {
    CssTree stylesheet = cssParser.parse(path.toString(), source);
    new PassRunner(
            new JobDescriptionBuilder().getJobDescription(),
            new BasicErrorManager() {
              @Override
              public void print(String message) {
                WebfilesValidator.this.errors.put(
                    CSS_VALIDATION_ERROR, String.format("%s: %s", path, message));
              }
            })
        .runPasses(stylesheet);
    stylesheet
        .getVisitController()
        .startVisit(
            new DefaultTreeVisitor() {
              private boolean inUrlFunction;

              @Override
              public boolean enterFunctionNode(CssFunctionNode function) {
                return (inUrlFunction = function.getFunction().getFunctionName().equals("url"));
              }

              @Override
              public void leaveFunctionNode(CssFunctionNode value) {
                inUrlFunction = false;
              }

              @Override
              public boolean enterArgumentNode(CssValueNode argument) {
                if (inUrlFunction) {
                  String uri = nullToEmpty(argument.getValue());
                  if (!shouldIgnoreUri(uri)) {
                    addRelationship(path, origin, Webpath.get(uri));
                  }
                }
                return false;
              }
            });
  }

  private void addRelationship(Path path, Webpath origin, Webpath relativeDest) {
    if (relativeDest.isAbsolute()) {
      // Even though this code supports absolute paths, we're going to forbid them anyway, because
      // we might want to write a rule in the future that allows the user to reposition a
      // transitive closure of webfiles into a subdirectory on the web server.
      errors.put(
          ABSOLUTE_PATH_ERROR,
          String.format("%s: Please use relative path for asset: %s", path, relativeDest));
      return;
    }
    Webpath dest = origin.lookup(relativeDest);
    if (dest == null) {
      errors.put(
          PATH_NORMALIZATION_ERROR,
          String.format("%s: Could not normalize %s against %s", path, relativeDest, origin));
      return;
    }
    if (relationships.put(origin, dest) && !accessibleAssets.contains(dest)) {
      Optional<String> label = tryToFindLabelOfTargetProvidingAsset(dest);
      errors.put(
          STRICT_DEPENDENCIES_ERROR,
          String.format(
              "%s: Referenced %s (%s) without depending on %s",
              path, relativeDest, dest, label.or("a web_library() rule providing it")));
      return;
    }
  }

  private Optional<String> tryToFindLabelOfTargetProvidingAsset(Webpath webpath) {
    String path = webpath.toString();
    for (Webfiles dep : transitiveDeps.get()) {
      for (WebfilesSource src : dep.getSrcList()) {
        if (path.equals(src.getWebpath())) {
          return Optional.of(dep.getLabel());
        }
      }
    }
    return Optional.absent();
  }

  private static boolean shouldIgnoreUri(String uri) {
    return uri.isEmpty()
        || uri.startsWith("#")
        || uri.endsWith("/")
        || uri.contains("//")
        || uri.startsWith("data:")
        || uri.startsWith("javascript:")
        || uri.startsWith("mailto:")
        || uri.equals("about:blank")
        // The following are intended to filter out URLs with Polymer variables.
        || (uri.contains("[[") && uri.contains("]]"))
        || (uri.contains("{{") && uri.contains("}}"));
  }

  private static class HtmlParser implements NodeVisitor {

    interface Callback {
      void onReference(Webpath webpath);
    }

    static void parse(Path path, Callback callback) throws IOException {
      new HtmlParser(callback).run(path);
    }

    private final Callback callback;

    private HtmlParser(Callback callback) {
      this.callback = callback;
    }

    private void run(Path path) throws IOException {
      Parser parser = Parser.htmlParser();
      try (InputStream input = Files.newInputStream(path)) {
        Jsoup.parse(input, null, "", parser).traverse(this);
      }
    }

    @Override
    public void head(Node node, int depth) {
      onReference(node.attr("href"));
      onReference(node.attr("src"));
    }

    @Override
    public void tail(Node node, int depth) {}

    private void onReference(String uri) {
      if (shouldIgnoreUri(uri)) {
        return;
      }
      callback.onReference(Webpath.get(uri));
    }
  }
}
