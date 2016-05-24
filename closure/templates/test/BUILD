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

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/templates:closure_template_js_library.bzl", "closure_template_js_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")

closure_template_js_library(
    name = "greeter_soy",
    srcs = ["greeter.soy"],
)

closure_js_library(
    name = "greeter_lib",
    srcs = ["greeter.js"],
    deps = [
        ":greeter_soy",
        "//closure/library",
    ],
)

closure_js_test(
    name = "greeter_test",
    srcs = ["greeter_test.js"],
    deps = [
        ":greeter_lib",
        "//closure/library:testing",
    ],
)
