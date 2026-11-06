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

load("//closure:defs.bzl", "closure_js_library", "closure_js_test")

package(default_testonly = True)

licenses(["notice"])

closure_js_library(
    name = "arithmetic_lib",
    srcs = ["arithmetic.js"],
    suppress = ["useOfGoogProvide"],
)

closure_js_test(
    name = "simple_test",
    timeout = "short",
    srcs = ["simple_test.js"],
    deps = [
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
    ],
)

closure_js_library(
    name = "arithmetic_module_lib",
    srcs = ["arithmetic_module.js"],
)

closure_js_test(
    name = "arithmetic_module_test",
    timeout = "short",
    srcs = ["arithmetic_module_test.js"],
    entry_points = ["goog:arithmetic_module_test"],
    deps = [
        ":arithmetic_module_lib",
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
        "//closure/testing/library:testsuite",
    ],
)

closure_js_test(
    name = "arithmetic_scope_test",
    timeout = "short",
    srcs = ["arithmetic_scope_test.js"],
    deps = [
        ":arithmetic_lib",
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
        "//closure/testing/library:testsuite",
    ],
)

closure_js_library(
    name = "arithmetic_es6module_lib",
    srcs = ["arithmetic_es6module.js"],
)

closure_js_test(
    name = "arithmetic_es6module_test",
    timeout = "short",
    srcs = ["arithmetic_es6module_test.js"],
    entry_points = ["closure/testing/test/arithmetic_es6module_test.js"],
    suppress = ["moduleLoad"],
    deps = [
        ":arithmetic_es6module_lib",
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
    ],
)

closure_js_library(
    name = "lenient_lib",
    srcs = ["lenient.js"],
    lenient = True,
)

closure_js_test(
    name = "lenient_test",
    srcs = ["lenient_test.js"],
    entry_points = ["rules_closure.LenientTest"],
    lenient = True,
    deps = [
        ":lenient_lib",
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
        "//closure/testing/library:testsuite",
    ],
)

closure_js_test(
    name = "dict_entry_point_test",
    srcs = ["dict_entry_point_test.js"],
    entry_points = {
        "dict_entry_point_test.js": ["rules_closure.DictEntryPointTest"],
    },
    deps = [
        "//closure/testing/library:asserts",
        "//closure/testing/library:testsuite",
    ],
)

# Webtest examples
closure_js_test(
    name = "simple_webtest_test",
    timeout = "short",
    srcs = ["simple_test.js"],
    browsers = ["@rules_browsers//browsers/chromium:chromium"],
    deps = [
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
    ],
)

closure_js_test(
    name = "arithmetic_module_webtest_test",
    timeout = "short",
    srcs = ["arithmetic_module_test.js"],
    browsers = ["@rules_browsers//browsers/chromium:chromium"],
    entry_points = ["goog:arithmetic_module_test"],
    deps = [
        ":arithmetic_module_lib",
        "//closure/testing/library:asserts",
        "//closure/testing/library:jsunit",
        "//closure/testing/library:testsuite",
    ],
)

