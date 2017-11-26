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

load("//closure/private:java_import_external.bzl", "java_import_external")
load("//closure/private:platform_http_file.bzl", "platform_http_file")
load("//closure:filegroup_external.bzl", "filegroup_external")

def closure_repositories(
    omit_aopalliance=False,
    omit_args4j=False,
    omit_clang=False,
    omit_com_google_auto_common=False,
    omit_com_google_auto_factory=False,
    omit_com_google_auto_value=False,
    omit_com_google_closure_stylesheets=False,
    omit_com_google_code_findbugs_jsr305=False,
    omit_com_google_code_gson=False,
    omit_com_google_common_html_types=False,
    omit_com_google_common_html_types_html_proto=False,
    omit_com_google_dagger=False,
    omit_com_google_dagger_compiler=False,
    omit_com_google_dagger_producers=False,
    omit_com_google_errorprone_error_prone_annotations=False,
    omit_com_google_guava=False,
    omit_com_google_inject_extensions_guice_assistedinject=False,
    omit_com_google_inject_extensions_guice_multibindings=False,
    omit_com_google_inject_guice=False,
    omit_com_google_javascript_closure_compiler=False,
    omit_com_google_javascript_closure_library=False,
    omit_com_google_javascript_incremental_dom=False,
    omit_com_google_jsinterop_annotations=False,
    omit_com_google_protobuf_java=False,
    omit_com_google_protobuf_js=False,
    omit_com_google_protobuf_protoc=False,
    omit_com_google_template_soy=False,
    omit_com_google_template_soy_jssrc=False,
    omit_com_ibm_icu_icu4j=False,
    omit_com_squareup_javawriter=False,
    omit_fonts_noto_hinted_deb=False,
    omit_fonts_noto_mono_deb=False,
    omit_javax_annotation_jsr250_api=False,
    omit_javax_inject=False,
    omit_libexpat_amd64_deb=False,
    omit_libfontconfig_amd64_deb=False,
    omit_libfreetype_amd64_deb=False,
    omit_libpng_amd64_deb=False,
    omit_org_json=False,
    omit_org_jsoup=False,
    omit_org_ow2_asm=False,
    omit_org_ow2_asm_analysis=False,
    omit_org_ow2_asm_commons=False,
    omit_org_ow2_asm_tree=False,
    omit_org_ow2_asm_util=False,
    omit_phantomjs=False):
  """Imports dependencies for Closure Rules."""
  _check_bazel_version("Closure Rules", "0.4.5")
  if not omit_aopalliance:
    aopalliance()
  if not omit_args4j:
    args4j()
  if not omit_clang:
    clang()
  if not omit_com_google_auto_common:
    com_google_auto_common()
  if not omit_com_google_auto_common:
    com_google_auto_factory()
  if not omit_com_google_auto_factory:
    com_google_auto_value()
  if not omit_com_google_closure_stylesheets:
    com_google_closure_stylesheets()
  if not omit_com_google_code_findbugs_jsr305:
    com_google_code_findbugs_jsr305()
  if not omit_com_google_code_gson:
    com_google_code_gson()
  if not omit_com_google_common_html_types:
    com_google_common_html_types()
  if not omit_com_google_common_html_types_html_proto:
    com_google_common_html_types_html_proto()
  if not omit_com_google_dagger:
    com_google_dagger()
  if not omit_com_google_dagger_compiler:
    com_google_dagger_compiler()
  if not omit_com_google_dagger_producers:
    com_google_dagger_producers()
  if not omit_com_google_errorprone_error_prone_annotations:
    com_google_errorprone_error_prone_annotations()
  if not omit_com_google_guava:
    com_google_guava()
  if not omit_com_google_inject_extensions_guice_assistedinject:
    com_google_inject_extensions_guice_assistedinject()
  if not omit_com_google_inject_extensions_guice_multibindings:
    com_google_inject_extensions_guice_multibindings()
  if not omit_com_google_inject_guice:
    com_google_inject_guice()
  if not omit_com_google_javascript_closure_compiler:
    com_google_javascript_closure_compiler()
  if not omit_com_google_javascript_closure_library:
    com_google_javascript_closure_library()
  if not omit_com_google_javascript_incremental_dom:
    com_google_javascript_incremental_dom()
  if not omit_com_google_jsinterop_annotations:
    com_google_jsinterop_annotations()
  if not omit_com_google_protobuf_java:
    com_google_protobuf_java()
  if not omit_com_google_protobuf_js:
    com_google_protobuf_js()
  if not omit_com_google_protobuf_protoc:
    com_google_protobuf_protoc()
  if not omit_com_google_template_soy:
    com_google_template_soy()
  if not omit_com_google_template_soy_jssrc:
    com_google_template_soy_jssrc()
  if not omit_com_ibm_icu_icu4j:
    com_ibm_icu_icu4j()
  if not omit_com_squareup_javawriter:
    com_squareup_javawriter()
  if not omit_fonts_noto_hinted_deb:
    fonts_noto_hinted_deb()
  if not omit_fonts_noto_mono_deb:
    fonts_noto_mono_deb()
  if not omit_javax_annotation_jsr250_api:
    javax_annotation_jsr250_api()
  if not omit_javax_inject:
    javax_inject()
  if not omit_libexpat_amd64_deb:
    libexpat_amd64_deb()
  if not omit_libfontconfig_amd64_deb:
    libfontconfig_amd64_deb()
  if not omit_libfreetype_amd64_deb:
    libfreetype_amd64_deb()
  if not omit_libpng_amd64_deb:
    libpng_amd64_deb()
  if not omit_org_json:
    org_json()
  if not omit_org_jsoup:
    org_jsoup()
  if not omit_org_ow2_asm:
    org_ow2_asm()
  if not omit_org_ow2_asm_analysis:
    org_ow2_asm_analysis()
  if not omit_org_ow2_asm_commons:
    org_ow2_asm_commons()
  if not omit_org_ow2_asm_tree:
    org_ow2_asm_tree()
  if not omit_org_ow2_asm_util:
    org_ow2_asm_util()
  if not omit_phantomjs:
    phantomjs()

def _check_bazel_version(project, bazel_version):
  if "bazel_version" not in dir(native):
    fail("%s requires Bazel >=%s but was <0.2.1" % (project, bazel_version))
  elif not native.bazel_version:
    pass  # user probably compiled Bazel from scratch
  else:
    current_bazel_version = _parse_bazel_version(native.bazel_version)
    minimum_bazel_version = _parse_bazel_version(bazel_version)
    if minimum_bazel_version > current_bazel_version:
      fail("%s requires Bazel >=%s but was %s" % (
          project, bazel_version, native.bazel_version))

def _parse_bazel_version(bazel_version):
  # Remove commit from version.
  version = bazel_version.split(" ", 1)[0]
  # Split into (release, date) parts and only return the release
  # as a tuple of integers.
  parts = version.split("-", 1)
  # Turn "release" into a tuple of strings
  version_tuple = ()
  for number in parts[0].split("."):
    version_tuple += (str(number),)
  return version_tuple

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
#          url="https://repo1.maven.org/maven2/${BASH_REMATCH[1]//.//}/${BASH_REMATCH[2]}/${BASH_REMATCH[3]}/${BASH_REMATCH[2]}-${BASH_REMATCH[3]}.jar"
#        fi
#        local dest="gs://bazel-mirror/${url#http*//}"
#        local desturl="https://mirror.bazel.build/${url#http*//}"
#        local name="$(basename "${dest}")"
#        wget -O "/tmp/${name}" "${url}" || return 1
#        gsutil cp -a public-read "/tmp/${name}" "${dest}" || return 1
#        gsutil setmeta -h 'Cache-Control:public, max-age=31536000' "${dest}" || return 1
#        curl -I "${desturl}"
#        echo
#        sha1sum "/tmp/${name}"
#        sha256sum "/tmp/${name}"
#        echo "${desturl}"
#        rm "/tmp/${name}" || return 1
#      }

def aopalliance():
  java_import_external(
      name = "aopalliance",
      jar_sha256 = "0addec670fedcd3f113c5c8091d783280d23f75e3acb841b61a9cdb079376a08",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar",
          "https://repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar",
          "http://maven.ibiblio.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar",
      ],
      licenses = ["unencumbered"],  # public domain
  )

def args4j():
  java_import_external(
      name = "args4j",
      jar_sha256 = "989bda2321ea073a03686e9d4437ea4928c72c99f993f9ca6fab24615f0771a4",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/args4j/args4j/2.0.26/args4j-2.0.26.jar",
          "https://repo1.maven.org/maven2/args4j/args4j/2.0.26/args4j-2.0.26.jar",
          "http://maven.ibiblio.org/maven2/args4j/args4j/2.0.26/args4j-2.0.26.jar",
      ],
      licenses = ["notice"],  # MIT License
  )

def clang():
  platform_http_file(
      name = "clang",
      amd64_urls = [
          "https://mirror.bazel.build/llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz",
          "http://llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz",
      ],
      amd64_sha256 = "3120c3055ea78bbbb6848510a2af70c68538b990cb0545bac8dad01df8ff69d7",
      macos_urls = [
          "https://mirror.bazel.build/llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-apple-darwin.tar.xz",
          "http://llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-apple-darwin.tar.xz",
      ],
      macos_sha256 = "e5a961e04b0e1738bbb5b824886a34932dc13b0af699d1fe16519d814d7b776f",
  )

def com_google_auto_common():
  java_import_external(
      name = "com_google_auto_common",
      jar_sha256 = "eee75e0d1b1b8f31584dcbe25e7c30752545001b46673d007d468d75cf6b2c52",
      jar_urls = [
          "http://domain-registry-maven.storage.googleapis.com/repo1.maven.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
          "https://repo1.maven.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
          "http://maven.ibiblio.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
      deps = ["@com_google_guava"],
  )

def com_google_auto_factory():
  java_import_external(
      name = "com_google_auto_factory",
      licenses = ["notice"],  # Apache 2.0
      jar_sha256 = "a038e409da90b9e065ec537cce2375b0bb0b07548dca0f9448671b0befb83439",
      jar_urls = [
          "http://domain-registry-maven.storage.googleapis.com/repo1.maven.org/maven2/com/google/auto/factory/auto-factory/1.0-beta3/auto-factory-1.0-beta3.jar",
          "http://maven.ibiblio.org/maven2/com/google/auto/factory/auto-factory/1.0-beta3/auto-factory-1.0-beta3.jar",
          "https://repo1.maven.org/maven2/com/google/auto/factory/auto-factory/1.0-beta3/auto-factory-1.0-beta3.jar",
      ],
      # Auto Factory ships its annotations, runtime, and processor in the same
      # jar. The generated code must link against this jar at runtime. So our
      # goal is to introduce as little bloat as possible.The only class we need
      # at runtime is com.google.auto.factory.internal.Preconditions. So we're
      # not going to specify the deps of this jar as part of the java_import().
      generated_rule_name = "jar",
      extra_build_file_content = "\n".join([
          "java_library(",
          "    name = \"processor\",",
          "    exports = [\":jar\"],",
          "    runtime_deps = [",
          "        \"@com_google_auto_common\",",
          "        \"@com_google_guava\",",
          "        \"@com_squareup_javawriter\",",
          "        \"@javax_inject\",",
          "    ],",
          ")",
          "",
          "java_plugin(",
          "    name = \"AutoFactoryProcessor\",",
          "    output_licenses = [\"unencumbered\"],",
          "    processor_class = \"com.google.auto.factory.processor.AutoFactoryProcessor\",",
          "    generates_api = 1,",
          "    tags = [\"annotation=com.google.auto.factory.AutoFactory;genclass=${package}.${outerclasses}@{className|${classname}Factory}\"],",
          "    deps = [\":processor\"],",
          ")",
          "",
          "java_library(",
          "    name = \"com_google_auto_factory\",",
          "    exported_plugins = [\":AutoFactoryProcessor\"],",
          "    exports = [",
          "        \":jar\",",
          "        \"@com_google_code_findbugs_jsr305\",",
          "        \"@javax_inject\",",
          "    ],",
          ")",
      ]),
  )

def com_google_auto_value():
  java_import_external(
      name = "com_google_auto_value",
      jar_sha256 = "ea26f99150825f61752efc8784739cf50dd25d7956774573f8cdc3b948b23086",
      jar_urls = [
          "http://domain-registry-maven.storage.googleapis.com/repo1.maven.org/maven2/com/google/auto/value/auto-value/1.4-rc2/auto-value-1.4-rc2.jar",
          "https://repo1.maven.org/maven2/com/google/auto/value/auto-value/1.4-rc2/auto-value-1.4-rc2.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
      neverlink = True,
      generated_rule_name = "compile",
      generated_linkable_rule_name = "processor",
      deps = [
          "@com_google_auto_common",
          "@com_google_code_findbugs_jsr305",
          "@com_google_guava",
      ],
      extra_build_file_content = "\n".join([
          "java_plugin(",
          "    name = \"AutoAnnotationProcessor\",",
          "    output_licenses = [\"unencumbered\"],",
          "    processor_class = \"com.google.auto.value.processor.AutoAnnotationProcessor\",",
          "    tags = [\"annotation=com.google.auto.value.AutoAnnotation;genclass=${package}.AutoAnnotation_${outerclasses}${classname}_${methodname}\"],",
          "    deps = [\":processor\"],",
          ")",
          "",
          "java_plugin(",
          "    name = \"AutoValueProcessor\",",
          "    output_licenses = [\"unencumbered\"],",
          "    processor_class = \"com.google.auto.value.processor.AutoValueProcessor\",",
          "    tags = [\"annotation=com.google.auto.value.AutoValue;genclass=${package}.AutoValue_${outerclasses}${classname}\"],",
          "    deps = [\":processor\"],",
          ")",
          "",
          "java_library(",
          "    name = \"com_google_auto_value\",",
          "    exported_plugins = [",
          "        \":AutoAnnotationProcessor\",",
          "        \":AutoValueProcessor\",",
          "    ],",
          "    exports = [",
          "        \":compile\",",
          "        \"@com_google_code_findbugs_jsr305\",",
          "    ],",
          ")",
      ]),
  )

def com_google_closure_stylesheets():
  java_import_external(
      name = "com_google_closure_stylesheets",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/closure-stylesheets/closure-stylesheets/1.4.0/closure-stylesheets-1.4.0.jar",
          "https://repo1.maven.org/maven2/com/google/closure-stylesheets/closure-stylesheets/1.4.0/closure-stylesheets-1.4.0.jar",
          "http://maven.ibiblio.org/maven2/com/google/closure-stylesheets/closure-stylesheets/1.4.0/closure-stylesheets-1.4.0.jar",
      ],
      jar_sha256 = "4038c17fa38a90983fe4030a63ff8a644ed53a48187f55f3c4c3487fe9ad9f97",
      deps = [
          "@args4j",
          "@com_google_javascript_closure_compiler",
          "@com_google_code_gson",
          "@com_google_guava",
          "@com_google_code_findbugs_jsr305",
      ],
      extra_build_file_content = "\n".join([
          "java_binary(",
          "    name = \"ClosureCommandLineCompiler\",",
          "    main_class = \"com.google.common.css.compiler.commandline.ClosureCommandLineCompiler\",",
          "    output_licenses = [\"unencumbered\"],",
          "    runtime_deps = [\":com_google_closure_stylesheets\"],",
          ")",
      ]),
  )

def com_google_code_findbugs_jsr305():
  java_import_external(
      name = "com_google_code_findbugs_jsr305",
      licenses = ["notice"],  # BSD 3-clause
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/code/findbugs/jsr305/2.0.3/jsr305-2.0.3.jar",
          "https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/2.0.3/jsr305-2.0.3.jar",
          "http://maven.ibiblio.org/maven2/com/google/code/findbugs/jsr305/2.0.3/jsr305-2.0.3.jar",
      ],
      jar_sha256 = "bec0b24dcb23f9670172724826584802b80ae6cbdaba03bdebdef9327b962f6a",
  )

def com_google_code_gson():
  java_import_external(
      name = "com_google_code_gson",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar",
          "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar",
          "http://maven.ibiblio.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar",
      ],
      jar_sha256 = "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32",
      deps = ["@com_google_code_findbugs_jsr305"],
  )

def com_google_common_html_types():
  java_import_external(
      name = "com_google_common_html_types",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/common/html/types/types/1.0.7/types-1.0.7.jar",
          "https://repo1.maven.org/maven2/com/google/common/html/types/types/1.0.7/types-1.0.7.jar",
      ],
      jar_sha256 = "78b6baa2ecc56435dc0ae88c57f442bd2d07127cb50424d400441ddccc45ea24",
      deps = [
          "@com_google_code_findbugs_jsr305",
          "@com_google_errorprone_error_prone_annotations",
          "@com_google_guava",
          "@com_google_jsinterop_annotations",
          "@com_google_protobuf_java//:protobuf_java",
          "@javax_annotation_jsr250_api",
      ],
  )

def com_google_common_html_types_html_proto():
  native.http_file(
      name = "com_google_common_html_types_html_proto",
      sha256 = "6ece202f11574e37d0c31d9cf2e9e11a0dbc9218766d50d211059ebd495b49c3",
      urls = [
          "https://mirror.bazel.build/raw.githubusercontent.com/google/safe-html-types/release-1.0.5/proto/src/main/protobuf/webutil/html/types/proto/html.proto",
          "https://raw.githubusercontent.com/google/safe-html-types/release-1.0.5/proto/src/main/protobuf/webutil/html/types/proto/html.proto",
      ],
  )

def com_google_dagger():
  java_import_external(
      name = "com_google_dagger",
      jar_sha256 = "8b7806518bed270950002158934fbd8281725ee09909442f2f22b58520b667a7",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger/2.9/dagger-2.9.jar",
          "https://repo1.maven.org/maven2/com/google/dagger/dagger/2.9/dagger-2.9.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
      deps = ["@javax_inject"],
      generated_rule_name = "runtime",
      extra_build_file_content = "\n".join([
          "java_library(",
          "    name = \"com_google_dagger\",",
          "    exported_plugins = [\"@com_google_dagger_compiler//:ComponentProcessor\"],",
          "    exports = [",
          "        \":runtime\",",
          "        \"@javax_inject\",",
          "    ],",
          ")",
      ]),
  )

def com_google_dagger_compiler():
  java_import_external(
      name = "com_google_dagger_compiler",
      jar_sha256 = "afe356def27710db5b60cad8e7a6c06510dc3d3b854f30397749cbf0d0e71315",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger-compiler/2.9/dagger-compiler-2.9.jar",
          "https://repo1.maven.org/maven2/com/google/dagger/dagger-compiler/2.9/dagger-compiler-2.9.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
      deps = [
          "@com_google_code_findbugs_jsr305",
          "@com_google_dagger//:runtime",
          "@com_google_dagger_producers//:runtime",
          "@com_google_guava",
      ],
      extra_build_file_content = "\n".join([
          "java_plugin(",
          "    name = \"ComponentProcessor\",",
          "    output_licenses = [\"unencumbered\"],",
          "    processor_class = \"dagger.internal.codegen.ComponentProcessor\",",
          "    generates_api = 1,",
          "    tags = [",
          "        \"annotation=dagger.Component;genclass=${package}.Dagger${outerclasses}${classname}\",",
          "        \"annotation=dagger.producers.ProductionComponent;genclass=${package}.Dagger${outerclasses}${classname}\",",
          "    ],",
          "    deps = [\":com_google_dagger_compiler\"],",
          ")",
      ]),
  )

def com_google_dagger_producers():
  java_import_external(
      name = "com_google_dagger_producers",
      jar_sha256 = "b452dc1b95dd02f6272e97b15d1bd35d92b5f484a7d69bb73887b6c6699d8843",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger-producers/2.9/dagger-producers-2.9.jar",
          "https://repo1.maven.org/maven2/com/google/dagger/dagger-producers/2.9/dagger-producers-2.9.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
      deps = [
          "@com_google_dagger//:runtime",
          "@com_google_guava",
      ],
      generated_rule_name = "runtime",
      extra_build_file_content = "\n".join([
          "java_library(",
          "    name = \"com_google_dagger_producers\",",
          "    exported_plugins = [\"@com_google_dagger_compiler//:ComponentProcessor\"],",
          "    exports = [",
          "        \":runtime\",",
          "        \"@com_google_dagger//:runtime\",",
          "        \"@javax_inject\",",
          "    ],",
          ")",
      ]),
  )

def com_google_errorprone_error_prone_annotations():
  java_import_external(
      name = "com_google_errorprone_error_prone_annotations",
      licenses = ["notice"],  # Apache 2.0
      jar_sha256 = "cde78ace21e46398299d0d9c6be9f47b7f971c7f045d40c78f95be9a638cbf7e",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.0.19/error_prone_annotations-2.0.19.jar",
          "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.0.19/error_prone_annotations-2.0.19.jar",
      ],
  )

def com_google_guava():
  java_import_external(
      name = "com_google_guava",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/guava/20.0/guava-20.0.jar",
          "https://repo1.maven.org/maven2/com/google/guava/guava/20.0/guava-20.0.jar",
          "http://maven.ibiblio.org/maven2/com/google/guava/guava/20.0/guava-20.0.jar",
      ],
      jar_sha256 = "36a666e3b71ae7f0f0dca23654b67e086e6c93d192f60ba5dfd5519db6c288c8",
      exports = [
          "@com_google_code_findbugs_jsr305",
          "@com_google_errorprone_error_prone_annotations",
      ],
  )

def com_google_inject_extensions_guice_assistedinject():
  java_import_external(
      name = "com_google_inject_extensions_guice_assistedinject",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/inject/extensions/guice-assistedinject/4.1.0/guice-assistedinject-4.1.0.jar",
          "https://repo1.maven.org/maven2/com/google/inject/extensions/guice-assistedinject/4.1.0/guice-assistedinject-4.1.0.jar",
          "http://maven.ibiblio.org/maven2/com/google/inject/extensions/guice-assistedinject/4.1.0/guice-assistedinject-4.1.0.jar",
      ],
      jar_sha256 = "663728123fb9a6b79ea39ae289e5d56b4113e1b8e9413eb792f91e53a6dd5868",
      deps = [
          "@com_google_guava",
          "@com_google_inject_guice",
          "@javax_inject",
      ],
  )

def com_google_inject_extensions_guice_multibindings():
  java_import_external(
      name = "com_google_inject_extensions_guice_multibindings",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/inject/extensions/guice-multibindings/4.1.0/guice-multibindings-4.1.0.jar",
          "https://repo1.maven.org/maven2/com/google/inject/extensions/guice-multibindings/4.1.0/guice-multibindings-4.1.0.jar",
          "http://maven.ibiblio.org/maven2/com/google/inject/extensions/guice-multibindings/4.1.0/guice-multibindings-4.1.0.jar",
      ],
      jar_sha256 = "592773a4c745cc87ba37fa0647fed8126c7e474349c603c9f229aa25d3ef5448",
      deps = [
          "@com_google_guava",
          "@com_google_inject_guice",
          "@javax_inject",
      ],
  )

def com_google_inject_guice():
  java_import_external(
      name = "com_google_inject_guice",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/inject/guice/4.1.0/guice-4.1.0.jar",
          "https://repo1.maven.org/maven2/com/google/inject/guice/4.1.0/guice-4.1.0.jar",
          "http://maven.ibiblio.org/maven2/com/google/inject/guice/4.1.0/guice-4.1.0.jar",
      ],
      jar_sha256 = "9b9df27a5b8c7864112b4137fd92b36c3f1395bfe57be42fedf2f520ead1a93e",
      deps = [
          "@aopalliance",
          "@org_ow2_asm",
          "@com_google_guava",
          "@com_google_code_findbugs_jsr305",
          "@javax_inject",
      ],
  )

def com_google_javascript_closure_compiler():
  java_import_external(
      name = "com_google_javascript_closure_compiler",
      licenses = ["reciprocal"],  # MPL v1.1 (Rhino AST), Apache 2.0 (JSCompiler)
      jar_urls = [
          "http://mirror.bazel.build/repo1.maven.org/maven2/com/google/javascript/closure-compiler-unshaded/v20171023/closure-compiler-unshaded-v20171023.jar",
          "http://repo1.maven.org/maven2/com/google/javascript/closure-compiler-unshaded/v20171023/closure-compiler-unshaded-v20171023.jar",
      ],
      jar_sha256 = "90d274556466785adbf77b091e7acda17ffd1c17b01262573aa1723dc97cdba0",
      deps = [
          "@com_google_code_gson",
          "@com_google_guava",
          "@com_google_code_findbugs_jsr305",
          "@com_google_protobuf_java//:protobuf_java",
      ],
      extra_build_file_content = "\n".join([
          "java_binary(",
          "    name = \"main\",",
          "    main_class = \"com.google.javascript.jscomp.CommandLineRunner\",",
          "    output_licenses = [\"unencumbered\"],",
          "    runtime_deps = [",
          "        \":com_google_javascript_closure_compiler\",",
          "        \"@args4j\",",
          "    ],",
          ")",
      ]),
  )

def com_google_javascript_closure_library():
  # To update Closure Library, one needs to uncomment and run the
  # js_library_files_maker and js_testing_files_maker genrules in
  # closure_library.BUILD.
  native.new_http_archive(
      name = "com_google_javascript_closure_library",
      urls = [
          "http://mirror.bazel.build/github.com/google/closure-library/archive/v20170910.tar.gz",
          "https://github.com/google/closure-library/archive/v20170910.tar.gz",
      ],
      sha256 = "2b98ddcc6171eb2350f4db9d3ae65169916ca375337e2475ec8dd92e8d3f89ee",
      strip_prefix = "closure-library-20170910",
      build_file = str(Label("//closure/library:closure_library.BUILD")),
  )

def com_google_javascript_incremental_dom():
  # To update Incremental DOM, one needs to update
  # third_party/javascript/incremental_dom/build.sh to remain compatible with
  # the upstream "js-closure" gulpfile.js target.
  # https://github.com/google/incremental-dom/blob/master/gulpfile.js
  native.http_file(
      name = "com_google_javascript_incremental_dom",
      urls = [
          "https://mirror.bazel.build/github.com/google/incremental-dom/archive/0.5.2.tar.gz",
          "https://github.com/google/incremental-dom/archive/0.5.2.tar.gz",
      ],
      sha256 = "554a778dff5cba561a98619b2f3de5061848744644c870f718e2cdcf9bf0dccf",
  )

def com_google_jsinterop_annotations():
  java_import_external(
      name = "com_google_jsinterop_annotations",
      licenses = ["notice"],  # GWT Terms
      jar_sha256 = "b2cc45519d62a1144f8cd932fa0c2c30a944c3ae9f060934587a337d81b391c8",
      jar_urls = [
          "https://mirror.bazel.build/maven.ibiblio.org/maven2/com/google/jsinterop/jsinterop-annotations/1.0.1/jsinterop-annotations-1.0.1.jar",
          "http://maven.ibiblio.org/maven2/com/google/jsinterop/jsinterop-annotations/1.0.1/jsinterop-annotations-1.0.1.jar",
          "https://repo1.maven.org/maven2/com/google/jsinterop/jsinterop-annotations/1.0.1/jsinterop-annotations-1.0.1.jar",
      ],
  )

def com_google_protobuf_java():
  native.http_archive(
      name = "com_google_protobuf_java",
      sha256 = "0cc6607e2daa675101e9b7398a436f09167dffb8ca0489b0307ff7260498c13c",
      strip_prefix = "protobuf-3.5.0",
      urls = [
        "https://mirror.bazel.build/github.com/google/protobuf/archive/v3.5.0.tar.gz",
        "https://github.com/google/protobuf/archive/v3.5.0.tar.gz",
      ],
  )

def com_google_protobuf_js():
  native.new_http_archive(
      name = "com_google_protobuf_js",
      urls = [
          # 3.3.0 has a Closure Compiler bug because it references Node's Buffer
          # type. This was fixed in f00e06c95bc117fb2ed0ca56c96041c93039f1fe.
          #
          # TODO(jart): Update when https://github.com/google/protobuf/pull/3387
          #             is merged.
          "https://mirror.bazel.build/github.com/google/protobuf/archive/33545583286a31940b6a732b1888e639cdf2e3c4.tar.gz",
          "https://github.com/google/protobuf/archive/33545583286a31940b6a732b1888e639cdf2e3c4.tar.gz",  # 2017-07-17
      ],
      sha256 = "ecd9f92f137e75d140a8b611cd2c0d6c0f34f561946dc5f7fcecde631bb13c25",
      strip_prefix = "protobuf-33545583286a31940b6a732b1888e639cdf2e3c4/js",
      build_file = str(Label("//closure/protobuf:protobuf_js.BUILD")),
  )

def com_google_protobuf_protoc():
  filegroup_external(
      name = "com_google_protobuf_protoc",
      licenses = ["notice"],  # BSD
      sha256_urls_extract_macos = {
          "d752ba0ea67239e327a48b2f23da0e673928a9ff06ee530319fc62200c0aff89": [
              "https://mirror.bazel.build/github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-osx-x86_64.zip",
              "https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-osx-x86_64.zip",
          ],
      },
      sha256_urls_extract_windows = {
          "19ec3d3853c1181912dc442840b3a76bfe0607ecc67d0854b323fdd1fdd8ab77": [
              "https://mirror.bazel.build/github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-win32.zip",
              "https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-win32.zip",
          ],
      },
      sha256_urls_extract = {
          "feb112bbc11ea4e2f7ef89a359b5e1c04428ba6cfa5ee628c410eccbfe0b64c3": [
              "https://mirror.bazel.build/github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip",
              "https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip",
          ],
      },
      generated_rule_name = "files",
      extra_build_file_content = "\n".join([
          "filegroup(",
          "    name = \"com_google_protobuf_protoc\",",
          "    srcs = select({",
          "        \":windows\": [\"bin/protoc.exe\"],",
          "        \":windows_msvc\": [\"bin/protoc.exe\"],",
          "        \"//conditions:default\": [\"bin/protoc\"],",
          "    }),",
          ")",
          "",
          "config_setting(",
          "    name = \"windows\",",
          "    values = {\"cpu\": \"x64_windows\"},",
          "    visibility = [\"//visibility:private\"],",
          ")",
          "",
          "config_setting(",
          "    name = \"windows_msvc\",",
          "    values = {\"cpu\": \"x64_windows_msvc\"},",
          "    visibility = [\"//visibility:private\"],",
          ")",
      ]),
  )

def com_google_template_soy():
  java_import_external(
      name = "com_google_template_soy",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/template/soy/2017-06-22/soy-2017-06-22.jar",
          "https://repo1.maven.org/maven2/com/google/template/soy/2017-06-22/soy-2017-06-22.jar",
      ],
      jar_sha256 = "3c4e61234e9ee9f79411da997e23b201bcf281255469c76d162dac07a67dbb78",
      deps = [
          "@args4j",
          "@com_google_code_findbugs_jsr305",
          "@com_google_code_gson",
          "@com_google_common_html_types",
          "@com_google_guava",
          "@com_google_inject_extensions_guice_assistedinject",
          "@com_google_inject_extensions_guice_multibindings",
          "@com_google_inject_guice",
          "@com_google_protobuf_java//:protobuf_java",
          "@com_ibm_icu_icu4j",
          "@javax_inject",
          "@org_json",
          "@org_ow2_asm",
          "@org_ow2_asm_analysis",
          "@org_ow2_asm_commons",
          "@org_ow2_asm_util",
      ],
      extra_build_file_content = "\n".join([
          ("java_binary(\n" +
           "    name = \"%s\",\n" +
           "    main_class = \"com.google.template.soy.%s\",\n" +
           "    output_licenses = [\"unencumbered\"],\n" +
           "    runtime_deps = [\":com_google_template_soy\"],\n" +
           ")\n") % (name, name)
          for name in ("SoyParseInfoGenerator",
                       "SoyToJbcSrcCompiler",
                       "SoyToJsSrcCompiler",
                       "SoyToPySrcCompiler",
                       "SoyToIncrementalDomSrcCompiler")
      ]),
  )

def com_google_template_soy_jssrc():
  native.new_http_archive(
      name = "com_google_template_soy_jssrc",
      sha256 = "604b363d00fc4712356f0ca37dded83062d46b6c39043fff4d1ae23f5661edac",
      urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/template/soy/2017-06-22/soy-2017-06-22-jssrc_js.jar",
          "https://repo1.maven.org/maven2/com/google/template/soy/2017-06-22/soy-2017-06-22-jssrc_js.jar",
      ],
      build_file = str(Label("//closure/templates:soy_jssrc.BUILD")),
      type = "zip",
  )

def com_ibm_icu_icu4j():
  java_import_external(
      name = "com_ibm_icu_icu4j",
      licenses = ["notice"],  # ICU License (old X License)
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/com/ibm/icu/icu4j/57.1/icu4j-57.1.jar",
          "https://repo1.maven.org/maven2/com/ibm/icu/icu4j/57.1/icu4j-57.1.jar",
          "http://maven.ibiblio.org/maven2/com/ibm/icu/icu4j/57.1/icu4j-57.1.jar",
      ],
      jar_sha256 = "759d89ed2f8c6a6b627ab954be5913fbdc464f62254a513294e52260f28591ee",
  )

def com_squareup_javawriter():
  java_import_external(
      name = "com_squareup_javawriter",
      jar_sha256 = "39b054910ff212d4379129a89070fb7dbb1f341371c925e9e99904f154a22d93",
      jar_urls = [
          "http://domain-registry-maven.storage.googleapis.com/repo1.maven.org/maven2/com/squareup/javawriter/2.5.1/javawriter-2.5.1.jar",
          "http://maven.ibiblio.org/maven2/com/squareup/javawriter/2.5.1/javawriter-2.5.1.jar",
          "https://repo1.maven.org/maven2/com/squareup/javawriter/2.5.1/javawriter-2.5.1.jar",
      ],
      licenses = ["notice"],  # Apache 2.0
  )

def fonts_noto_hinted_deb():
  native.http_file(
      name = "fonts_noto_hinted_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-hinted_20161116-1_all.deb",
          "http://http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-hinted_20161116-1_all.deb",
      ],
      sha256 = "a71fcee2bc7820fc4e0c780bb9c7c6db8364fd2c5bac20867c5c33eed470dc51",
  )

def fonts_noto_mono_deb():
  native.http_file(
      name = "fonts_noto_mono_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-mono_20161116-1_all.deb",
          "http://http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-mono_20161116-1_all.deb",
      ],
      sha256 = "71ff715cf50a74a8cc11b02e7c906b69a242d3d677e739e0b2d18cd23b7de375",
  )

def javax_annotation_jsr250_api():
  java_import_external(
      name = "javax_annotation_jsr250_api",
      licenses = ["reciprocal"],  # CDDL 1.0
      jar_sha256 = "a1a922d0d9b6d183ed3800dfac01d1e1eb159f0e8c6f94736931c1def54a941f",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar",
          "https://repo1.maven.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar",
          "http://maven.ibiblio.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar",
      ],
  )

def javax_inject():
  java_import_external(
      name = "javax_inject",
      licenses = ["notice"],  # Apache 2.0
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar",
          "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar",
          "http://maven.ibiblio.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar",
      ],
      jar_sha256 = "91c77044a50c481636c32d916fd89c9118a72195390452c81065080f957de7ff",
  )

def libexpat_amd64_deb():
  native.http_file(
      name = "libexpat_amd64_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/e/expat/libexpat1_2.1.0-6+deb8u3_amd64.deb",
          "http://http.us.debian.org/debian/pool/main/e/expat/libexpat1_2.1.0-6+deb8u3_amd64.deb",
      ],
      sha256 = "682d2321297c56dec327770efa986d4bef43a5acb1a5528b3098e05652998fae",
  )

def libfontconfig_amd64_deb():
  native.http_file(
      name = "libfontconfig_amd64_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3+deb8u1_amd64.deb",
          "http://http.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3+deb8u1_amd64.deb",
      ],
      sha256 = "0bb54d61c13aa5b5253cb5e08aaca0dfc4c626a05ee30f51d0e3002cda166fec",
  )

def libfreetype_amd64_deb():
  native.http_file(
      name = "libfreetype_amd64_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.5.2-3+deb8u1_amd64.deb",
          "http://http.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.5.2-3+deb8u1_amd64.deb",
      ],
      sha256 = "80184d932f9b0acc130af081c60a2da114c7b1e7531c18c63174498fae47d862",
  )

def libpng_amd64_deb():
  native.http_file(
      name = "libpng_amd64_deb",
      urls = [
          "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb",
          "http://http.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb",
      ],
      sha256 = "a57b6d53169c67a7754719f4b742c96554a18f931ca5b9e0408fb6502bb77e80",
  )

def org_json():
  java_import_external(
      name = "org_json",
      licenses = ["notice"],  # MIT-style license
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/json/json/20160212/json-20160212.jar",
          "https://repo1.maven.org/maven2/org/json/json/20160212/json-20160212.jar",
          "http://maven.ibiblio.org/maven2/org/json/json/20160212/json-20160212.jar",
      ],
      jar_sha256 = "0aaf0e7e286ece88fb60b9ba14dd45c05a48e55618876efb7d1b6f19c25e7a29",
  )

def org_jsoup():
  java_import_external(
      name = "org_jsoup",
      licenses = ["notice"],  # The MIT License
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/jsoup/jsoup/1.10.2/jsoup-1.10.2.jar",
          "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.10.2/jsoup-1.10.2.jar",
      ],
      jar_sha256 = "6ebe6abd7775c10a49407ae22db45c840cd2cdaf715866a5b0b5af70941c3f4a",
  )

def org_ow2_asm():
  java_import_external(
      name = "org_ow2_asm",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm/5.0.3/asm-5.0.3.jar",
          "https://repo1.maven.org/maven2/org/ow2/asm/asm/5.0.3/asm-5.0.3.jar",
          "http://maven.ibiblio.org/maven2/org/ow2/asm/asm/5.0.3/asm-5.0.3.jar",
      ],
      jar_sha256 = "71c4f78e437b8fdcd9cc0dfd2abea8c089eb677005a6a5cff320206cc52b46cc",
      licenses = ["notice"],  # BSD 3-clause
  )

def org_ow2_asm_analysis():
  java_import_external(
      name = "org_ow2_asm_analysis",
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.jar",
          "https://repo1.maven.org/maven2/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.jar",
          "http://maven.ibiblio.org/maven2/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.jar",
      ],
      jar_sha256 = "e8fa2a63462c96557dcd36c25525e1264b77366ff851cf0b94eb7592b290849d",
      licenses = ["notice"],  # BSD 3-clause
      exports = [
          "@org_ow2_asm",
          "@org_ow2_asm_tree",
      ],
  )

def org_ow2_asm_commons():
  java_import_external(
      name = "org_ow2_asm_commons",
      licenses = ["notice"],  # BSD 3-clause
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-commons/5.0.3/asm-commons-5.0.3.jar",
          "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/5.0.3/asm-commons-5.0.3.jar",
          "http://maven.ibiblio.org/maven2/org/ow2/asm/asm-commons/5.0.3/asm-commons-5.0.3.jar",
      ],
      jar_sha256 = "18c1e092230233c9d29e46f21943d769bdb48130cc279e4b0e663f423948c2da",
      exports = ["@org_ow2_asm_tree"],
  )

def org_ow2_asm_tree():
  java_import_external(
      name = "org_ow2_asm_tree",
      licenses = ["notice"],  # BSD 3-clause
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.jar",
          "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.jar",
          "http://maven.ibiblio.org/maven2/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.jar",
      ],
      jar_sha256 = "347a7a9400f9964e87c91d3980e48eebdc8d024bc3b36f7f22189c662853a51c",
      exports = ["@org_ow2_asm"],
  )

def org_ow2_asm_util():
  java_import_external(
      name = "org_ow2_asm_util",
      licenses = ["notice"],  # BSD 3-clause
      jar_urls = [
          "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.jar",
          "https://repo1.maven.org/maven2/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.jar",
          "http://maven.ibiblio.org/maven2/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.jar",
      ],
      jar_sha256 = "2768edbfa2681b5077f08151de586a6d66b916703cda3ab297e58b41ae8f2362",
      exports = [
          "@org_ow2_asm_analysis",
          "@org_ow2_asm_tree",
      ],
  )

def phantomjs():
  platform_http_file(
      name = "phantomjs",
      amd64_urls = [
          "https://mirror.bazel.build/bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2",
          "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2",
      ],
      amd64_sha256 = "86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f",
      macos_urls = [
          "https://mirror.bazel.build/bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-macosx.zip",
          "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-macosx.zip",
      ],
      macos_sha256 = "538cf488219ab27e309eafc629e2bcee9976990fe90b1ec334f541779150f8c1",
  )
