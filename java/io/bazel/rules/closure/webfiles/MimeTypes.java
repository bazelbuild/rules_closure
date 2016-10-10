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

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.common.net.MediaType;

final class MimeTypes {

  static final ImmutableMap<String, MediaType> EXTENSIONS =
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

  static final ImmutableSet<MediaType> COMPRESSIBLE =
      new ImmutableSet.Builder<MediaType>()
          .add(MediaType.ATOM_UTF_8.withoutParameters())
          .add(MediaType.CSS_UTF_8.withoutParameters())
          .add(MediaType.CSV_UTF_8.withoutParameters())
          .add(MediaType.DART_UTF_8.withoutParameters())
          .add(MediaType.EOT)
          .add(MediaType.HTML_UTF_8.withoutParameters())
          .add(MediaType.JAVASCRIPT_UTF_8.withoutParameters())
          .add(MediaType.JSON_UTF_8.withoutParameters())
          .add(MediaType.KML)
          .add(MediaType.KMZ)
          .add(MediaType.MANIFEST_JSON_UTF_8.withoutParameters())
          .add(MediaType.PLAIN_TEXT_UTF_8.withoutParameters())
          .add(MediaType.POSTSCRIPT)
          .add(MediaType.RDF_XML_UTF_8.withoutParameters())
          .add(MediaType.RTF_UTF_8.withoutParameters())
          .add(MediaType.SFNT)
          .add(MediaType.SVG_UTF_8.withoutParameters())
          .add(MediaType.TAR)
          .add(MediaType.TSV_UTF_8.withoutParameters())
          .add(MediaType.VCARD_UTF_8.withoutParameters())
          .add(MediaType.XHTML_UTF_8.withoutParameters())
          .add(MediaType.XML_UTF_8.withoutParameters())
          .build();

  private MimeTypes() {}
}
