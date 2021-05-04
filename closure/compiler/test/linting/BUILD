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
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "love",
    srcs = ["love.js"],
    internal_expect_failure = True,
)

file_test(
    name = "methodMissingJsdoc_causesError",
    file = "love-stderr.txt",
    regexp = "JSC_MISSING_JSDOC",
)

closure_js_library(
    name = "superfluousSuppress",
    srcs = ["love.js"],
    internal_expect_failure = True,
    suppress = ["JSC_WRONG_NUMBER_OF_PARAMS"],
    tags = ["manual"],
)

file_test(
    name = "superfluousSuppress_yellsAtUserToRemoveSuppress",
    file = "superfluousSuppress-stderr.txt",
    regexp = "superfluous suppress code",
)

closure_js_library(
    name = "lenient_love",
    srcs = ["love.js"],
    lenient = True,
)

file_test(
    name = "lenient_no_warnings",
    content = "",
    file = "lenient_love-stderr.txt",
)

file_test(
    name = "lenient_no_type_check_errors",
    content = "",
    # This is a dummy file to trigger per library type check
    file = "lenient_love_typecheck",
)
