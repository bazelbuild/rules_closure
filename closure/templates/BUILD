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

package(default_visibility = ["//visibility:public"])

load("//closure:defs.bzl", "closure_js_library")

java_library(
    name = "templates",
    exports = ["@soy//jar"],
    runtime_deps = [
        "@aopalliance//jar",
        "@asm//jar",
        "@asm_analysis//jar",
        "@asm_commons//jar",
        "@asm_util//jar",
        "@guava//jar",
        "@guice//jar",
        "@guice_assistedinject//jar",
        "@guice_multibindings//jar",
        "@icu4j//jar",
        "@jsr305//jar",
        "@jsr330_inject//jar",
    ],
)

closure_js_library(
    name = "soyutils_usegoog",
    srcs = ["@soyutils_usegoog//file"],
    suppress = [
        "JSC_OPTIONAL_PARAM_NOT_MARKED_OPTIONAL",
    ],
    deps = ["//closure/library"],
)

java_binary(
    name = "SoyParseInfoGenerator",
    jvm_flags = ["-client"],
    main_class = "com.google.template.soy.SoyParseInfoGenerator",
    runtime_deps = [
        "@args4j//jar",
        ":templates",
    ],
)

java_binary(
    name = "SoyToJsSrcCompiler",
    jvm_flags = ["-client"],
    main_class = "com.google.template.soy.SoyToJsSrcCompiler",
    runtime_deps = [
        "@args4j//jar",
        ":templates",
    ],
)

java_binary(
    name = "SoyToIncrementalDomSrcCompiler",
    jvm_flags = ["-client"],
    main_class = "com.google.template.soy.SoyToIncrementalDomSrcCompiler",
    runtime_deps = [
        "@args4j//jar",
        "@incremental_dom_soy//:compiler_jar",
    ],
)

closure_js_library(
    name = "incremental_dom",
    srcs = ["//third_party/incremental_dom"],
    language = "ECMASCRIPT6_STRICT",
    suppress = [
        "JSC_MISSING_JSDOC",
    ],
)
