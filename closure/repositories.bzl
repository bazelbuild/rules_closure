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
load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("//closure/private:platform_http_file.bzl", "platform_http_file")

def rules_closure_toolchains():
    """An utility method to load all Closure toolchains.
    It doesn't do anything at the moment.
    """
    pass

def rules_closure_dependencies(
        omit_args4j = False,
        omit_bazel_skylib = False,
        omit_com_google_auto_common = False,
        omit_com_google_auto_factory = False,
        omit_com_google_auto_value = False,
        omit_com_google_auto_value_annotations = False,
        omit_com_google_closure_stylesheets = False,
        omit_com_google_code_findbugs_jsr305 = False,
        omit_com_google_code_gson = False,
        omit_com_google_dagger = False,
        omit_com_google_dagger_compiler = False,
        omit_com_google_dagger_producers = False,
        omit_com_google_dagger_spi = False,
        omit_com_google_errorprone_error_prone_annotations = False,
        omit_com_google_errorprone_javac_shaded = False,
        omit_com_google_guava = False,
        omit_com_google_java_format = False,
        omit_com_google_javascript_closure_compiler = False,
        omit_com_google_jsinterop_annotations = False,
        omit_com_google_protobuf = False,
        omit_com_squareup_javapoet = False,
        omit_fonts_noto_hinted_deb = False,
        omit_fonts_noto_mono_deb = False,
        omit_javax_annotation_jsr250_api = False,
        omit_javax_inject = False,
        omit_libexpat_amd64_deb = False,
        omit_libfontconfig_amd64_deb = False,
        omit_libfreetype_amd64_deb = False,
        omit_libpng_amd64_deb = False,
        omit_org_jsoup = False,
        omit_phantomjs = False,
        omit_rules_cc = False,
        omit_rules_java = False,
        omit_rules_jvm_external = False,
        omit_rules_proto = False,
        omit_rules_python = False,
        omit_rules_webtesting = False,
        omit_zlib = False):
    """Imports dependencies for Closure Rules."""
    if not omit_args4j:
        args4j()
    if not omit_bazel_skylib:
        bazel_skylib()
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
    if not omit_com_google_java_format:
        com_google_java_format()
    if not omit_com_google_javascript_closure_compiler:
        com_google_javascript_closure_compiler()
    if not omit_com_google_jsinterop_annotations:
        com_google_jsinterop_annotations()
    if not omit_com_google_protobuf:
        com_google_protobuf()
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
    if not omit_org_jsoup:
        org_jsoup()
    if not omit_phantomjs:
        phantomjs()
    if not omit_rules_cc:
        rules_cc()
    if not omit_rules_java:
        rules_java()
    if not omit_rules_jvm_external:
        rules_jvm_external()
    if not omit_rules_proto:
        rules_proto()
    if not omit_rules_python:
        rules_python()
    if not omit_rules_webtesting:
        rules_webtesting()
    if not omit_zlib:
        zlib()

# BEGIN_DECLARATIONS

def args4j():
    java_import_external(
        name = "args4j",
        jar_sha256 = "91ddeaba0b24adce72291c618c00bbdce1c884755f6c4dba9c5c46e871c69ed6",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/args4j/args4j/2.33/args4j-2.33.jar",
            "https://repo1.maven.org/maven2/args4j/args4j/2.33/args4j-2.33.jar",
        ],
        licenses = ["notice"],
    )

def bazel_skylib():
    http_archive(
        name = "bazel_skylib",
        sha256 = "2ef429f5d7ce7111263289644d233707dba35e39696377ebab8b0bc701f7818e",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/0.8.0/bazel-skylib.0.8.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/0.8.0/bazel-skylib.0.8.0.tar.gz",
        ],
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
        licenses = ["notice"],
        deps = ["@com_google_guava"],
        default_visibility = ["@com_google_auto_factory//:__pkg__"],
    )

def com_google_auto_factory():
    java_import_external(
        name = "com_google_auto_factory",
        licenses = ["notice"],
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
        licenses = ["notice"],
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
        licenses = ["notice"],
        neverlink = True,
        default_visibility = ["@com_google_auto_value//:__pkg__"],
    )

def com_google_closure_stylesheets():
    java_import_external(
        name = "com_google_closure_stylesheets",
        licenses = ["notice"],
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
        licenses = ["notice"],
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
        licenses = ["notice"],
        jar_urls = [
            "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.9/gson-2.8.9.jar",
            "http://maven.ibiblio.org/maven2/com/google/code/gson/gson/2.8.9/gson-2.8.9.jar",
        ],
        jar_sha256 = "d3999291855de495c94c743761b8ab5176cfeabe281a5ab0d8e8d45326fd703e",
        deps = ["@com_google_code_findbugs_jsr305"],
    )

def com_google_dagger():
    java_import_external(
        name = "com_google_dagger",
        jar_sha256 = "374cfee26c9c93f44caa1946583c9edc135bb9a42838476522551ec46aa55c7c",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/dagger/dagger/2.14.1/dagger-2.14.1.jar",
            "https://repo1.maven.org/maven2/com/google/dagger/dagger/2.14.1/dagger-2.14.1.jar",
        ],
        licenses = ["notice"],
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
        licenses = ["notice"],
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
        licenses = ["notice"],
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
        licenses = ["notice"],
    )

def com_google_errorprone_error_prone_annotations():
    java_import_external(
        name = "com_google_errorprone_error_prone_annotations",
        licenses = ["notice"],
        jar_sha256 = "ec6f39f068b6ff9ac323c68e28b9299f8c0a80ca512dccb1d4a70f40ac3ec054",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.23.0/error_prone_annotations-2.23.0.jar",
            "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.23.0/error_prone_annotations-2.23.0.jar",
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
    version = "32.1.1"
    sha256 = "91fbba37f1c8b251cf9ea9e7d3a369eb79eb1e6a5df1d4bbf483dd0380740281"

    java_import_external(
        name = "com_google_guava",
        licenses = ["notice"],
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/guava/%s-jre/guava-%s-jre.jar" % (version, version),
            "https://repo1.maven.org/maven2/com/google/guava/guava/%s-jre/guava-%s-jre.jar" % (version, version),
        ],
        jar_sha256 = sha256,
        deps = [
            "@com_google_guava_failure_access",
        ],
        exports = [
            "@com_google_code_findbugs_jsr305",
            "@com_google_errorprone_error_prone_annotations",
        ],
    )

    # This is part of guava but is split out from core to allow android to pull this part independenty.
    java_import_external(
        name = "com_google_guava_failure_access",
        licenses = ["notice"],
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar",
            "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar",
        ],
        jar_sha256 = "a171ee4c734dd2da837e4b16be9df4661afab72a41adaf31eb84dfdaf936ca26",
    )

def com_google_java_format():
    java_import_external(
        name = "com_google_java_format",
        licenses = ["notice"],
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
    version = "v20240317"
    jar = "closure-compiler-%s.jar" % version
    java_import_external(
        name = "com_google_javascript_closure_compiler",
        licenses = ["reciprocal"],
        jar_urls = [
            "https://repo1.maven.org/maven2/com/google/javascript/closure-compiler/%s/%s" % (version, jar),
        ],
        jar_sha256 = "6b1250ac21c05bdd209dc515d9b6037b30b5555a284dd741ff0591a82848b7ce",
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
            "",
            "genrule(",
            "    name = \"externs\",",
            "    srcs = [\"%s\"]," % jar,
            "    outs = [\"externs.zip\"],",
            "    tools = [\"@bazel_tools//tools/zip:zipper\"],",
            "    cmd = \"$(location @bazel_tools//tools/zip:zipper) x $(location :%s) externs.zip; mv externs.zip $@\"," % jar,
            ")",
            "",
        ]),
    )

def com_google_jsinterop_annotations():
    java_import_external(
        name = "com_google_jsinterop_annotations",
        licenses = ["notice"],
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
        strip_prefix = "protobuf-3.19.1",
        sha256 = "87407cd28e7a9c95d9f61a098a53cf031109d451a7763e7dd1253abf8b4df422",
        urls = [
            "https://github.com/protocolbuffers/protobuf/archive/v3.19.1.tar.gz",
        ],
    )

def com_squareup_javapoet():
    java_import_external(
        name = "com_squareup_javapoet",
        jar_sha256 = "5bb5abdfe4366c15c0da3332c57d484e238bd48260d6f9d6acf2b08fdde1efea",
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/com/squareup/javapoet/1.9.0/javapoet-1.9.0.jar",
            "https://repo1.maven.org/maven2/com/squareup/javapoet/1.9.0/javapoet-1.9.0.jar",
        ],
        licenses = ["notice"],
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
        licenses = ["reciprocal"],
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
        licenses = ["notice"],
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
        licenses = ["notice"],
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/apache/tomcat/tomcat-annotations-api/8.0.5/tomcat-annotations-api-8.0.5.jar",
            "http://maven.ibiblio.org/maven2/org/apache/tomcat/tomcat-annotations-api/8.0.5/tomcat-annotations-api-8.0.5.jar",
            "https://repo1.maven.org/maven2/org/apache/tomcat/tomcat-annotations-api/8.0.5/tomcat-annotations-api-8.0.5.jar",
        ],
        jar_sha256 = "748677bebb1651a313317dfd93e984ed8f8c9e345538fa8b0ab0cbb804631953",
    )

def org_jsoup():
    java_import_external(
        name = "org_jsoup",
        licenses = ["notice"],
        jar_urls = [
            "https://mirror.bazel.build/repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar",
            "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar",
        ],
        jar_sha256 = "df2c71a4240ecbdae7cdcd1667bcf0d747e4e3dcefe8161e787adcff7e5f2fa0",
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

def rules_cc():
    http_archive(
        name = "rules_cc",
        sha256 = "29daf0159f0cf552fcff60b49d8bcd4f08f08506d2da6e41b07058ec50cfeaec",
        strip_prefix = "rules_cc-b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_cc/archive/b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e.tar.gz",
            "https://github.com/bazelbuild/rules_cc/archive/b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e.tar.gz",
        ],
    )

def rules_java():
    http_archive(
        name = "rules_java",
        sha256 = "29ba147c583aaf5d211686029842c5278e12aaea86f66bd4a9eb5e525b7f2701",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_java/releases/download/6.3.0/rules_java-6.3.0.tar.gz",
            "https://github.com/bazelbuild/rules_java/releases/download/6.3.0/rules_java-6.3.0.tar.gz",
        ],
    )

def rules_jvm_external():
    http_archive(
        name = "rules_jvm_external",
        sha256 = "f36441aa876c4f6427bfb2d1f2d723b48e9d930b62662bf723ddfb8fc80f0140",
        strip_prefix = "rules_jvm_external-4.1",
        urls = ["https://github.com/bazelbuild/rules_jvm_external/archive/4.1.zip"],
    )

def rules_proto():
    http_archive(
        name = "rules_proto",
        sha256 = "602e7161d9195e50246177e7c55b2f39950a9cf7366f74ed5f22fd45750cd208",
        strip_prefix = "rules_proto-97d8af4dc474595af3900dd85cb3a29ad28cc313",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
            "https://github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
        ],
    )

def rules_python():
    http_archive(
        name = "rules_python",
        sha256 = "e5470e92a18aa51830db99a4d9c492cc613761d5bdb7131c04bd92b9834380f6",
        strip_prefix = "rules_python-4b84ad270387a7c439ebdccfd530e2339601ef27",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/archive/4b84ad270387a7c439ebdccfd530e2339601ef27.tar.gz",
            "https://github.com/bazelbuild/rules_python/archive/4b84ad270387a7c439ebdccfd530e2339601ef27.tar.gz",
        ],
    )

def rules_webtesting():
    # TODO: Please remove the two following dependencies when rules_webtesting is pinned to an official release (>0.3.5).
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "278b7ff5a826f3dc10f04feaf0b70d48b68748ccd512d7f98bf442077f043fe3",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.41.0/rules_go-v0.41.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.41.0/rules_go-v0.41.0.zip",
        ],
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = "d3fa66a39028e97d76f9e2db8f1b0c11c099e8e01bf363a923074784e451f809",
        urls = [
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.33.0/bazel-gazelle-v0.33.0.tar.gz",
        ],
    )

    http_archive(
        name = "io_bazel_rules_webtesting",
        sha256 = "6e104e54c283c94ae3d5c6573cf3233ce478e89e0f541a869057521966a35b8f",
        strip_prefix = "rules_webtesting-b6fc79c5a37cd18a5433fd080c9d2cc59548222c",
        urls = ["https://github.com/bazelbuild/rules_webtesting/archive/b6fc79c5a37cd18a5433fd080c9d2cc59548222c.tar.gz"],
    )

def zlib():
    http_archive(
        name = "zlib",
        build_file = "@com_google_protobuf//:third_party/zlib.BUILD",
        sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        strip_prefix = "zlib-1.2.11",
        urls = [
            "https://mirror.bazel.build/zlib.net/zlib-1.2.11.tar.gz",
            "https://zlib.net/zlib-1.2.11.tar.gz",
        ],
    )
