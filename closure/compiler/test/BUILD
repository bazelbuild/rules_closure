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

load("//closure/private:expected_output_test.bzl", "closure_js_binary_output_test", "closure_js_binary_sourcemap_test")
load("//closure/private:file_test.bzl", "file_test")
load("//closure:defs.bzl", "closure_js_binary", "closure_js_library")

closure_js_library(
    name = "hello_lib",
    srcs = ["hello.js"],
    no_closure_library = True,
)

closure_js_binary(
    name = "hello_bin",
    deps = [":hello_lib"],
)

closure_js_binary_output_test(
    name = "minification",
    expected_output = "golden/minification.js",
    target = ":hello_bin",
)

closure_js_binary_sourcemap_test(
    name = "sourcemap_doesntContainWeirdBazelDirectories",
    expected_output = "golden/sourcemap_doesn_contain_weird_bazel_directories.js.map",
    target = ":hello_bin",
)

# Make sure bazel doesn't complain about some outputs not created.
closure_js_binary(
    name = "hello_bin_bundle",
    compilation_level = "BUNDLE",
    deps = [":hello_lib"],
)

closure_js_binary(
    name = "hello_wrap_bin",
    language = "ECMASCRIPT3",
    output_wrapper = "(function(){%output%}).call(this);",
    deps = [":hello_lib"],
)

closure_js_binary_output_test(
    name = "minification_with_wrapper",
    expected_output = "golden/minification_with_wrapper.js",
    target = ":hello_wrap_bin",
)

closure_js_binary_sourcemap_test(
    name = "sourcemapWithWrapper_hasDifferentMappingCodes",
    expected_output = "golden/sourcemap_with_wrapper_has_different_mapping_codes.js.map",
    target = ":hello_wrap_bin",
)

closure_js_binary(
    name = "hello_es5strict_bin",
    language = "ECMASCRIPT5_STRICT",
    deps = [":hello_lib"],
)

closure_js_binary_output_test(
    name = "strictOutputLanguage_addsUseStrict",
    expected_output = "golden/strict_output_language_adds_use_strict.js",
    target = ":hello_es5strict_bin",
)

closure_js_library(
    name = "es6const_lib",
    srcs = ["es6const.js"],
    no_closure_library = True,
)

closure_js_binary(
    name = "es6const_bin",
    compilation_level = "WHITESPACE_ONLY",
    language = "ECMASCRIPT5",
    deps = [":es6const_lib"],
)

closure_js_binary_output_test(
    name = "es6WithConstKeyword_getsRemoved",
    expected_output = "golden/es6_with_const_keyword_gets_removed.js",
    target = ":es6const_bin",
)

closure_js_library(
    name = "es6arrow_lib",
    srcs = ["es6arrow.js"],
    no_closure_library = True,
)

closure_js_binary(
    name = "es6arrow_bin",
    compilation_level = "WHITESPACE_ONLY",
    language = "ECMASCRIPT5",
    deps = [":es6arrow_lib"],
)

closure_js_binary_output_test(
    name = "es6WithArrowFunction_getsExpanded",
    expected_output = "golden/es6_with_arrow_function_gets_expanded.js",
    target = ":es6arrow_bin",
)

closure_js_library(
    name = "noClosingParen",
    srcs = ["noClosingParen.js"],
    internal_expect_failure = True,
    tags = ["manual"],
)

file_test(
    name = "noClosingParen_failsToCompile",
    file = "noClosingParen-stderr.txt",
    regexp = "noClosingParen\\.js:16:.*ERROR.*- Parse error\\.",
)

closure_js_library(
    name = "empty_lib_indirectly_hidden",
    srcs = ["empty.js"],
    visibility = ["//visibility:private"],
)

closure_js_library(
    name = "empty_lib",  # this is an alias rule
    visibility = ["//closure/compiler/test/exports_and_entry_points:__pkg__"],
    exports = [":empty_lib_indirectly_hidden"],
)

closure_js_binary(
    name = "hello_output_wrapper_dash_dash_space_bin",
    output_wrapper = "-- %output%",
    deps = [":hello_lib"],
)

closure_js_binary_output_test(
    name = "output_wrapper_dash_dash_space",
    expected_output = "golden/output_wrapper_dash_dash_space.js",
    target = ":hello_output_wrapper_dash_dash_space_bin",
)

closure_js_binary(
    name = "multiline_output_wrapper_bin",
    output_wrapper = "%output%\n//# sourceMappingURL=/app.js.map",
    deps = [":empty_lib"],
)

closure_js_binary_output_test(
    name = "multiline_output_wrapper_test",
    expected_output = "golden/multiline_output_wrapper_test.js",
    target = ":multiline_output_wrapper_bin",
)

################################################################################
# External definitions work

closure_js_library(
    name = "extern_lib",
    srcs = ["extern.js"],
)

closure_js_library(
    name = "extern_invoke_lib",
    srcs = ["extern_invoke.js"],
    deps = [":extern_lib"],
)

closure_js_binary(
    name = "extern_bin",
    deps = [":extern_invoke_lib"],
)

closure_js_binary_output_test(
    name = "externFile_namesDidntCollapse",
    expected_output = "golden/extern_file_names_didnt_collapse.js",
    target = ":extern_bin",
)

closure_js_library(
    name = "extern_invoke_bad_lib",
    srcs = ["extern_invoke_bad.js"],
    deps = [":extern_lib"],
)

closure_js_binary(
    name = "extern_bad_bin",
    internal_expect_failure = True,
    deps = [":extern_invoke_bad_lib"],
)

file_test(
    name = "externTypeError_failsToCompile",
    file = "extern_bad_bin-stderr.txt",
    regexp = "actual parameter 1 of omg.im_an_extern does not match formal parameter",
)

# TEST: closure_js_library targets from exports should be provided when used in
# a data attr.

closure_js_library(
    name = "external",
    srcs = ["external.js"],
    data = ["external2.js"],
)

closure_js_library(
    name = "exports_data",
    exports = [":external"],
)

sh_test(
    name = "exports_data_test",
    srcs = ["exports_data_test.sh"],
    data = [
        # including external.js / external2.js through a rollup target via exports should work.
        ":exports_data",
    ],
)
