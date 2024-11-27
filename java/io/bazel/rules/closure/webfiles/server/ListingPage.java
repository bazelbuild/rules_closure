// Copyright 2017 The Closure Rules Authors. All Rights Reserved.
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

package io.bazel.rules.closure.webfiles.server;

import com.google.common.collect.ImmutableSet;
import com.google.common.net.MediaType;
import io.bazel.rules.closure.Webpath;
import io.bazel.rules.closure.http.HttpResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import javax.inject.Inject;

/**
 * Web page listing webpaths in transitive closure in topological order.
 *
 * <p>The webfiles server uses this as the directory listing and 404 page.
 */
class ListingPage {

  private final HttpResponse response;
  private final Metadata.Config config;
  private final ImmutableSet<Webpath> webpaths;

  @Inject
  ListingPage(HttpResponse response, Metadata.Config config, ImmutableSet<Webpath> webpaths) {
    this.response = response;
    this.config = config;
    this.webpaths = webpaths;
  }

  void serve(final Webpath webpath) throws IOException {
    StringBuilder builder = new StringBuilder();
    builder.append("<!doctype html>");
    builder.append("<link href='//fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>");
    builder.append("<style>");
    builder.append("body {");
    builder.append("  font-family: 'Roboto', sans-serif;");
    builder.append("  margin: 0 auto;");
    builder.append("  padding: 0 1em;");
    builder.append("  width: 960px;");
    builder.append("  color: #333;");
    builder.append("}");
    builder.append("a {");
    builder.append("  text-decoration: none;");
    builder.append("}");
    builder.append("h1 {");
    builder.append("  margin-bottom: 0;");
    builder.append("}");
    builder.append("h3 {");
    builder.append("  margin-top: 0;");
    builder.append("  color: #999;");
    builder.append("}");
    builder.append("</style>");
    builder.append("<h1>Bazel Closure Rules</h1>");
    builder.append("<h3>").append(config.get().getLabel()).append("</h3>");
    builder.append("<p>");
    if (webpaths.isEmpty()) {
      builder.append("No srcs found in transitive closure with path component prefix matching");
      builder.append("request path.");
    } else {
      webpaths.stream()
          .filter(path -> path.startsWith(webpath))
          .forEach(path -> builder.append("<a href=\"" + path + "\">" + path + "</a><br>"));
    }
    response.setContentType(MediaType.HTML_UTF_8);
    response.setPayload(builder.toString().getBytes(StandardCharsets.UTF_8));
  }
}
