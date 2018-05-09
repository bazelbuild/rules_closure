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

package(default_testonly = True)

licenses(["notice"])  # Apache 2.0

load("//closure:defs.bzl", "closure_js_binary")
load("//closure:defs.bzl", "closure_js_library")
load("//closure:defs.bzl", "closure_js_proto_library")
load("//closure:defs.bzl", "closure_js_template_library")
load("//closure:defs.bzl", "closure_js_test")
load("//closure:defs.bzl", "closure_java_template_library")
load("//closure/private:file_test.bzl", "file_test")

closure_js_proto_library(
    name = "person_proto",
    srcs = ["person.proto"],
)

closure_js_template_library(
    name = "greeter_soy",
    srcs = ["greeter.soy"],
)

closure_js_template_library(
    name = "greeter_idom_soy",
    srcs = ["greeter_idom.soy"],
    incremental_dom = 1,
)

closure_js_template_library(
    name = "greeter_proto_soy",
    srcs = ["greeter_proto.soy"],
    deps = [":person_proto"],
)

closure_js_template_library(
    name = "greeter_idom_proto_soy",
    srcs = ["greeter_idom_proto.soy"],
    incremental_dom = 1,
    deps = [":person_proto"],
)

closure_js_library(
    name = "greeter_lib",
    srcs = ["greeter.js"],
    deps = [
        ":greeter_soy",
        "//closure/library/soy",
    ],
)

closure_js_library(
    name = "greeter_idom_lib",
    srcs = ["greeter_idom.js"],
    deps = [
        ":greeter_idom_soy",
        "//third_party/javascript/incremental_dom",
    ],
)

closure_js_library(
    name = "greeter_proto_lib",
    srcs = ["greeter_proto.js"],
    deps = [
        ":greeter_proto_soy",
        ":person_proto",
        "//closure/library/soy",
    ],
)

closure_js_library(
    name = "greeter_idom_proto_lib",
    srcs = ["greeter_idom_proto.js"],
    deps = [
        ":greeter_idom_proto_soy",
        ":person_proto",
        "//third_party/javascript/incremental_dom",
    ],
)

closure_js_test(
    name = "greeter_test",
    timeout = "short",
    srcs = ["greeter_test.js"],
    deps = [
        ":greeter_lib",
        "//closure/library/asserts",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunit",
    ],
)

closure_js_test(
    name = "greeter_idom_test",
    timeout = "short",
    srcs = ["greeter_idom_test.js"],
    deps = [
        ":greeter_idom_lib",
        "//closure/library/module",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunit",
    ],
)

closure_js_test(
    name = "greeter_proto_test",
    timeout = "short",
    srcs = ["greeter_proto_test.js"],
    deps = [
        ":greeter_proto_lib",
        "//closure/library/asserts",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunit",
    ],
)

closure_js_test(
    name = "greeter_idom_proto_test",
    timeout = "short",
    srcs = ["greeter_idom_proto_test.js"],
    deps = [
        ":greeter_idom_proto_lib",
        "//closure/library/module",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunit",
    ],
)

closure_java_template_library(
    name = "greeter_soy_java",
    srcs = ["greeter.soy"],
    java_package = "io.bazel.rules.closure.soy.greeter",
)

file_test(
    name = "greeter_java_generated",
    size = "small",
    file = "GreeterSoyInfo.java",
    regexp = "class GreeterSoyInfo",
)

################################################################################
# If we forget to pass a parameter to a template, it will fail to compile

closure_js_library(
    name = "greeter_idom_fail_lib",
    srcs = ["greeter_idom_fail.js"],
    deps = [
        ":greeter_idom_soy",
        "//third_party/javascript/incremental_dom",
    ],
)

closure_js_binary(
    name = "greeter_idom_fail_bin",
    entry_points = ["goog:io.bazel.rules.closure.GreeterIdomFail"],
    internal_expect_failure = True,
    deps = [":greeter_idom_fail_lib"],
)

file_test(
    name = "idom_missingTemplateParameter_failsToCompile",
    file = "greeter_idom_fail_bin-stderr.txt",
    regexp = "actual parameter 2 of .*patchInner does not match formal parameter",
)

################################################################################
# Globals variables can be defined in txt files

closure_js_template_library(
    name = "globals_soy",
    srcs = ["globals.soy"],
    globals = "globals.txt",
)

closure_js_test(
    name = "globals_test",
    timeout = "short",
    srcs = ["globals_test.js"],
    deps = [
        ":globals_soy",
        "//closure/library",
        "//closure/library:testing",
    ],
)
