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

licenses(["notice"])  # Apache 2.0

load("//closure/private:file_test.bzl", "file_test")
load("//closure:defs.bzl", "closure_js_binary")
load("//closure:defs.bzl", "closure_js_library")
load(":fake_ts_library.bzl", "fake_ts_library")

fake_ts_library(
    name = "a",
    srcs = ["a.js"],
)

fake_ts_library(
    name = "b",
    srcs = ["b.js"],
    deps = [":a"],
)

closure_js_library(
    name = "b_js",
    ts_lib = ":b",
)

closure_js_library(
    name = "c",
    srcs = ["c.js"],
    deps = [":b_js"],
)

file_test(
    name = "c_noWarnings",
    content = "",
    file = "c-stderr.txt",
)

file_test(
    name = "b_js_noWarnings",
    content = "",
    file = "b_js-stderr.txt",
)

closure_js_binary(
    name = "c_bin",
    entry_points = ["c"],
    deps = ["c"],
)

file_test(
    name = "c_bin_noWarnings",
    content = "",
    file = "c_bin-stderr.txt",
)

fake_ts_library(
    name = "ts_closure",
    runtime_deps = ["//closure/library"],
)

fake_ts_library(
    name = "use_closure",
    srcs = ["use_closure.js"],
    deps = ["ts_closure"],
)

closure_js_library(
    name = "use_closure_js",
    ts_lib = "use_closure",
)

closure_js_binary(
    name = "use_closure_bin",
    deps = ["use_closure_js"],
)

file_test(
    name = "use_closure_js_noWarnings",
    content = "",
    file = "use_closure_js-stderr.txt",
)

file_test(
    name = "use_closure_bin_noWarnings",
    content = "",
    file = "use_closure_bin-stderr.txt",
)
