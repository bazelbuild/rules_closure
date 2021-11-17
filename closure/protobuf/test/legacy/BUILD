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

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/protobuf:closure_js_proto_library.bzl", "closure_js_proto_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")

closure_js_proto_library(
    name = "example_proto",
    srcs = ["example.proto"],
)

closure_js_library(
    name = "example_lib",
    srcs = ["example.js"],
    suppress = ["useOfGoogProvide"],
    deps = [
        ":example_proto",
    ],
)

closure_js_test(
    name = "example_test",
    timeout = "short",
    srcs = ["example_test.js"],
    deps = [
        ":example_lib",
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
    ],
)
