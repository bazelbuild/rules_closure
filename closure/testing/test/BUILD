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

load("//closure:defs.bzl", "closure_js_library", "closure_js_test")

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
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
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
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)

closure_js_test(
    name = "arithmetic_scope_test",
    timeout = "short",
    srcs = ["arithmetic_scope_test.js"],
    deps = [
        ":arithmetic_lib",
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
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
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
    ],
)

# Note that this is also validating Closure Library integration.
closure_js_test(
    name = "dom_test",
    timeout = "short",
    srcs = ["dom_test.js"],
    deps = [
        "@com_google_javascript_closure_library//closure/goog/dom",
        "@com_google_javascript_closure_library//closure/goog/dom:tagname",
        "@com_google_javascript_closure_library//closure/goog/html:safehtml",
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:jsunit",
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
        "@com_google_javascript_closure_library//closure/goog/testing:asserts",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)

closure_js_test(
    name = "dict_entry_point_test",
    srcs = ["dict_entry_point_test.js"],
    entry_points = {
        "dict_entry_point_test.js": ["rules_closure.DictEntryPointTest"],
    },
    deps = [
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)

# This test shows how to write tests to verify rendered output from phantomjs.
# However, you shouln't do this because the output image depends on a lot of
# external factors like operating system, GPU, ..., and therefore has a
# very hight chance of being flaky.
# https://github.com/bazelbuild/rules_closure/issues/247
# https://github.com/bazelbuild/rules_closure/pull/186#issuecomment-279115018
#
# genrule(
#     name = "fontdemo",
#     srcs = [
#         "screenshot.js",
#         "fontdemo.html",
#     ],
#     outs = ["fontdemo-generated.png"],
#     cmd = "$(location //third_party/phantomjs) $(SRCS) $@",
#     # TODO(user): Remove local = 1 when ariya/phantomjs#13876 is fixed.
#     local = 1,
#     tags = ["requires-network"],
#     tools = ["//third_party/phantomjs"],
# )
#
# files_equal_test(
#     name = "noto_fonts_render_as_expected",
#     actual = "fontdemo-generated.png",
#     golden = select({
#         ":darwin": "fontdemo-darwin.png",
#         "//conditions:default": "fontdemo.png",
#     }),
# )
#
# config_setting(
#     name = "darwin",
#     values = {"cpu": "darwin"},
# )
