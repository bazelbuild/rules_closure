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

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/protobuf:closure_proto_library.bzl", "closure_proto_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")
load("@build_bazel_rules_proto//proto:proto_library.bzl", "proto_library")

# TODO(yannic): Add test for attr `proto_source_root`.

proto_library(
    name = "add_prefix_proto",
    srcs = [
        "add_prefix.proto",
    ],
    import_prefix = "foo",
)

closure_proto_library(
    name = "add_prefix_closure_proto",
    deps = [
        ":add_prefix_proto",
    ],
)

proto_library(
    name = "add_and_strip_prefix_proto",
    srcs = [
        "import_prefix/add_and_strip_prefix.proto",
    ],
    import_prefix = "bar",
    strip_import_prefix = "import_prefix",
)

closure_proto_library(
    name = "add_and_strip_prefix_closure_proto",
    deps = [
        ":add_and_strip_prefix_proto",
    ],
)

proto_library(
    name = "no_prefix_proto",
    srcs = [
        "no_prefix.proto",
    ],
)

closure_proto_library(
    name = "no_prefix_closure_proto",
    deps = [
        ":no_prefix_proto",
    ],
)

proto_library(
    name = "strip_prefix_proto",
    srcs = [
        "import_prefix/strip_prefix.proto",
    ],
    strip_import_prefix = "import_prefix",
)

closure_proto_library(
    name = "strip_prefix_closure_proto",
    deps = [
        ":strip_prefix_proto",
    ],
)

proto_library(
    name = "import_all_proto",
    srcs = [
        "import_all.proto",
    ],
    deps = [
        ":add_and_strip_prefix_proto",
        ":add_prefix_proto",
        ":no_prefix_proto",
        ":strip_prefix_proto",
    ],
)

closure_proto_library(
    name = "import_all_closure_proto",
    tags = ["manual"],
    deps = [
        ":import_all_proto",
    ],
)

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
        ":import_all_closure_proto",
        "//closure/library/testing:testsuite",
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
        "//closure/library/testing:testsuite",
    ],
)
