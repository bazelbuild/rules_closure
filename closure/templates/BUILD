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

load("@rules_java//java:defs.bzl", "java_library")
load("//closure:defs.bzl", "closure_js_library", "closure_js_proto_library")

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
    lenient = True,
    deps = [
        ":soy_html_proto",
        "@com_google_javascript_closure_library//closure/goog/array",
        "@com_google_javascript_closure_library//closure/goog/asserts",
        "@com_google_javascript_closure_library//closure/goog/debug",
        "@com_google_javascript_closure_library//closure/goog/format",
        "@com_google_javascript_closure_library//closure/goog/html:safehtml",
        "@com_google_javascript_closure_library//closure/goog/html:safescript",
        "@com_google_javascript_closure_library//closure/goog/html:safestyle",
        "@com_google_javascript_closure_library//closure/goog/html:safestylesheet",
        "@com_google_javascript_closure_library//closure/goog/html:safeurl",
        "@com_google_javascript_closure_library//closure/goog/html:trustedresourceurl",
        "@com_google_javascript_closure_library//closure/goog/html:uncheckedconversions",
        "@com_google_javascript_closure_library//closure/goog/i18n:bidi",
        "@com_google_javascript_closure_library//closure/goog/i18n:bidiformatter",
        "@com_google_javascript_closure_library//closure/goog/i18n:numberformat",
        "@com_google_javascript_closure_library//closure/goog/object",
        "@com_google_javascript_closure_library//closure/goog/soy",
        "@com_google_javascript_closure_library//closure/goog/soy:data",
        "@com_google_javascript_closure_library//closure/goog/soy:renderer",
        "@com_google_javascript_closure_library//closure/goog/string",
        "@com_google_javascript_closure_library//closure/goog/string:const",
        "@com_google_javascript_closure_library//closure/goog/uri",
    ],
)

java_library(
    name = "safe_html_types",
    exports = ["@com_google_common_html_types"],
)
