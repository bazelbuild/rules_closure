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

import static com.google.common.base.MoreObjects.firstNonNull;
import static com.google.common.base.Preconditions.checkArgument;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.base.Joiner;
import com.google.common.base.Splitter;
import com.google.common.collect.HashMultimap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Iterables;
import com.google.common.collect.Multimap;
import io.bazel.rules.closure.Tarjan;
import io.bazel.rules.closure.program.CommandLineProgram;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Strict dependency checker for HTML and CSS files.
 *
 * <p>This program checks that all the href, src, etc. attributes in the HTML and CSS point to srcs
 * defined by the current rule, or direct children rules. It also checks for cycles.
 */
public final class WebfilesValidator implements CommandLineProgram {

  private static final String RED = "\u001b[31m";
  private static final String BOLD = "\u001b[1m";
  private static final String RESET = "\u001b[0m";
  private static final String ERROR_PREFIX = String.format("%s%sERROR:%s ", BOLD, RED, RESET);
  private static final Splitter TAB_SPLITTER = Splitter.on('\t');

  // HTML parsing with regex YOLO
  // See also: http://stackoverflow.com/a/1732454
  private static final Pattern HTML_COMMENT = Pattern.compile("<!--.*?-->", Pattern.DOTALL);
  private static final Pattern CSS_COMMENT = Pattern.compile("/\\*.*?\\*/", Pattern.DOTALL);
  private static final Pattern HREF_SRC_ATTRIBUTE =
      Pattern.compile(" (?:href|src)=(\"[^\"]+\"|'[^']+'|[^'\" >]+)");
  private static final Pattern URL_ATTRIBUTE =
      Pattern.compile(" url\\(\\s*('[^']+'|\"[^\"]+\"|[^)]+)\\)");

  private final Map<Path, Path> sourceAssets = new LinkedHashMap<>();
  private final Map<Path, Path> directAssets = new LinkedHashMap<>();
  private final Map<Path, String> transitiveAssets = new LinkedHashMap<>();
  private final Multimap<Path, Path> relationships = HashMultimap.create();

  @Override
  public Integer apply(Iterable<String> args) {
    try {
      return run(args);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  private int run(Iterable<String> args) throws IOException {
    Iterator<String> flags = args.iterator();
    while (flags.hasNext()) {
      String flag = flags.next();
      switch (flag) {
        case "--dummy":
          Files.write(Paths.get(flags.next()), new byte[0]);
          break;
        case "--source_manifest":
          loadDirectManifest(Paths.get(flags.next()), sourceAssets);
          directAssets.putAll(sourceAssets);
          break;
        case "--direct_manifest":
          loadDirectManifest(Paths.get(flags.next()), directAssets);
          break;
        case "--transitive_manifest":
          loadTransitiveManifest(Paths.get(flags.next()));
          break;
        default:
          throw new RuntimeException("Unexpected flag: " + flag);
      }
    }
    int rc = 0;
    for (Map.Entry<Path, Path> entry : sourceAssets.entrySet()) {
      Path webpath = entry.getKey();
      Path path = entry.getValue();
      String contents = new String(Files.readAllBytes(path), UTF_8);
      Pattern pattern;
      if (path.getFileName().toString().endsWith(".html")) {
        contents = HTML_COMMENT.matcher(contents).replaceAll("");
        pattern = HREF_SRC_ATTRIBUTE;
      } else if (path.getFileName().toString().endsWith(".css")) {
        contents = CSS_COMMENT.matcher(contents).replaceAll("");
        pattern = URL_ATTRIBUTE;
      } else {
        continue;
      }
      Matcher matcher = pattern.matcher(contents);
      while (matcher.find()) {
        String url = stripQuotes(matcher.group(1));
        if (shouldSkipUrl(url)) {
          continue;
        }
        rc |= addRelationship(path, webpath, Paths.get(url));
      }
    }
    for (ImmutableSet<Path> scc : Tarjan.findStronglyConnectedComponents(relationships)) {
      System.err.printf(
          "%sThese paths are strongly connected; please make your html acyclic\n\n  - %s\n\n",
          ERROR_PREFIX, Joiner.on("\n  - ").join(scc));
      rc |= 1;
    }
    return rc;
  }

  private int addRelationship(Path path, Path src, Path dest) {
    if (dest.isAbsolute()) {
      System.err.printf(
          "%s%s: Absolute path %s should be made relative to %s\n",
          ERROR_PREFIX, path, dest, src);
      return 1;
    }
    Path target = src.getParent().resolve(dest).normalize();
    if (target == null) {
      System.err.printf(
          "%s%s: Could not normalize %s against %s\n",
          ERROR_PREFIX, path, dest, src);
      return 1;
    }
    if (relationships.put(src, target) && !directAssets.containsKey(target)) {
      String label = firstNonNull(transitiveAssets.get(target), "a webfiles() rule providing it");
      System.err.printf(
          "%s%s: Referenced %s without depending on %s\n",
          ERROR_PREFIX, path, dest, label);
      return 1;
    }
    return 0;
  }

  private void loadDirectManifest(Path manifest, Map<Path, Path> out) throws IOException {
    for (String line : Iterables.skip(Files.readAllLines(manifest, UTF_8), 1)) {
      List<String> columns = TAB_SPLITTER.splitToList(line);
      Path webpath = Paths.get(columns.get(0));
      Path path = Paths.get(columns.get(2));
      checkArgument(webpath.isAbsolute(),
          "Bad webpath in %s on line %s", manifest, line);
      out.put(webpath, path);
    }
  }

  private void loadTransitiveManifest(Path manifest) throws IOException {
    List<String> lines = Files.readAllLines(manifest, UTF_8);
    String label = Iterables.getFirst(lines, null);
    for (String line : Iterables.skip(lines, 1)) {
      List<String> columns = TAB_SPLITTER.splitToList(line);
      Path webpath = Paths.get(columns.get(0));
      checkArgument(webpath.isAbsolute(),
          "Bad webpath in %s on line %s", manifest, line);
      transitiveAssets.put(webpath, label);
    }
  }

  private static boolean shouldSkipUrl(String uri) {
    return uri.endsWith("/")
        || uri.contains("//")
        || uri.startsWith("data:")
        || uri.startsWith("[")
        || uri.startsWith("{");
  }

  private static String stripQuotes(String value) {
    if (value.charAt(0) == '\'' || value.charAt(0) == '"') {
      return value.substring(1, value.length() - 1);
    }
    return value;
  }
}
