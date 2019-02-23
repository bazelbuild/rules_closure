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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//closure/private:java_import_external.bzl", "java_import_external")
load("//closure/private:platform_http_file.bzl", "platform_http_file")

def closure_repositories(
        omit_aopalliance = False,
        omit_args4j = False,
        omit_clang = False,
        omit_com_google_auto_common = False,
        omit_com_google_auto_factory = False,
        omit_com_google_auto_value = False,
        omit_com_google_auto_value_annotations = False,
        omit_com_google_closure_stylesheets = False,
        omit_com_google_code_findbugs_jsr305 = False,
        omit_com_google_code_gson = False,
        omit_com_google_common_html_types = False,
        omit_com_google_common_html_types_html_proto = False,
        omit_com_google_dagger = False,
        omit_com_google_dagger_compiler = False,
        omit_com_google_dagger_producers = False,
        omit_com_google_dagger_spi = False,
        omit_com_google_errorprone_error_prone_annotations = False,
        omit_com_google_errorprone_javac_shaded = False,
        omit_com_google_guava = False,
        omit_com_google_inject_extensions_guice_assistedinject = False,
        omit_com_google_inject_extensions_guice_multibindings = False,
        omit_com_google_inject_guice = False,
        omit_com_google_java_format = False,
        omit_com_google_javascript_closure_compiler = False,
        omit_com_google_javascript_closure_library = False,
        omit_com_google_jsinterop_annotations = False,
        omit_com_google_protobuf = False,
        omit_com_google_protobuf_java = False,
        omit_com_google_protobuf_js = False,
        omit_com_google_template_soy = False,
        omit_com_google_template_soy_jssrc = False,
        omit_com_ibm_icu_icu4j = False,
        omit_com_squareup_javapoet = False,
        omit_fonts_noto_hinted_deb = False,
        omit_fonts_noto_mono_deb = False,
        omit_javax_annotation_jsr250_api = False,
        omit_javax_inject = False,
        omit_libexpat_amd64_deb = False,
        omit_libfontconfig_amd64_deb = False,
        omit_libfreetype_amd64_deb = False,
        omit_libpng_amd64_deb = False,
        omit_org_json = False,
        omit_org_jsoup = False,
        omit_org_ow2_asm = False,
        omit_org_ow2_asm_analysis = False,
        omit_org_ow2_asm_commons = False,
        omit_org_ow2_asm_tree = False,
        omit_org_ow2_asm_util = False,
        omit_phantomjs = False):
    """Imports dependencies for Closure Rules."""
    if omit_com_google_protobuf_java:
        fail("omit_com_google_protobuf_java no longer supported and must be not be passed to closure_repositories()")
    if not omit_aopalliance:
        aopalliance()
    if not omit_args4j:
        args4j()
    if not omit_clang:
        clang()
    if not omit_com_google_auto_common:
        com_google_auto_common()
    if not omit_com_google_auto_factory:
        com_google_auto_factory()
    if not omit_com_google_auto_value:
        com_google_auto_value()
    if not omit_com_google_auto_value_annotations:
        com_google_auto_value_annotations()
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
    if not omit_com_google_dagger_spi:
        com_google_dagger_spi()
    if not omit_com_google_errorprone_error_prone_annotations:
        com_google_errorprone_error_prone_annotations()
    if not omit_com_google_errorprone_javac_shaded:
        com_google_errorprone_javac_shaded()
    if not omit_com_google_guava:
        com_google_guava()
    if not omit_com_google_inject_extensions_guice_assistedinject:
        com_google_inject_extensions_guice_assistedinject()
    if not omit_com_google_inject_extensions_guice_multibindings:
        com_google_inject_extensions_guice_multibindings()
    if not omit_com_google_inject_guice:
        com_google_inject_guice()
    if not omit_com_google_java_format:
        com_google_java_format()
    if not omit_com_google_javascript_closure_compiler:
        com_google_javascript_closure_compiler()
    if not omit_com_google_javascript_closure_library:
        com_google_javascript_closure_library()
    if not omit_com_google_jsinterop_annotations:
        com_google_jsinterop_annotations()
    if not omit_com_google_protobuf:
        com_google_protobuf()
    if not omit_com_google_protobuf_js:
        com_google_protobuf_js()
    if not omit_com_google_template_soy:
        com_google_template_soy()
    if not omit_com_google_template_soy_jssrc:
        com_google_template_soy_jssrc()
    if not omit_com_ibm_icu_icu4j:
        com_ibm_icu_icu4j()
    if not omit_com_squareup_javapoet:
        com_squareup_javapoet()
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

# BEGIN_DECLARATIONS

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
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
            "https://repo1.maven.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
            "http://maven.ibiblio.org/maven2/com/google/auto/auto-common/0.7/auto-common-0.7.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
        deps = ["@com_google_guava"],
        default_visibility = ["@com_google_auto_factory//:__pkg__"],
    )

def com_google_auto_factory():
    java_import_external(
        name = "com_google_auto_factory",
        licenses = ["notice"],  # Apache 2.0
        jar_sha256 = "e6bed6aaa879f568449d735561a6a26a5a06f7662ed96ca88d27d2200a8dc6cf",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/auto/factory/auto-factory/1.0-beta5/auto-factory-1.0-beta5.jar",
            "https://repo1.maven.org/maven2/com/google/auto/factory/auto-factory/1.0-beta5/auto-factory-1.0-beta5.jar",
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
            "        \"@com_google_auto_value\",",
            "        \"@com_google_guava\",",
            "        \"@com_google_java_format\",",
            "        \"@com_squareup_javapoet\",",
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
            "        \"@javax_annotation_jsr250_api\",",
            "        \"@javax_inject\",",
            "    ],",
            ")",
        ]),
    )

def com_google_auto_value():
    # AutoValue 1.6+ shades Guava, Auto Common, and JavaPoet. That's OK
    # because none of these jars become runtime dependencies.
    java_import_external(
        name = "com_google_auto_value",
        jar_sha256 = "fd811b92bb59ae8a4cf7eb9dedd208300f4ea2b6275d726e4df52d8334aaae9d",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/auto/value/auto-value/1.6/auto-value-1.6.jar",
            "https://repo1.maven.org/maven2/com/google/auto/value/auto-value/1.6/auto-value-1.6.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
        generated_rule_name = "processor",
        exports = ["@com_google_auto_value_annotations"],
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
            "    name = \"AutoOneOfProcessor\",",
            "    output_licenses = [\"unencumbered\"],",
            "    processor_class = \"com.google.auto.value.processor.AutoOneOfProcessor\",",
            "    tags = [\"annotation=com.google.auto.value.AutoValue;genclass=${package}.AutoOneOf_${outerclasses}${classname}\"],",
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
            "        \":AutoOneOfProcessor\",",
            "        \":AutoValueProcessor\",",
            "    ],",
            "    exports = [\"@com_google_auto_value_annotations\"],",
            ")",
        ]),
    )

def com_google_auto_value_annotations():
    # It should be sufficient to simply depend on @com_google_auto_value.
    java_import_external(
        name = "com_google_auto_value_annotations",
        jar_sha256 = "d095936c432f2afc671beaab67433e7cef50bba4a861b77b9c46561b801fae69",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/auto/value/auto-value-annotations/1.6/auto-value-annotations-1.6.jar",
            "https://repo1.maven.org/maven2/com/google/auto/value/auto-value-annotations/1.6/auto-value-annotations-1.6.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
        neverlink = True,
        default_visibility = ["@com_google_auto_value//:__pkg__"],
    )

def com_google_closure_stylesheets():
    java_import_external(
        name = "com_google_closure_stylesheets",
        licenses = ["notice"],  # Apache 2.0
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/closure-stylesheets/closure-stylesheets/1.5.0/closure-stylesheets-1.5.0.jar",
            "https://repo1.maven.org/maven2/com/google/closure-stylesheets/closure-stylesheets/1.5.0/closure-stylesheets-1.5.0.jar",
        ],
        jar_sha256 = "fef768d4f7cead3c0c0783891118e7d3d6ecf17a3093557891f583d842362e2b",
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
            "@com_google_protobuf//:protobuf_java",
            "@javax_annotation_jsr250_api",
        ],
    )

def com_google_common_html_types_html_proto():
    http_file(
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
        jar_sha256 = "374cfee26c9c93f44caa1946583c9edc135bb9a42838476522551ec46aa55c7c",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger/2.14.1/dagger-2.14.1.jar",
            "https://repo1.maven.org/maven2/com/google/dagger/dagger/2.14.1/dagger-2.14.1.jar",
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
        jar_sha256 = "ff16d55273e375349537fc82292b00de04d8a2caca2d4aa6c642692b1a68194d",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger-compiler/2.14.1/dagger-compiler-2.14.1.jar",
            "https://repo1.maven.org/maven2/com/google/dagger/dagger-compiler/2.14.1/dagger-compiler-2.14.1.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
        deps = [
            "@com_google_code_findbugs_jsr305",
            "@com_google_dagger//:runtime",
            "@com_google_dagger_producers//:runtime",
            "@com_google_dagger_spi",
            "@com_google_guava",
            "@com_google_java_format",
            "@com_squareup_javapoet",
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
        jar_sha256 = "96f950bc4b94d013b0c538632a4bc630f33eda8b01f63ae752b76c5e48783859",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger-producers/2.14.1/dagger-producers-2.14.1.jar",
            "https://repo1.maven.org/maven2/com/google/dagger/dagger-producers/2.14.1/dagger-producers-2.14.1.jar",
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

def com_google_dagger_spi():
    java_import_external(
        name = "com_google_dagger_spi",
        jar_sha256 = "6a20d6c6620fefe50747e9e910e0d0c178cf39d76b67ccffb505ac9a167302cb",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger-spi/2.14.1/dagger-spi-2.14.1.jar",
            "https://repo1.maven.org/maven2/com/google/dagger/dagger-spi/2.14.1/dagger-spi-2.14.1.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
    )

def com_google_errorprone_error_prone_annotations():
    java_import_external(
        name = "com_google_errorprone_error_prone_annotations",
        licenses = ["notice"],  # Apache 2.0
        jar_sha256 = "03d0329547c13da9e17c634d1049ea2ead093925e290567e1a364fd6b1fc7ff8",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.1.3/error_prone_annotations-2.1.3.jar",
            "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.1.3/error_prone_annotations-2.1.3.jar",
        ],
    )

def com_google_errorprone_javac_shaded():
    # Please note that, while this is GPL, the output of programs that use
    # this library, e.g. annotation processors, should be unencumbered.
    java_import_external(
        name = "com_google_errorprone_javac_shaded",
        # GNU General Public License, version 2, with the Classpath Exception
        # http://openjdk.java.net/legal/gplv2+ce.html
        licenses = ["restricted"],
        jar_sha256 = "65bfccf60986c47fbc17c9ebab0be626afc41741e0a6ec7109e0768817a36f30",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/errorprone/javac-shaded/9-dev-r4023-3/javac-shaded-9-dev-r4023-3.jar",
            "https://repo1.maven.org/maven2/com/google/errorprone/javac-shaded/9-dev-r4023-3/javac-shaded-9-dev-r4023-3.jar",
        ],
    )

def com_google_guava():
    java_import_external(
        name = "com_google_guava",
        licenses = ["notice"],  # Apache 2.0
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/guava/24.1-jre/guava-24.1-jre.jar",
            "https://repo1.maven.org/maven2/com/google/guava/guava/24.1-jre/guava-24.1-jre.jar",
        ],
        jar_sha256 = "31bfe27bdf9cba00cb4f3691136d3bc7847dfc87bfe772ca7a9eb68ff31d79f5",
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

def com_google_java_format():
    java_import_external(
        name = "com_google_java_format",
        licenses = ["notice"],  # The Apache Software License, Version 2.0
        jar_sha256 = "aa19ad7850fb85178aa22f2fddb163b84d6ce4d0035872f30d4408195ca1144e",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/googlejavaformat/google-java-format/1.5/google-java-format-1.5.jar",
            "https://repo1.maven.org/maven2/com/google/googlejavaformat/google-java-format/1.5/google-java-format-1.5.jar",
        ],
        deps = [
            "@com_google_guava",
            "@com_google_errorprone_javac_shaded",
        ],
    )

def com_google_javascript_closure_compiler():
    java_import_external(
        name = "com_google_javascript_closure_compiler",
        licenses = ["reciprocal"],  # MPL v1.1 (Rhino AST), Apache 2.0 (JSCompiler)
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/javascript/closure-compiler-unshaded/v20190215/closure-compiler-unshaded-v20190215.jar",
            "http://repo1.maven.org/maven2/com/google/javascript/closure-compiler-unshaded/v20190215/closure-compiler-unshaded-v20190215.jar",
        ],
        jar_sha256 = "2a1839fe957dab5610cdd702364ea06d314d18b15e5221f06c18bdc27f1684c7",
        deps = [
            "@com_google_code_gson",
            "@com_google_guava",
            "@com_google_code_findbugs_jsr305",
            "@com_google_protobuf//:protobuf_java",
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
    # After updating: bazel run //closure/library:regenerate -- "$PWD"
    http_archive(
        name = "com_google_javascript_closure_library",
        urls = [
            "https://mirror.bazel.build/github.com/google/closure-library/archive/v20180805.tar.gz",
            "https://github.com/google/closure-library/archive/v20180805.tar.gz",
        ],
        sha256 = "714441188f9c50ee17b7937216627e3b7ea8c4acb3d06f901b21c53f26495b21",
        strip_prefix = "closure-library-20180805",
        build_file = str(Label("//closure/library:closure_library.BUILD")),
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

def com_google_protobuf():
    http_archive(
        name = "com_google_protobuf",
        strip_prefix = "protobuf-3.6.1.3",
        sha256 = "73fdad358857e120fd0fa19e071a96e15c0f23bb25f85d3f7009abfd4f264a2a",
        urls = [
            "https://mirror.bazel.build/github.com/google/protobuf/archive/v3.6.1.3.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v3.6.1.3.tar.gz",
        ],
    )

def com_google_protobuf_js():
    http_archive(
        name = "com_google_protobuf_js",
        strip_prefix = "protobuf-3.6.1.3/js",
        urls = [
            "https://mirror.bazel.build/github.com/google/protobuf/archive/v3.6.1.3.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v3.6.1.3.tar.gz",
        ],
        sha256 = "73fdad358857e120fd0fa19e071a96e15c0f23bb25f85d3f7009abfd4f264a2a",
        build_file = str(Label("//closure/protobuf:protobuf_js.BUILD")),
    )

def com_google_template_soy():
    java_import_external(
        name = "com_google_template_soy",
        licenses = ["notice"],  # Apache 2.0
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/template/soy/2018-03-14/soy-2018-03-14.jar",
            "https://repo1.maven.org/maven2/com/google/template/soy/2018-03-14/soy-2018-03-14.jar",
        ],
        jar_sha256 = "449664a12ae7f94d6ef72a0271edfe21fe6605fa749b152fce45eccb3e4d09b1",
        deps = [
            "@args4j",
            "@com_google_code_findbugs_jsr305",
            "@com_google_code_gson",
            "@com_google_common_html_types",
            "@com_google_guava",
            "@com_google_inject_extensions_guice_assistedinject",
            "@com_google_inject_extensions_guice_multibindings",
            "@com_google_inject_guice",
            "@com_google_protobuf//:protobuf_java",
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
            for name in (
                "SoyParseInfoGenerator",
                "SoyToJbcSrcCompiler",
                "SoyToJsSrcCompiler",
                "SoyToPySrcCompiler",
            )
        ]),
    )

def com_google_template_soy_jssrc():
    http_archive(
        name = "com_google_template_soy_jssrc",
        sha256 = "c76ab4cb6e46a7c76336640b3c40d6897b420209a6c0905cdcd32533dda8126a",
        urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/template/soy/2018-03-14/soy-2018-03-14-jssrc_js.jar",
            "https://repo1.maven.org/maven2/com/google/template/soy/2018-03-14/soy-2018-03-14-jssrc_js.jar",
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

def com_squareup_javapoet():
    java_import_external(
        name = "com_squareup_javapoet",
        jar_sha256 = "5bb5abdfe4366c15c0da3332c57d484e238bd48260d6f9d6acf2b08fdde1efea",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/squareup/javapoet/1.9.0/javapoet-1.9.0.jar",
            "https://repo1.maven.org/maven2/com/squareup/javapoet/1.9.0/javapoet-1.9.0.jar",
        ],
        licenses = ["notice"],  # Apache 2.0
    )

def fonts_noto_hinted_deb():
    http_file(
        name = "fonts_noto_hinted_deb",
        urls = [
            "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-hinted_20161116-1_all.deb",
            "http://http.us.debian.org/debian/pool/main/f/fonts-noto/fonts-noto-hinted_20161116-1_all.deb",
        ],
        sha256 = "a71fcee2bc7820fc4e0c780bb9c7c6db8364fd2c5bac20867c5c33eed470dc51",
    )

def fonts_noto_mono_deb():
    http_file(
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
    http_file(
        name = "libexpat_amd64_deb",
        urls = [
            "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/e/expat/libexpat1_2.1.0-6+deb8u3_amd64.deb",
            "http://http.us.debian.org/debian/pool/main/e/expat/libexpat1_2.1.0-6+deb8u3_amd64.deb",
        ],
        sha256 = "682d2321297c56dec327770efa986d4bef43a5acb1a5528b3098e05652998fae",
    )

def libfontconfig_amd64_deb():
    http_file(
        name = "libfontconfig_amd64_deb",
        urls = [
            "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3+deb8u1_amd64.deb",
            "http://http.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3+deb8u1_amd64.deb",
        ],
        sha256 = "0bb54d61c13aa5b5253cb5e08aaca0dfc4c626a05ee30f51d0e3002cda166fec",
    )

def libfreetype_amd64_deb():
    http_file(
        name = "libfreetype_amd64_deb",
        urls = [
            "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.5.2-3+deb8u1_amd64.deb",
            "http://http.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.5.2-3+deb8u1_amd64.deb",
        ],
        sha256 = "80184d932f9b0acc130af081c60a2da114c7b1e7531c18c63174498fae47d862",
    )

def libpng_amd64_deb():
    http_file(
        name = "libpng_amd64_deb",
        urls = [
            "https://mirror.bazel.build/http.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb",
            "http://http.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb",
        ],
        sha256 = "a57b6d53169c67a7754719f4b742c96554a18f931ca5b9e0408fb6502bb77e80",
    )

def org_apache_tomcat_annotations_api():
    java_import_external(
        name = "org_apache_tomcat_annotations_api",
        licenses = ["notice"],  # Apache License, Version 2.0
        jar_urls = [
            "http://maven.ibiblio.org/maven2/org/apache/tomcat/tomcat-annotations-api/8.0.5/tomcat-annotations-api-8.0.5.jar",
            "http://repo1.maven.org/maven2/org/apache/tomcat/tomcat-annotations-api/8.0.5/tomcat-annotations-api-8.0.5.jar",
        ],
        jar_sha256 = "748677bebb1651a313317dfd93e984ed8f8c9e345538fa8b0ab0cbb804631953",
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
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar",
            "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar",
        ],
        jar_sha256 = "df2c71a4240ecbdae7cdcd1667bcf0d747e4e3dcefe8161e787adcff7e5f2fa0",
    )

def org_ow2_asm():
    java_import_external(
        name = "org_ow2_asm",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm/6.0/asm-6.0.jar",
            "https://repo1.maven.org/maven2/org/ow2/asm/asm/6.0/asm-6.0.jar",
        ],
        jar_sha256 = "dd8971c74a4e697899a8e95caae4ea8760ea6c486dc6b97b1795e75760420461",
        licenses = ["notice"],  # BSD 3-clause
    )

def org_ow2_asm_analysis():
    java_import_external(
        name = "org_ow2_asm_analysis",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-analysis/6.0/asm-analysis-6.0.jar",
            "https://repo1.maven.org/maven2/org/ow2/asm/asm-analysis/6.0/asm-analysis-6.0.jar",
        ],
        jar_sha256 = "2f1a6387219c3a6cc4856481f221b03bd9f2408a326d416af09af5d6f608c1f4",
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
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.jar",
            "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.jar",
        ],
        jar_sha256 = "f1bce5c648a96a017bdcd01fe5d59af9845297fd7b79b81c015a6fbbd9719abf",
        exports = ["@org_ow2_asm_tree"],
    )

def org_ow2_asm_tree():
    java_import_external(
        name = "org_ow2_asm_tree",
        licenses = ["notice"],  # BSD 3-clause
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.jar",
            "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.jar",
        ],
        jar_sha256 = "887998fb69727c8759e4d253f856822801e33f9fd4caa566b3ac58ee92106215",
        exports = ["@org_ow2_asm"],
    )

def org_ow2_asm_util():
    java_import_external(
        name = "org_ow2_asm_util",
        licenses = ["notice"],  # BSD 3-clause
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/ow2/asm/asm-util/6.0/asm-util-6.0.jar",
            "https://repo1.maven.org/maven2/org/ow2/asm/asm-util/6.0/asm-util-6.0.jar",
        ],
        jar_sha256 = "356afebdb0f870175262e5188f8709a3b17aa2a5a6a4b0340b04d4b449bca5f6",
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
