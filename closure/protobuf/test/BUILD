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

load("@rules_proto//proto:defs.bzl", "proto_library")
load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/protobuf:closure_proto_library.bzl", "closure_proto_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")

proto_library(
    name = "foo_proto",
    srcs = ["foo.proto"],
)

closure_proto_library(
    name = "foo_closure_proto",
    deps = [":foo_proto"],
)

closure_js_library(
    name = "foo",
    srcs = [
        "foo.js",
    ],
    deps = [
        ":foo_closure_proto",
    ],
)

closure_js_test(
    name = "foo_test",
    timeout = "short",
    srcs = [
        "foo_test.js",
    ],
    entry_points = [
        "goog:io.bazel.rules.closure.protobuf.FooTest",
    ],
    deps = [
        ":foo",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)

proto_library(
    name = "bar_proto",
    srcs = ["bar.proto"],
    deps = [":foo_proto"],
)

proto_library(
    name = "baz_proto",
    srcs = ["baz.proto"],
    deps = [":bar_proto"],
)

closure_proto_library(
    name = "baz_closure_proto",
    deps = [":baz_proto"],
)

closure_js_library(
    name = "baz",
    srcs = [
        "baz.js",
    ],
    deps = [
        ":baz_closure_proto",
    ],
)

closure_js_test(
    name = "baz_test",
    timeout = "short",
    srcs = [
        "baz_test.js",
    ],
    entry_points = [
        "goog:io.bazel.rules.closure.protobuf.BazTest",
    ],
    deps = [
        ":baz",
        ":foo",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)

proto_library(
    name = "bat_proto",
    srcs = ["bat.proto"],
    deps = ["@com_google_protobuf//:any_proto"],
)

closure_proto_library(
    name = "bat_closure_proto",
    deps = [":bat_proto"],
)

closure_js_library(
    name = "bat",
    srcs = [
        "bat.js",
    ],
    deps = [
        ":bat_closure_proto",
    ],
)

closure_js_test(
    name = "bat_test",
    timeout = "short",
    srcs = [
        "bat_test.js",
    ],
    entry_points = [
        "goog:io.bazel.rules.closure.protobuf.BatTest",
    ],
    deps = [
        ":bat",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)
