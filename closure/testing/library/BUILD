load("//closure:defs.bzl", "closure_js_binary", "closure_js_library")

# Copyright 2024 The Closure Rules Authors. All rights reserved.
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
package(
    default_testonly = True,
    default_visibility = ["//visibility:public"],
)

licenses(["notice"])

closure_js_library(
    name = "testsuite",
    srcs = ["testsuite.js"],
    suppress = [
        "useOfGoogProvide",
    ],
    deps = [
        "@com_google_javascript_closure_library//closure/goog/testing:testcase",
        ":jsunit",
    ],
)

closure_js_library(
    name = "jsunit",
    srcs = ["jsunit.js"],
    suppress = [
        "useOfGoogProvide",
        "reportUnknownTypes",
    ],
    deps = [
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:testcase",
        ":testrunner",
    ],
)

closure_js_library(
    name = "testrunner",
    srcs = ["testrunner.js"],
    suppress = [
        "useOfGoogProvide",
        "reportUnknownTypes",
        "visibility",
    ],
    deps = [
        "@com_google_javascript_closure_library//closure/goog/testing:testcase",
    ],
)
