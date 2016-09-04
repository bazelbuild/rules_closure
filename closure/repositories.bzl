# -*- mode: python; -*-
#
# Copyright 2016 The Closure Rules Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""External dependencies for Closure Rules."""

load("//closure/private:platform_http_file.bzl", "platform_http_file")

def closure_repositories(
    omit_aopalliance=False,
    omit_args4j=False,
    omit_asm=False,
    omit_asm_analysis=False,
    omit_asm_commons=False,
    omit_asm_util=False,
    omit_clang=False,
    omit_closure_compiler=False,
    omit_closure_library=False,
    omit_closure_stylesheets=False,
    omit_fonts_noto_hinted_deb=False,
    omit_fonts_noto_mono_deb=False,
    omit_gson=False,
    omit_guava=False,
    omit_guice=False,
    omit_guice_assistedinject=False,
    omit_guice_multibindings=False,
    omit_icu4j=False,
    omit_incremental_dom=False,
    omit_json=False,
    omit_jsr305=False,
    omit_jsr330_inject=False,
    omit_libexpat_amd64_deb=False,
    omit_libfontconfig_amd64_deb=False,
    omit_libfreetype_amd64_deb=False,
    omit_libpng_amd64_deb=False,
    omit_phantomjs=False,
    omit_protobuf_java=False,
    omit_protobuf_js=False,
    omit_protoc_linux_x86_64=False,
    omit_protoc_macosx=False,
    omit_safe_html_types=False,
    omit_safe_html_types_html_proto=False,
    omit_soy=False,
    omit_soy_jssrc=False):
  closure_maven_server()
  if not omit_aopalliance:
    aopalliance()
  if not omit_args4j:
    args4j()
  if not omit_asm:
    asm()
  if not omit_asm_analysis:
    asm_analysis()
  if not omit_asm_commons:
    asm_commons()
  if not omit_asm_util:
    asm_util()
  if not omit_clang:
    clang()
  if not omit_closure_compiler:
    closure_compiler()
  if not omit_closure_library:
    closure_library()
  if not omit_closure_stylesheets:
    closure_stylesheets()
  if not omit_fonts_noto_hinted_deb:
    fonts_noto_hinted_deb()
  if not omit_fonts_noto_mono_deb:
    fonts_noto_mono_deb()
  if not omit_gson:
    gson()
  if not omit_guava:
    guava()
  if not omit_guice:
    guice()
  if not omit_guice_assistedinject:
    guice_assistedinject()
  if not omit_guice_multibindings:
    guice_multibindings()
  if not omit_icu4j:
    icu4j()
  if not omit_incremental_dom:
    incremental_dom()
  if not omit_json:
    json()
  if not omit_jsr305:
    jsr305()
  if not omit_jsr330_inject:
    jsr330_inject()
  if not omit_libexpat_amd64_deb:
    libexpat_amd64_deb()
  if not omit_libfontconfig_amd64_deb:
    libfontconfig_amd64_deb()
  if not omit_libfreetype_amd64_deb:
    libfreetype_amd64_deb()
  if not omit_libpng_amd64_deb:
    libpng_amd64_deb()
  if not omit_phantomjs:
    phantomjs()
  if not omit_protobuf_java:
    protobuf_java()
  if not omit_protobuf_js:
    protobuf_js()
  if not omit_protoc_linux_x86_64:
    protoc_linux_x86_64()
  if not omit_protoc_macosx:
    protoc_macosx()
  if not omit_safe_html_types:
    safe_html_types()
  if not omit_safe_html_types_html_proto:
    safe_html_types_html_proto()
  if not omit_soy:
    soy()
  if not omit_soy_jssrc:
    soy_jssrc()

# MAINTAINERS
#
# 1. Please sort everything in this file.
#
# 2. Every external rule must have a SHA checksum.
#
# 3. Use http:// URLs since we're relying on the checksum for security.
#
# 4. Files must be mirrored to servers operated by Google SREs. This minimizes
#    the points of failure. It also minimizes the probability failure. For
#    example, if we assumed all external download servers were equal, had 99.9%
#    availability, and uniformly distributed downtime, that would put the
#    probability of an install working at 97.0% (0.999^30). Google static
#    content servers should have 99.999% availability, which *in theory* means
#    Closure Rules will install without any requests failing 99.9% of the time.
#
#    To get files mirrored, email the new artifacts or URLs to jart@google.com
#    so she can run:
#
#      bzmirror() {
#        local url="${1:?url}"
#        if [[ "${url}" =~ ^([^:]+):([^:]+):([^:]+)$ ]]; then
#          url="http://repo1.maven.org/maven2/${BASH_REMATCH[1]//.//}/${BASH_REMATCH[2]}/${BASH_REMATCH[3]}/${BASH_REMATCH[2]}-${BASH_REMATCH[3]}.jar"
#        fi
#        local dest="gs://bazel-mirror/${url#http*//}"
#        local desturl="http://bazel-mirror.storage.googleapis.com/${url#http*//}"
#        local name="$(basename "${dest}")"
#        wget -O "/tmp/${name}" "${url}" || return 1
#        gsutil cp -a public-read "/tmp/${name}" "${dest}" || return 1
#        gsutil setmeta -h 'Cache-Control:public, max-age=31536000' "${dest}" || return 1
#        rm "/tmp/${name}" || return 1
#        curl -I "${desturl}"
#        echo
#        echo "${desturl}"
#      }

def aopalliance():
  native.maven_jar(
      name = "aopalliance",
      artifact = "aopalliance:aopalliance:1.0",
      sha1 = "0235ba8b489512805ac13a8f9ea77a1ca5ebe3e8",
      server = "closure_maven_server",
  )

def args4j():
  native.maven_jar(
      name = "args4j",
      artifact = "args4j:args4j:2.0.26",
      sha1 = "01ebb18ebb3b379a74207d5af4ea7c8338ebd78b",
      server = "closure_maven_server",
  )

def asm():
  native.maven_jar(
      name = "asm",
      artifact = "org.ow2.asm:asm:5.0.3",
      sha1 = "dcc2193db20e19e1feca8b1240dbbc4e190824fa",
      server = "closure_maven_server",
  )

def asm_analysis():
  native.maven_jar(
      name = "asm_analysis",
      artifact = "org.ow2.asm:asm-analysis:5.0.3",
      sha1 = "c7126aded0e8e13fed5f913559a0dd7b770a10f3",
      server = "closure_maven_server",
  )

def asm_commons():
  native.maven_jar(
      name = "asm_commons",
      artifact = "org.ow2.asm:asm-commons:5.0.3",
      sha1 = "a7111830132c7f87d08fe48cb0ca07630f8cb91c",
      server = "closure_maven_server",
  )

def asm_util():
  native.maven_jar(
      name = "asm_util",
      artifact = "org.ow2.asm:asm-util:5.0.3",
      sha1 = "1512e5571325854b05fb1efce1db75fcced54389",
      server = "closure_maven_server",
  )

def clang():
  platform_http_file(
      name = "clang",
      amd64_url = "http://bazel-mirror.storage.googleapis.com/llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz",
      amd64_sha256 = "3120c3055ea78bbbb6848510a2af70c68538b990cb0545bac8dad01df8ff69d7",
      macos_url = "http://bazel-mirror.storage.googleapis.com/llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-apple-darwin.tar.xz",
      macos_sha256 = "e5a961e04b0e1738bbb5b824886a34932dc13b0af699d1fe16519d814d7b776f",
  )

def closure_compiler():
  native.maven_jar(
      name = "closure_compiler",
      artifact = "com.google.javascript:closure-compiler-unshaded:v20160822",
      sha1 = "227153aedf239124c2b0c5a680e912c95480fbe6",
      server = "closure_maven_server",
  )

def closure_library():
  # To update Closure Library, one needs to uncomment and run the
  # js_library_files_maker and js_testing_files_maker genrules in
  # closure_library.BUILD.
  native.new_http_archive(
      name = "closure_library",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/closure-library/archive/v20160822.tar.gz",
      sha256 = "5430fa398f40059713fe06dd204333601bd398db92bf07cb7bab56c7fb887d5d",
      strip_prefix = "closure-library-20160822",
      build_file = str(Label("//closure/library:closure_library.BUILD")),
  )

def closure_maven_server():
  native.maven_server(
      name = "closure_maven_server",
      url = "http://bazel-mirror.storage.googleapis.com/repo1.maven.org/maven2/",
  )

def closure_stylesheets():
  native.maven_jar(
      name = "closure_stylesheets",
      artifact = "com.google.closure-stylesheets:closure-stylesheets:1.3.0",
      sha1 = "52be53d0f5be5cc65a3a87dd69ecdaacfb427b66",
      server = "closure_maven_server",
  )

def fonts_noto_hinted_deb():
  native.http_file(
      name = "fonts_noto_hinted_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-hinted_20160116-1_all.deb",
      sha256 = "25b362c9437a7859ce034f22d94b698e8ed25007b443e5a26228ed5b3d2d32d4",
  )

def fonts_noto_mono_deb():
  native.http_file(
      name = "fonts_noto_mono_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-mono_20160116-1_all.deb",
      sha256 = "74b457715f275ed893998a70d6bc955f67da6d36b36b422dbeeb045160edacb6",
  )

def gson():
  native.maven_jar(
      name = "gson",
      artifact = "com.google.code.gson:gson:2.7",
      sha1 = "751f548c85fa49f330cecbb1875893f971b33c4e",
      server = "closure_maven_server",
  )

def guava():
  native.maven_jar(
      name = "guava",
      artifact = "com.google.guava:guava:19.0",
      sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
      server = "closure_maven_server",
  )

def guice():
  native.maven_jar(
      name = "guice",
      artifact = "com.google.inject:guice:3.0",
      sha1 = "9d84f15fe35e2c716a02979fb62f50a29f38aefa",
      server = "closure_maven_server",
  )

def guice_assistedinject():
  native.maven_jar(
      name = "guice_assistedinject",
      artifact = "com.google.inject.extensions:guice-assistedinject:3.0",
      sha1 = "544449ddb19f088dcde44f055d30a08835a954a7",
      server = "closure_maven_server",
  )

def guice_multibindings():
  native.maven_jar(
      name = "guice_multibindings",
      artifact = "com.google.inject.extensions:guice-multibindings:3.0",
      sha1 = "5e670615a927571234df68a8b1fe1a16272be555",
      server = "closure_maven_server",
  )

def icu4j():
  native.maven_jar(
      name = "icu4j",
      artifact = "com.ibm.icu:icu4j:57.1",
      sha1 = "198ea005f41219f038f4291f0b0e9f3259730e92",
      server = "closure_maven_server",
  )

def incremental_dom():
  # To update Incremental DOM, one needs to update
  # third_party/incremental_dom/build.sh to remain compatible with the
  # upstream "js-closure" gulpfile.js target.
  # https://github.com/google/incremental-dom/blob/master/gulpfile.js
  native.http_file(
      name = "incremental_dom",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/incremental-dom/archive/0.5.0.tar.gz",
      sha256 = "bb268af74c411c84372fb9926021859f1ebdbeff86d4ec3e8865758f10482fda",
  )

def json():
  native.maven_jar(
      name = "json",
      artifact = "org.json:json:20160212",
      sha1 = "a742e3f85161835b95877478c5dd5b405cefaab9",
      server = "closure_maven_server",
  )

def jsr305():
  native.maven_jar(
      name = "jsr305",
      artifact = "com.google.code.findbugs:jsr305:1.3.9",
      sha1 = "40719ea6961c0cb6afaeb6a921eaa1f6afd4cfdf",
      server = "closure_maven_server",
  )

def jsr330_inject():
  native.maven_jar(
      name = "jsr330_inject",
      artifact = "javax.inject:javax.inject:1",
      sha1 = "6975da39a7040257bd51d21a231b76c915872d38",
      server = "closure_maven_server",
  )

def libexpat_amd64_deb():
  native.http_file(
      name = "libexpat_amd64_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/e/expat/libexpat1_2.1.0-6+deb8u1_amd64.deb",
      sha256 = "1b006e659f383e09909595d8b84b79828debd7323d00e8a28b72ccd902273861",
  )

def libfontconfig_amd64_deb():
  native.http_file(
      name = "libfontconfig_amd64_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3_amd64.deb",
      sha256 = "2b21f91c8b46caba41221f1e45c5a37cac08ce1298dd7a28442f1b7332fa211b",
  )

def libfreetype_amd64_deb():
  native.http_file(
      name = "libfreetype_amd64_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.5.2-3+deb8u1_amd64.deb",
      sha256 = "80184d932f9b0acc130af081c60a2da114c7b1e7531c18c63174498fae47d862",
  )

def libpng_amd64_deb():
  native.http_file(
      name = "libpng_amd64_deb",
      url = "http://bazel-mirror.storage.googleapis.com/http.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb",
      sha256 = "a57b6d53169c67a7754719f4b742c96554a18f931ca5b9e0408fb6502bb77e80",
  )

def phantomjs():
  platform_http_file(
      name = "phantomjs",
      amd64_url = "http://bazel-mirror.storage.googleapis.com/bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2",
      amd64_sha256 = "86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f",
      macos_url = "http://bazel-mirror.storage.googleapis.com/bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-macosx.zip",
      macos_sha256 = "538cf488219ab27e309eafc629e2bcee9976990fe90b1ec334f541779150f8c1",
)

def protobuf_java():
  native.maven_jar(
      name = "protobuf_java",
      artifact = "com.google.protobuf:protobuf-java:3.0.0-beta-3",
      sha1 = "ed8c2f9a63cfa770292f8173fd0172bdaa014fe3",
      server = "closure_maven_server",
  )

def protobuf_js():
  native.new_http_archive(
      name = "protobuf_js",
      # TODO(hochhaus): Use protobuf-js-*.zip once it includes encoder.js.
      # https://github.com/google/protobuf/pull/1589
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/protobuf/archive/v3.0.0-beta-3.zip",
      sha256 = "dad1912814e9d9b8642036d07c086ac79faf2cc534c992911375a39924a45860",
      strip_prefix = "protobuf-3.0.0-beta-3",
      build_file = str(Label("//closure/protobuf:protobuf_js.BUILD")),
  )

def protoc_linux_x86_64():
  native.http_file(
      name = "protoc_linux_x86_64",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/protobuf/releases/download/v3.0.0-beta-3/protoc-3.0.0-beta-3-linux-x86_64.zip",
      sha256 = "48c592c6272e2a5043de792ff00ff162fe6f9bebd60147b05888b08f8d0e434b",
  )

def protoc_macosx():
  native.http_file(
      name = "protoc_macosx",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/protobuf/releases/download/v3.0.0-beta-3/protoc-3.0.0-beta-3-osx-x86_64.zip",
      sha256 = "b009b2b433affcf00dbe645d0637139f9a6c1e38c2c7d4cc99c30919f5c2eaac",
  )

def safe_html_types():
  native.maven_jar(
      name = "safe_html_types",
      # TODO(hochhaus): Update to 1.0.5 once upstream jar includes dependencies
      # https://github.com/google/safe-html-types/issues/1
      artifact = "com.google.common.html.types:types:1.0.4",
      sha1 = "2adf4c8bfccc0ff7346f9186ac5aa57d829ad065",
      server = "closure_maven_server",
  )

def safe_html_types_html_proto():
  native.http_file(
      name = "safe_html_types_html_proto",
      sha256 = "f91252c91cdbb11ff3c65fae78daeeb5870c10de64e95efbb589763e84b886f8",
      url = "http://bazel-mirror.storage.googleapis.com/github.com/google/safe-html-types/archive/release-1.0.5.tar.gz",
  )

def soy():
  native.maven_jar(
      name = "soy",
      artifact = "com.google.template:soy:2016-08-25",
      sha1 = "bb2a8a8b08f0668abc80e5b25eaffca000cecf57",
      server = "closure_maven_server",
  )

def soy_jssrc():
  native.http_file(
      name = "soy_jssrc",
      sha256 = "15f5bf0b8ca40211a29bcd6486bd3198155ecc76e8bbf06407deb695ca848be6",
      url = "http://bazel-mirror.storage.googleapis.com/repo1.maven.org/maven2/com/google/template/soy/2016-08-25/soy-2016-08-25-jssrc_js.jar",
  )
