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

package(
    default_testonly = True,
    default_visibility = ["//visibility:public"],
)

licenses(["notice"])  # Apache 2.0

load("//closure:defs.bzl", "closure_js_binary", "closure_js_library")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

exports_files(["empty.html"])

closure_js_library(
    name = "phantomjs_jsunit_runner",
    srcs = ["phantomjs_jsunit_runner.js"],
    no_closure_library = True,
)

closure_js_library(
    name = "phantomjs_harness",
    srcs = ["phantomjs_harness.js"],
    no_closure_library = True,
    deps = ["//closure/testing/externs:phantomjs"],
)

closure_js_binary(
    name = "phantomjs_harness_bin",
    defs = ["--env=CUSTOM"],
    deps = [":phantomjs_harness"],
)

bzl_library(
    name = "phantomjs_test_bzl",
    srcs = ["phantomjs_test.bzl"],
    deps = [
        "//closure/compiler:compiler_bzl",
    ],
)

bzl_library(
    name = "closure_js_test_bzl",
    srcs = ["closure_js_test.bzl"],
    deps = [
        ":phantomjs_test_bzl",
        "//closure/compiler:compiler_bzl",
    ],
)

