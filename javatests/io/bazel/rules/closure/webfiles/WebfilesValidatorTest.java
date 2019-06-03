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

import static com.google.common.truth.Truth.assertThat;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.base.Suppliers;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Iterables;
import com.google.common.collect.Multimap;
import com.google.common.jimfs.Configuration;
import com.google.common.jimfs.Jimfs;
import io.bazel.rules.closure.webfiles.BuildInfo.Webfiles;
import io.bazel.rules.closure.webfiles.BuildInfo.WebfilesSource;
import io.bazel.rules.closure.webfiles.compiler.CssParser;
import java.io.IOException;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Unit tests for {@link WebfilesValidator}. */
@RunWith(JUnit4.class)
public class WebfilesValidatorTest {

  private final FileSystem fs = Jimfs.newFileSystem(Configuration.unix());
  private final WebfilesValidator validator = new WebfilesValidator(fs, new CssParser());

  @After
  public void after() throws Exception {
    fs.close();
  }

  @Test
  public void relativeReferenceToImgInSrcs_isAllowed() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"hello.jpg\">");
    save(fs.getPath("/fs/path/hello.jpg"), "oh my goth");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/hello.jpg")
                        .setWebpath("/web/path/hello.jpg")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void relativeReferenceToImgInDirectDeps_isAllowed() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"hello.jpg\">");
    save(fs.getPath("/fs/path/hello.jpg"), "oh my goth");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.of(
                    Webfiles.newBuilder()
                        .addSrc(WebfilesSource.newBuilder()
                            .setPath("/fs/path/hello.jpg")
                            .setWebpath("/web/path/hello.jpg")
                            .build())
                        .build()),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void relativeReferenceToUndeclaredAsset_printsError() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"hello.jpg\">");
    save(fs.getPath("/fs/path/hello.jpg"), "oh my goth");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .containsEntry(
            WebfilesValidator.STRICT_DEPENDENCIES_ERROR,
            "/fs/path/index.html: Referenced hello.jpg (/web/path/hello.jpg)"
                + " without depending on a web_library() rule providing it");
  }

  @Test
  public void relativeReferenceToImgInTransitiveDeps_showsLabelToUse() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"hello.jpg\">");
    save(fs.getPath("/fs/path/hello.jpg"), "oh my goth");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(
                    ImmutableList.of(
                        Webfiles.newBuilder()
                            .setLabel("@foo//bar")
                            .addSrc(WebfilesSource.newBuilder()
                                .setPath("/fs/path/hello.jpg")
                                .setWebpath("/web/path/hello.jpg")
                                .build())
                            .build()))))
        .containsEntry(
            WebfilesValidator.STRICT_DEPENDENCIES_ERROR,
            "/fs/path/index.html: Referenced hello.jpg (/web/path/hello.jpg)"
                + " without depending on @foo//bar");
  }

  @Test
  public void absoluteReferenceToImgInSrcs_printsError() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"/a/b/c\">");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .containsEntry(
            WebfilesValidator.ABSOLUTE_PATH_ERROR,
            "/fs/path/index.html: Please use relative path for asset: /a/b/c");
  }

  @Test
  public void weirdPolymerVariables_getIgnored() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"[[omg]]\">\n<img src=\"{{why}}\">\n");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void properUrls_getIgnored() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"http://google.com\">\n");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void dataUris_getIgnored() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<img src=\"data:base64;lolol\">\n");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void mailtoUris_getIgnored() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<a href=\"mailto:xxx@yyy.com\">email us</a>\n");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void cssUrls_areRecognized() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<link rel=\"stylesheet\" href=\"index.css\">");
    save(fs.getPath("/fs/path/index.css"), "body { background: url(hello.jpg); }");
    save(fs.getPath("/fs/path/hello.jpg"), "oh my goth");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.css")
                        .setWebpath("/web/path/index.css")
                        .build())
                    .build(),
                ImmutableList.of(
                    Webfiles.newBuilder()
                        .addSrc(WebfilesSource.newBuilder()
                            .setPath("/fs/path/hello.jpg")
                            .setWebpath("/web/path/hello.jpg")
                            .build())
                        .build()),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void badCssUrl_resultsInError() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<link rel=\"stylesheet\" href=\"index.css\">");
    save(fs.getPath("/fs/path/index.css"), "body { background: url(hello.jpg); }");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.css")
                        .setWebpath("/web/path/index.css")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isNotEmpty();
  }

  @Test
  public void cyclicEdge_resultsInError() throws Exception {
    save(fs.getPath("/fs/path/index.html"), "<link rel=\"stylesheet\" href=\"index.css\">");
    save(fs.getPath("/fs/path/index.css"), "body { background: url(index.html); }");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.html")
                        .setWebpath("/web/path/index.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/index.css")
                        .setWebpath("/web/path/index.css")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .containsEntry(
            WebfilesValidator.CYCLES_ERROR,
            "These webpaths are strongly connected; please make your html acyclic\n\n"
                + "  - /web/path/index.css\n"
                + "  - /web/path/index.html\n");
  }

  @Test
  public void stronglyConnectiedComponent_resultsInError() throws Exception {
    save(fs.getPath("/fs/path/a.html"), "<link rel=\"import\" href=\"b.html\">");
    save(fs.getPath("/fs/path/b.html"), "<link rel=\"import\" href=\"c.html\">");
    save(fs.getPath("/fs/path/c.html"), "<link rel=\"import\" href=\"a.html\">");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/a.html")
                        .setWebpath("/web/path/a.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/b.html")
                        .setWebpath("/web/path/b.html")
                        .build())
                    .addSrc(WebfilesSource.newBuilder()
                        .setPath("/fs/path/c.html")
                        .setWebpath("/web/path/c.html")
                        .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .containsEntry(
            WebfilesValidator.CYCLES_ERROR,
            "These webpaths are strongly connected; please make your html acyclic\n\n"
                + "  - /web/path/a.html\n"
                + "  - /web/path/b.html\n"
                + "  - /web/path/c.html\n");
  }

  @Test
  public void invalidHtml_doesntCare() throws Exception {
    // jsoup is too strict about html syntax errors to be useful for polymer and it doesn't provide
    // a very friendly way to report these errors.
    save(fs.getPath("/fs/path/index.html"), "< ");
    assertThat(
            validator.validate(
                Webfiles.newBuilder()
                    .addSrc(
                        WebfilesSource.newBuilder()
                            .setPath("/fs/path/index.html")
                            .setWebpath("/web/path/index.html")
                            .build())
                    .build(),
                ImmutableList.<Webfiles>of(),
                Suppliers.ofInstance(ImmutableList.<Webfiles>of())))
        .isEmpty();
  }

  @Test
  public void invalidCssWithBadRelationshipAfterBadSyntax_stillAbleToFindUrl() throws Exception {
    save(fs.getPath("/fs/path/index.css"), ".{}\n.hi{background: url(nope.jpg)}");
    Multimap<String, String> errors =
        validator.validate(
            Webfiles.newBuilder()
                .addSrc(WebfilesSource.newBuilder()
                    .setPath("/fs/path/index.css")
                    .setWebpath("/web/path/index.css")
                    .build())
                .build(),
            ImmutableList.<Webfiles>of(),
            Suppliers.ofInstance(ImmutableList.<Webfiles>of()));
    assertThat(errors).hasSize(1);
    assertThat(errors).containsKey(WebfilesValidator.STRICT_DEPENDENCIES_ERROR);
    assertThat(Iterables.getFirst(errors.get(WebfilesValidator.STRICT_DEPENDENCIES_ERROR), null))
        .contains("nope.jpg");
  }

  private void save(Path path, String contents) throws IOException {
    Files.createDirectories(path.getParent());
    Files.write(path, contents.getBytes(UTF_8));
  }
}
