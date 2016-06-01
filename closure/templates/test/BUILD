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

load("//closure:defs.bzl", "closure_js_library")
load("//closure:defs.bzl", "closure_js_template_library")
load("//closure:defs.bzl", "closure_js_test")

closure_js_template_library(
    name = "greeter_soy",
    srcs = ["greeter.soy"],
)

closure_js_template_library(
    name = "greeter_idom_soy",
    srcs = ["greeter_idom.soy"],
    incremental_dom = 1,
)

closure_js_library(
    name = "greeter_lib",
    srcs = ["greeter.js"],
    deps = [
        ":greeter_soy",
        "//closure/library",
    ],
)

closure_js_library(
    name = "greeter_idom_lib",
    srcs = ["greeter_idom.js"],
    deps = [
        ":greeter_idom_soy",
        "//closure/library",
        "//closure/templates:incremental_dom",
    ],
    language = "ECMASCRIPT6_STRICT",
)

closure_js_test(
    name = "greeter_test",
    srcs = ["greeter_test.js"],
    pedantic = True,
    deps = [
        ":greeter_lib",
        "//closure/library",
        "//closure/library:testing",
    ],
)

closure_js_test(
    name = "greeter_idom_test",
    srcs = ["greeter_idom_test.js"],
    deps = [
        ":greeter_idom_lib",
        "//closure/library:testing",
    ],
    language = "ECMASCRIPT6_STRICT",
)
