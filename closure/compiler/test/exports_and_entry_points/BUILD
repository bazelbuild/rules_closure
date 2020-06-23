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
load("//closure:defs.bzl", "closure_js_binary", "closure_js_library")

################################################################################
# Assume we want to write a JavaScript program (not a library) that we compile
# into a JavaScript binary and run. In that case, we probably don't need
# exports or entry points.
#
# closure_js_binary() compiles with dependency_mode="LOOSE" by default. So any
# procedural statements (e.g. calling a function) in the global scope will be
# included in the resulting binary, if and only if they exist in a file that
# does not have a goog.provide() statement.

closure_js_library(
    name = "program_lib",
    srcs = ["program.js"],
)

closure_js_binary(
    name = "program_bin",
    deps = [":program_lib"],
)

file_test(
    name = "fileWithoutNamespacesExportsOrEntryPoints_producesBinaryThatExecutesCodeInGlobalNamespace",
    content = "console.log(\"hi\");\n",
    file = "program_bin.js",
)

################################################################################
# Now assume we're writing a library. Our goal is to produce a binary that
# exports functions we can call from a <script> tag in our HTML page:
#
#   <script src="library_bin.js"></script>
#   <script>iWillGoIntoTheBinary();</script>
#
# In this case, we can use the @export annotation.

closure_js_library(
    name = "library_lib",
    srcs = ["library.js"],
)

closure_js_binary(
    name = "library_bin",
    deps = [":library_lib"],
)

file_test(
    name = "es6_exportedFunction_willGoInBinary",
    file = "library_bin.js",
    regexp = "iWillGoIntoTheBinary",
)

################################################################################
# Now assume our library uses Google style namespaces. Then @export alone isn't
# sufficient.
#
# If a source file contains a single goog.provide() statement, then any
# procedural statements in its global scope are considered dead code, unless
# it's specified as an entry point.
#
# So we need both @export and entry_points.

closure_js_library(
    name = "library_goog_lib",
    srcs = ["library_goog.js"],
    suppress = ["useOfGoogProvide"],
)

closure_js_binary(
    name = "library_goog_bin",
    entry_points = ["goog:io.bazel.rules.closure.iWillGoIntoTheBinary"],
    deps = [":library_goog_lib"],
)

file_test(
    name = "goog_exportedFunction_willGoInBinary",
    file = "library_goog_bin.js",
    regexp = "iWillGoIntoTheBinary",
)

################################################################################
# If we use dependency_mode="STRICT" then we're forced to specify an
# entry_point no matter what. But in order to specify an entry_point as a path,
# we must make sure our language is set to ES6.

closure_js_binary(
    name = "program_strict_bin",
    dependency_mode = "PRUNE",
    entry_points = ["closure/compiler/test/empty"],
    deps = [
        ":program_lib",
        "//closure/compiler/test:empty_lib",
    ],
)

file_test(
    name = "strictModeGlobalCodeNotListedInEntryPoints_codeGoesPoof",
    content = "\n",
    file = "program_strict_bin.js",
)

closure_js_binary(
    name = "program_strict_bin2",
    dependency_mode = "PRUNE",
    entry_points = ["closure/compiler/test/exports_and_entry_points/program"],
    deps = [
        ":program_lib",
        "//closure/compiler/test:empty_lib",
    ],
)

file_test(
    name = "strictModeGlobalCodeIsListedInEntryPoints_codeShowsUp",
    content = "console.log(\"hi\");\n",
    file = "program_strict_bin2.js",
)
