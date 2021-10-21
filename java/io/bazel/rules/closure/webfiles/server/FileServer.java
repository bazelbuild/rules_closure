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

import static com.google.common.base.MoreObjects.firstNonNull;
import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Verify.verify;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSortedMap;
import com.google.common.net.MediaType;
import io.bazel.rules.closure.Webpath;
import io.bazel.rules.closure.http.HttpResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import javax.inject.Inject;

/**
 * Handler that sends static assets to the browser.
 *
 * <p>This serves both webpaths and external assets, e.g. runfiles. It does this by binary searching
 * an array mapping webpaths to either files or directories.
 */
class FileServer {

  private static final MediaType DEFAULT_MIME_TYPE = MediaType.OCTET_STREAM;
  private static final ImmutableMap<String, MediaType> EXTENSIONS =
      new ImmutableMap.Builder<String, MediaType>()
          .put("atom", MediaType.ATOM_UTF_8)
          .put("bmp", MediaType.BMP)
          .put("bz2", MediaType.BZIP2)
          .put("css", MediaType.CSS_UTF_8)
          .put("csv", MediaType.CSV_UTF_8)
          .put("dart", MediaType.DART_UTF_8)
          .put("eot", MediaType.EOT)
          .put("epub", MediaType.EPUB)
          .put("flv", MediaType.SHOCKWAVE_FLASH)
          .put("gif", MediaType.GIF)
          .put("gz", MediaType.GZIP)
          .put("html", MediaType.HTML_UTF_8)
          .put("ico", MediaType.ICO)
          .put("jpeg", MediaType.JPEG)
          .put("jpg", MediaType.JPEG)
          .put("js", MediaType.JAVASCRIPT_UTF_8)
          .put("json", MediaType.JSON_UTF_8)
          .put("kml", MediaType.KML)
          .put("kmz", MediaType.KMZ)
          .put("mbox", MediaType.MBOX)
          .put("mov", MediaType.QUICKTIME)
          .put("mp4", MediaType.MP4_VIDEO)
          .put("mpeg", MediaType.MPEG_VIDEO)
          .put("mpg", MediaType.MPEG_VIDEO)
          .put("ogg", MediaType.OGG_AUDIO)
          .put("otf", MediaType.SFNT)
          .put("p12", MediaType.KEY_ARCHIVE)
          .put("pdf", MediaType.PDF)
          .put("png", MediaType.PNG)
          .put("ps", MediaType.POSTSCRIPT)
          .put("psd", MediaType.PSD)
          .put("qt", MediaType.QUICKTIME)
          .put("rdf", MediaType.RDF_XML_UTF_8)
          .put("rtf", MediaType.RTF_UTF_8)
          .put("svg", MediaType.SVG_UTF_8)
          .put("tar", MediaType.TAR)
          .put("tif", MediaType.TIFF)
          .put("tiff", MediaType.TIFF)
          .put("tsv", MediaType.TSV_UTF_8)
          .put("ttf", MediaType.SFNT)
          .put("txt", MediaType.PLAIN_TEXT_UTF_8)
          .put("vcard", MediaType.VCARD_UTF_8)
          .put("wasm", MediaType.WASM_APPLICATION)
          .put("webm", MediaType.WEBM_VIDEO)
          .put("webmanifest", MediaType.MANIFEST_JSON_UTF_8)
          .put("webp", MediaType.WEBP)
          .put("wmv", MediaType.WMV)
          .put("woff", MediaType.WOFF)
          .put("xhtml", MediaType.XHTML_UTF_8)
          .put("xml", MediaType.XML_UTF_8)
          .put("xsd", MediaType.XML_UTF_8)
          .put("zip", MediaType.ZIP)
          .build();

  private final HttpResponse response;
  private final ImmutableSortedMap<Webpath, Path> assets;

  @Inject
  FileServer(HttpResponse response, ImmutableSortedMap<Webpath, Path> assets) {
    this.response = response;
    this.assets = assets;
  }

  /** Serves static asset or returns {@code false} if not found. */
  boolean serve(Webpath webpath) throws IOException {
    checkArgument(webpath.isAbsolute());
    checkArgument(webpath.normalize().equals(webpath));
    Map.Entry<Webpath, Path> floor = assets.floorEntry(webpath);
    if (floor == null) {
      return false;
    }
    if (webpath.equals(floor.getKey())) {
      serveAsset(floor.getValue());
      return true;
    }
    if (webpath.startsWith(floor.getKey())) {
      Webpath path = webpath.subpath(floor.getKey().getNameCount(), webpath.getNameCount());
      verify(!path.isAbsolute());
      Path file = floor.getValue().resolve(path.toString());
      if (Files.exists(file)) {
        serveAsset(file);
        return true;
      }
    }
    return false;
  }

  private void serveAsset(Path path) throws IOException {
    response.setContentLength(Files.size(path));
    response.setContentType(firstNonNull(EXTENSIONS.get(getExtension(path)), DEFAULT_MIME_TYPE));
    response.setPayload(Files.newInputStream(path));
  }

  private static String getExtension(Path path) {
    String name = path.getFileName().toString();
    int dot = name.lastIndexOf('.');
    return dot == -1 ? "" : name.substring(dot + 1);
  }
}
