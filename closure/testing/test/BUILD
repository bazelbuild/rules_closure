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
load("//closure/testing:closure_js_test.bzl", "closure_js_test")
load("//closure/private:files_equal_test.bzl", "files_equal_test")

closure_js_library(
    name = "arithmetic_lib",
    srcs = ["arithmetic.js"],
)

closure_js_test(
    name = "simple_test",
    srcs = ["simple_test.js"],
    deps = ["//closure/library:testing"],
)

closure_js_library(
    name = "arithmetic_module_lib",
    srcs = ["arithmetic_module.js"],
    language = "ECMASCRIPT6_STRICT",
    deps = ["//closure/library"],
)

closure_js_test(
    name = "arithmetic_module_test",
    srcs = ["arithmetic_module_test.js"],
    entry_points = ["goog:arithmetic_module_test"],
    language = "ECMASCRIPT6_STRICT",
    deps = [
        ":arithmetic_module_lib",
        "//closure/library:testing",
    ],
)

closure_js_test(
    name = "arithmetic_scope_test",
    srcs = ["arithmetic_scope_test.js"],
    deps = [
        ":arithmetic_lib",
        "//closure/library:testing",
    ],
)

closure_js_library(
    name = "arithmetic_es6module_lib",
    srcs = ["arithmetic_es6module.js"],
    language = "ECMASCRIPT6_STRICT",
)

closure_js_test(
    name = "arithmetic_es6module_test",
    srcs = ["arithmetic_es6module_test.js"],
    language = "ECMASCRIPT6_STRICT",
    deps = [
        ":arithmetic_es6module_lib",
        "//closure/library:testing",
    ],
)

genrule(
    name = "fontdemo",
    srcs = [
        "screenshot.js",
        "fontdemo.html",
    ],
    outs = ["fontdemo-generated.png"],
    cmd = "$(location //third_party/phantomjs) $(SRCS) $@",
    tools = ["//third_party/phantomjs"],
)

files_equal_test(
    name = "noto_fonts_render_as_expected",
    actual = "fontdemo-generated.png",
    golden = select({
        ":darwin": "fontdemo-darwin.png",
        "//conditions:default": "fontdemo.png",
    }),
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
)
