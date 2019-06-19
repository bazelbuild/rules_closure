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
    name = "localized_soy",
    srcs = ["localized.soy"],
    should_generate_soy_msg_defs = True,
)

file_test(
    name = "localized_test",
    size = "small",
    file = ":localized.soy.js",
    regexp = "goog.getMsg('Hello",
)

file_test(
    name = "nonlocalized_test",
    size = "small",
    file = ":greeter.soy.js",
    invert = True,
    regexp = "goog.getMsg",
)

closure_js_template_library(
    name = "localized_using_defs_soy",
    srcs = ["defs.soy"],
    defs = [
        "--shouldGenerateGoogMsgDefs=true",
    ],
)

file_test(
    name = "localized_using_defs_test",
    size = "small",
    file = ":defs.soy.js",
    regexp = "goog.getMsg('Hello",
)

closure_js_template_library(
    name = "greeter_proto_soy",
    srcs = ["greeter_proto.soy"],
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
    name = "greeter_proto_lib",
    srcs = ["greeter_proto.js"],
    deps = [
        ":greeter_proto_soy",
        ":person_proto",
        "//closure/library/soy",
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
