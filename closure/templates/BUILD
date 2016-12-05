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

licenses(["notice"])  # Apache 2.0

load("//closure:defs.bzl", "closure_js_library")
load("//closure:defs.bzl", "closure_js_proto_library")

java_library(
    name = "templates",
    exports = [
        "//third_party/java/soy",
    ],
)

closure_js_proto_library(
    name = "soy_html_proto",
    srcs = ["@safe_html_types_html_proto//file"],
)

closure_js_library(
    name = "soy_jssrc",
    srcs = [
        "@soy_jssrc//:jspbconversions.js",
        "@soy_jssrc//:soydata_converters.js",
        "@soy_jssrc//:soyutils_usegoog.js",
    ],
    suppress = [
        "JSC_IMPLICITLY_NULLABLE_JSDOC",
        "JSC_NTI_INEXISTENT_PROPERTY",
        "JSC_NTI_NULLABLE_DEREFERENCE",
        "JSC_NTI_RETURN_NONDECLARED_TYPE",
        "JSC_NTI_UNKNOWN_EXPR_TYPE",
        "JSC_NULLABLE_RETURN_WITH_NAME",
        "JSC_OPTIONAL_PARAM_NOT_MARKED_OPTIONAL",
        "JSC_UNKNOWN_EXPR_TYPE",
    ],
    deps = [
        ":soy_html_proto",
        "//closure/library",
    ],
)

java_library(
    name = "safe_html_types",
    exports = [
        "@safe_html_types//jar",
    ],
    runtime_deps = [
        "@guava//jar",
        "@protobuf_java//jar",
    ],
)
