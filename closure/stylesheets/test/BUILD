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
load("//closure:defs.bzl", "closure_css_binary", "closure_css_library", "closure_js_binary", "closure_js_library")

closure_css_library(
    name = "hello_lib",
    srcs = ["hello.css"],
)

closure_css_binary(
    name = "hello_norename_bin",
    renaming = False,
    deps = [":hello_lib"],
)

file_test(
    name = "noRenaming_doesntRenameClasses",
    content = ".immutable-pain{font-weight:bold}",
    file = "hello_norename_bin.css",
)

file_test(
    name = "noRenaming_generatesEmptyRenamingFile",
    content = "// closure_css_binary target had renaming = false\n",
    file = "hello_norename_bin.css.js",
)

closure_css_binary(
    name = "hello_dbg",
    debug = True,
    renaming = False,
    deps = [":hello_lib"],
)

file_test(
    name = "debug_stripsCommentsAndPrettyPrints",
    content = (".immutable-pain {\n" +
               "  font-weight: bold;\n" +
               "}\n"),
    file = "hello_dbg.css",
)

closure_css_binary(
    name = "hello_rename_bin",
    renaming = True,
    deps = [":hello_lib"],
)

file_test(
    name = "renaming_minifiesEachHyphenInClassNameSeparately",
    content = ".a-b{font-weight:bold}",
    file = "hello_rename_bin.css",
)

file_test(
    name = "renaming_generatesClosureRenamingMap",
    content = ("goog.setCssNameMapping({\n" +
               "  \"immutable\": \"a\",\n" +
               "  \"pain\": \"b\"\n" +
               "});\n"),
    file = "hello_rename_bin.css.js",
)

file_test(
    name = "sourcemap",
    content = "{\n" +
              "\"version\":3,\n" +
              "\"file\":\"hello_rename_bin.css.map\",\n" +
              "\"lineCount\":1,\n" +
              "\"mappings\":\"AAAC,IACmB,CAAA,YAAa;\",\n" +
              "\"sources\":[\"closure/stylesheets/test/hello.css\"],\n" +
              "\"names\":[]\n" +
              "}\n",
    file = "hello_rename_bin.css.map",
)

closure_js_library(
    name = "rename_lib",
    srcs = ["rename.js"],
    deps = [":hello_lib"],
)

closure_js_binary(
    name = "rename_bin",
    css = ":hello_rename_bin",
    deps = [":rename_lib"],
)

file_test(
    name = "jsBinaryReferencesCssBinary_googGetCssNameCallsGetRewritten",
    content = "console.log(\"a-b\");\n",
    file = "rename_bin.js",
)

closure_css_binary(
    name = "hello_debug_rename_bin",
    debug = True,
    deps = [":hello_lib"],
)

file_test(
    name = "renamingDebug_addsUnderscoreAfterEachHyphenatedClassNamePiece",
    content = (".immutable_-pain_ {\n" +
               "  font-weight: bold;\n" +
               "}\n"),
    file = "hello_debug_rename_bin.css",
)

file_test(
    name = "renamingDebug_generatesClosureRenamingMap",
    content = ("goog.setCssNameMapping({\n" +
               "  \"immutable\": \"immutable_\",\n" +
               "  \"pain\": \"pain_\"\n" +
               "});\n"),
    file = "hello_debug_rename_bin.css.js",
)

closure_css_library(
    name = "meld_lib",
    srcs = ["meld.css"],
    deps = [":hello_lib"],
)

closure_css_binary(
    name = "meld_bin",
    renaming = False,
    deps = [":meld_lib"],
)

file_test(
    name = "definitionsAcrossFiles_meldsThemTogether",
    content = ".immutable-pain{font-weight:bold;color:red}",
    file = "meld_bin.css",
)

closure_css_library(
    name = "override_lib",
    srcs = ["override.css"],
    deps = [":hello_lib"],
)

closure_css_binary(
    name = "override_bin",
    renaming = False,
    deps = [":override_lib"],
)

file_test(
    name = "laterClassOverridesDefinitions_oldOneGetsEjected",
    content = ".immutable-pain{font-weight:normal}",
    file = "override_bin.css",
)

closure_css_library(
    name = "def_lib",
    srcs = ["def.gss"],
)

closure_css_library(
    name = "wantdef_lib",
    srcs = ["wantdef.gss"],
    deps = [":def_lib"],
)

closure_css_binary(
    name = "wantdef_bin",
    renaming = False,
    deps = [":wantdef_lib"],
)

file_test(
    name = "defInChildTarget_getsPropagatedAutomatically",
    content = ".sadness{color:pink}",
    file = "wantdef_bin.css",
)

closure_css_library(
    name = "provide_lib",
    srcs = ["provide.gss"],
)

closure_css_library(
    name = "require_lib",
    srcs = ["require.gss"],
    deps = [":provide_lib"],
)

closure_css_binary(
    name = "require_bin",
    renaming = False,
    deps = [":require_lib"],
)

file_test(
    name = "provideAndRequire",
    content = ".misery{color:green}",
    file = "require_bin.css",
)

closure_css_library(
    name = "flip_lib",
    srcs = ["flip.css"],
    orientation = "LTR",
)

closure_css_binary(
    name = "flip_bin",
    orientation = "RTL",
    deps = [":flip_lib"],
)

# TODO: Why doesn't URL flipping work?
file_test(
    name = "orientationInBinaryIsDifferent_flipsTheOrientation",
    content = ".a{margin-right:1px}",
    file = "flip_bin.css",
)
