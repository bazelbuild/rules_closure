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
    exports = ["@com_google_template_soy"],
)

closure_js_proto_library(
    name = "soy_html_proto",
    srcs = ["@com_google_common_html_types_html_proto//file"],
)

closure_js_library(
    name = "soy_jssrc",
    srcs = ["@com_google_template_soy_jssrc"],
    suppress = [
        "analyzerChecks",
        "lintChecks",
        "reportUnknownTypes",
        "strictCheckTypes",
    ],
    deps = [
        ":soy_html_proto",
        "//closure/library",
    ],
)

closure_js_library(
    name = "soy_jssrc_idom",
    srcs = ["@com_google_template_soy_jssrc//:idom"],
    suppress = [
        "reportUnknownTypes",
        "strictCheckTypes",
    ],
    deps = [
        ":soy_jssrc",
        "//closure/library",
        "//third_party/javascript/incremental_dom",
    ],
)

java_library(
    name = "safe_html_types",
    exports = ["@com_google_common_html_types"],
)
