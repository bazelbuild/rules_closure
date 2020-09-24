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
# Assume we're using traditional Google namespaces.

closure_js_library(
    name = "a",
    srcs = ["a.js"],
    suppress = ["useOfGoogProvide"],
)

closure_js_library(
    name = "b",
    srcs = ["b.js"],
    suppress = ["useOfGoogProvide"],
    deps = [":a"],
)

closure_js_library(
    name = "c",
    srcs = ["c.js"],
    suppress = ["useOfGoogProvide"],
    deps = [
        ":a",
        ":b",
    ],
)

closure_js_library(
    name = "t",
    testonly = True,
    srcs = ["t.js"],
    suppress = ["useOfGoogProvide"],
)

file_test(
    name = "fileWithGoogProvide_providesGoogProvides",
    file = "a.pbtxt",
    regexp = "goog:a",
)

file_test(
    name = "a_noWarnings",
    content = "",
    file = "a-stderr.txt",
)

file_test(
    name = "b_noWarnings",
    content = "",
    file = "b-stderr.txt",
)

file_test(
    name = "c_noWarnings",
    content = "",
    file = "c-stderr.txt",
)

file_test(
    name = "t_noWarnings",
    content = "",
    file = "t-stderr.txt",
)

closure_js_library(
    name = "didNotSpecifyTransitiveDep",
    srcs = ["c.js"],
    internal_expect_failure = True,
    tags = ["manual"],
    deps = [":b"],  # oops I forgot :a, it doesn't matter if :b depends on :a
)

file_test(
    name = "didNotSpecifyTransitiveDep_causesMissingProvideError",
    file = "didNotSpecifyTransitiveDep-stderr.txt",
    regexp = "CR_NOT_PROVIDED",
)

closure_js_library(
    name = "b2",
    srcs = ["b.js"],
    suppress = ["useOfGoogProvide"],
    exports = [":a"],
    deps = [":a"],
)

closure_js_library(
    name = "exportMadeTransitiveDepDirect",
    srcs = ["c.js"],
    suppress = ["useOfGoogProvide"],
    deps = [":b2"],  # but if :b exports :a, then we're ok
)

file_test(
    name = "exportedDependency_wormsAroundStrictsDependencyChecking",
    content = "",
    file = "exportMadeTransitiveDepDirect-stderr.txt",
)

closure_js_library(
    name = "duplicateProvidesWithinALibrary",
    srcs = [
        "a.js",
        "a2.js",
    ],
    internal_expect_failure = True,
    tags = ["manual"],
)

file_test(
    name = "duplicateProvidesWithinALibrary_causesDuplicateProvideError",
    file = "duplicateProvidesWithinALibrary-stderr.txt",
    regexp = "CR_DUPLICATE_PROVIDES",
)

closure_js_library(
    name = "duplicateProvideFromDeps",
    srcs = ["a2.js"],
    internal_expect_failure = True,
    tags = ["manual"],
    deps = [":a"],
)

file_test(
    name = "duplicateProvideFromDeps_causesDuplicateProvideError",
    file = "duplicateProvideFromDeps-stderr.txt",
    regexp = "CR_REDECLARED_PROVIDES",
)

closure_js_library(
    name = "setTestOnlyInLibraryWithoutTestOnly",
    testonly = False,  # <-- oops I forgot this line
    srcs = ["t.js"],
    internal_expect_failure = True,
    tags = ["manual"],
)

file_test(
    name = "setTestOnlyInLibraryWithoutTestOnly_causesDuplicateProvideError",
    file = "setTestOnlyInLibraryWithoutTestOnly-stderr.txt",
    regexp = "CR_INVALID_SETTESTONLY",
)

################################################################################
# Assume we're using ECMASCRIPT6 namespaces.

closure_js_library(
    name = "es6_a",
    srcs = ["es6_a.js"],
)

closure_js_library(
    name = "es6_b",
    srcs = ["es6_b.js"],
    suppress = ["moduleLoad"],
    deps = [":es6_a"],
)

closure_js_library(
    name = "es6_c",
    srcs = ["es6_c.js"],
    deps = [
        ":es6_a",
        ":es6_b",
    ],
)

file_test(
    name = "fileWithoutGoogProvideInEs6Mode_providesShortPathWithoutJs",
    file = "es6_a.pbtxt",
    regexp = "namespace: \"/closure/compiler/test/strict_dependency_checking/es6_a.js\"",
)

closure_js_library(
    name = "es6_didNotSpecifyTransitiveDep",
    srcs = ["es6_c.js"],
    internal_expect_failure = True,
    tags = ["manual"],
    deps = [":es6_b"],  # oops I forgot :es6_a, it doesn't matter if :es6_b depends on :es6_a
)

file_test(
    name = "es6_didNotSpecifyTransitiveDep_causesMissingProvideError",
    file = "es6_didNotSpecifyTransitiveDep-stderr.txt",
    regexp = "CR_NOT_PROVIDED",
)

closure_js_library(
    name = "es6_requireWithinSameLibrary_works",
    srcs = ["es6_c.js"],
    deps = [":es6_b"],
)

closure_js_library(
    name = "hybrid_lib",
    srcs = [
        "a.js",
        "es6_a.js",
    ],
    suppress = ["useOfGoogProvide"],
)

file_test(
    name = "hybridGoogAndEs6Library_onlyProvidesPathForSrcsWithoutGoogProvide",
    file = "hybrid_lib.pbtxt",
    invert = True,
    regexp = "namespace:.*closure/compiler/test/strict_dependency_checking/a",
)

genrule(
    name = "es6_g_generate",
    outs = ["es6_g.js"],
    cmd = "echo 'export function g() { console.log(\"hi\"); }' >$@",
)

closure_js_library(
    name = "es6_g",
    srcs = ["es6_g.js"],
)

file_test(
    name = "generatedEs6Module_providedNamespaceDoesntHaveBazelJunk",
    file = "es6_g.pbtxt",
    invert = True,
    regexp = "namespace: \".*bazel-",
)

genrule(
    name = "es6_g2_generate",
    outs = ["es6_g2.js"],
    cmd = "echo 'import { g } from \"/closure/compiler/test/strict_dependency_checking/es6_g.js\"; g();' >$@",
)

genrule(
    name = "es6_g3_generate",
    outs = ["es6_g3.js"],
    cmd = "echo 'import { g } from \"./es6_g.js\"; g();' >$@",
)

closure_js_library(
    name = "es6_g3_gen_lib",
    srcs = [":es6_g_generate", ":es6_g3_generate"],
)

closure_js_binary(
    name = "es6_relative_imports_gen_srcs_bin",
    entry_points = [
        "closure/compiler/test/strict_dependency_checking/es6_g3.js",
    ],
    deps = [":es6_g3_gen_lib"],
)

file_test(
    name = "es6ModulesWithRelativeImports_compileCorrectlyWhenSourcesAreGenerated",
    content = "console.log(\"hi\");\n",
    file = "es6_relative_imports_gen_srcs_bin.js",
)

closure_js_library(
    name = "es6_g2",
    srcs = ["es6_g2.js"],
    suppress = ["moduleLoad"],
    deps = ["es6_g"],
)

closure_js_binary(
    name = "es6_g2_bin",
    entry_points = [
        "closure/compiler/test/strict_dependency_checking/es6_g2.js",
    ],
    deps = [":es6_g2"],
)

file_test(
    name = "es6ModulesWithRootPaths_compileCorrectlyWhenReferencedWithoutRootPrefix",
    content = "console.log(\"hi\");\n",
    file = "es6_g2_bin.js",
)

closure_js_library(
    name = "es6_relative_imports_lib",
    srcs = [
        "es6_d.js",
        "subdir/es6_e.js",
    ],
    suppress = ["moduleLoad"],
    tags = ["manual"],
    deps = [":es6_a"],
)

closure_js_binary(
    name = "es6_relative_imports_bin",
    entry_points = [
        "closure/compiler/test/strict_dependency_checking/subdir/es6_e.js",
    ],
    deps = [":es6_relative_imports_lib"],
)

file_test(
    name = "es6RelativeImports_workCorrectly",
    content = "console.log(\"a\");\n",
    file = "es6_relative_imports_bin.js",
)
