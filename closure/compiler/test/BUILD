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

load("//closure/private:file_test.bzl", "file_test")
load("//closure/private:rule_test.bzl", "rule_test")
load("//closure:defs.bzl", "closure_js_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "hello_lib",
    srcs = ["hello.js"],
    language = "ECMASCRIPT6_STRICT",
)

closure_js_binary(
    name = "hello_bin",
    language = "ECMASCRIPT3",
    pedantic = True,
    deps = [":hello_lib"],
)

file_test(
    name = "minification",
    content = "console.log(\"hello world\");\n",
    file = "hello_bin.js",
)

file_test(
    name = "sourcemap_doesntContainWeirdBazelDirectories",
    content = ("{\n" +
               "\"version\":3,\n" +
               "\"file\":\"/closure/compiler/test/hello_bin.js\",\n" +
               "\"lineCount\":1,\n" +
               "\"mappings\":\"AAgBAA,OAAAC,IAAA,CAAgB,aAAhB;\",\n" +
               "\"sources\":[\"/closure/compiler/test/hello.js\"],\n" +
               "\"names\":[\"console\",\"log\"]\n" +
               "}\n"),
    file = "hello_bin.js.map",
)

closure_js_binary(
    name = "hello_wrap_bin",
    language = "ECMASCRIPT3",
    output_wrapper = "(function(){%output%}).call(this);",
    pedantic = True,
    deps = [":hello_lib"],
)

file_test(
    name = "minificationWithWrapper",
    content = "(function(){console.log(\"hello world\");}).call(this);\n",
    file = "hello_wrap_bin.js",
)

file_test(
    name = "sourcemapWithWrapper_hasDifferentMappingCodes",
    content = ("{\n" +
               "\"version\":3,\n" +
               "\"file\":\"/closure/compiler/test/hello_wrap_bin.js\",\n" +
               "\"lineCount\":1,\n" +
               "\"mappings\":\"A,YAgBAA,OAAAC,IAAA,CAAgB,aAAhB;\",\n" +
               "\"sources\":[\"/closure/compiler/test/hello.js\"],\n" +
               "\"names\":[\"console\",\"log\"]\n" +
               "}\n"),
    file = "hello_wrap_bin.js.map",
)

closure_js_binary(
    name = "hello_es5strict_bin",
    language = "ECMASCRIPT5_STRICT",
    pedantic = True,
    deps = [":hello_lib"],
)

file_test(
    name = "strictOutputLanguage_addsUseStrict",
    content = "'use strict';console.log(\"hello world\");\n",
    file = "hello_es5strict_bin.js",
)

closure_js_library(
    name = "unstrict_lib",
    srcs = ["empty.js"],
    language = "ECMASCRIPT3",
)

closure_js_library(
    name = "hello_decay_lib",
    srcs = ["hello.js"],
    language = "ECMASCRIPT6_STRICT",
    deps = [":unstrict_lib"],
)

rule_test(
    name = "hello_decay_lib_test",
    provides = {"js_language": "^\"ECMASCRIPT6\"$"},
    rule = ":hello_decay_lib",
)

closure_js_binary(
    name = "hello_decay_bin",
    pedantic = True,
    deps = [":hello_decay_lib"],
)

file_test(
    name = "es6strictWithEs3Dep_isAllowed",
    content = "console.log(\"hello world\");\n",
    file = "hello_decay_bin.js",
)

closure_js_library(
    name = "es6const_lib",
    srcs = ["es6const.js"],
    language = "ECMASCRIPT6_STRICT",
    no_closure_library = True,
)

closure_js_binary(
    name = "es6const_bin",
    compilation_level = "WHITESPACE_ONLY",
    language = "ECMASCRIPT5",
    pedantic = True,
    deps = [":es6const_lib"],
)

file_test(
    name = "es6WithConstKeyword_getsRemoved",
    content = "var hello=\"hello world\";console.log(hello);\n",
    file = "es6const_bin.js",
)

closure_js_library(
    name = "es6arrow_lib",
    srcs = ["es6arrow.js"],
    language = "ECMASCRIPT6_STRICT",
    no_closure_library = True,
)

closure_js_binary(
    name = "es6arrow_bin",
    compilation_level = "WHITESPACE_ONLY",
    language = "ECMASCRIPT5",
    pedantic = True,
    deps = [":es6arrow_lib"],
)

file_test(
    name = "es6WithArrowFunction_getsExpanded",
    content = "var hello=function(e){return e+\" world\"};console.log(hello(\"hello\"));\n",
    file = "es6arrow_bin.js",
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
    language = "ECMASCRIPT6_STRICT",
    visibility = ["//visibility:private"],
)

closure_js_library(
    name = "empty_lib",  # this is an alias rule
    visibility = ["//closure/compiler/test/exports_and_entry_points:__pkg__"],
    exports = [":empty_lib_indirectly_hidden"],
)

closure_js_binary(
    name = "hello_output_wrapper_dash_dash_space_bin",
    language = "ECMASCRIPT3",
    output_wrapper = "-- %output%",
    pedantic = True,
    deps = [":hello_lib"],
)

file_test(
    name = "output_wrapper_dash_dash_space",
    content = "-- console.log(\"hello world\");\n",
    file = "hello_output_wrapper_dash_dash_space_bin.js",
)

################################################################################
# If we initialize a variable to an incorrect type, it will fail to compile

closure_js_library(
    name = "type_fail_lib",
    srcs = ["type_fail.js"],
    no_closure_library = True,
)

closure_js_binary(
    name = "type_fail_bin",
    internal_expect_failure = True,
    pedantic = True,
    deps = [":type_fail_lib"],
    defs = ["--new_type_inf"],
)

file_test(
    name = "type_incorrectInitialization_failsToCompile",
    file = "type_fail_bin-stderr.txt",
    regexp = ".*The right side in the assignment is not a subtype of the left",
)
