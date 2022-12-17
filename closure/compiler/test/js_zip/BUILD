# Copyright 2018 The Closure Rules Authors. All rights reserved.
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

package(default_testonly = True)

licenses(["notice"])

load("//closure/private:file_test.bzl", "file_test")
load("//closure:defs.bzl", "closure_js_binary")
load(":zip_file_test_library.bzl", "zip_file_test_library")

zip_file_test_library(
    name = "main_lib",
    srcs = ["main.js.zip"],
)

closure_js_binary(
    name = "main_bin",
    deps = [":main_lib"],
)

file_test(
    name = "zip_files_worksCorrectly",
    content = "console.log(\"hi from zip\");\n",
    file = "main_bin.js",
)

zip_file_test_library(
    name = "main_with_error_lib",
    srcs = ["main_with_error.js.zip"],
    suppress = [
        "JSC_UNDEFINED_VARIABLE",
        "JSC_UNKNOWN_EXPR_TYPE",
    ],
)

closure_js_binary(
    name = "main_with_error_bin",
    deps = [":main_with_error_lib"],
)

file_test(
    name = "zip_files_areSuppressable",
    content = "iDontExist();\n",
    file = "main_with_error_bin.js",
)
