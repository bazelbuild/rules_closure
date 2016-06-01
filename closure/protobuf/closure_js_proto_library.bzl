# -*- mode: python; -*-
#
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

"""Utilities for building JavaScript Protocol Buffers.
"""

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")

def closure_js_proto_library(
    name,
    srcs,
    data = None,
    visibility = None,
    add_require_for_enums = 0,
    testonly = 0,
    binary = 1,
    import_style = None,
    style = 1,
    protocbin = Label("//third_party/protobuf:protoc_bin"),
    googleformat = Label("//third_party/llvm/llvm/tools/clang:google_format"),
    clangformat = Label("//third_party/llvm/llvm/tools/clang:clang_format_extract")):
  cmd = ["$(location %s)" % protocbin]
  js_out_options = ["library=%s,error_on_name_conflict" % name]
  if add_require_for_enums:
    js_out_options += ["add_require_for_enums"]
  if testonly:
    js_out_options += ["testonly"]
  if binary:
    js_out_options += ["binary"]
  if import_style:
    js_out_options += ["import_style=%s" % import_style]
  cmd += ["--js_out=%s:$(@D)" % ",".join(js_out_options)]
  cmd += ["$(locations " + src + ")" for src in srcs]

  if style:
    style_cmd = ["$(location %s)" % googleformat,
                 "$(location %s)" % clangformat,
                 "$@"]
    style_cmd += ["$(location " + src + ")" for src in srcs]
    native.genrule(
        name = name + "_style",
        srcs = srcs,
        testonly = testonly,
        visibility = visibility,
        message = "Checking Protocol Buffer source style",
        outs = [ "%s-style.txt" % name ],
        tools = [googleformat, clangformat],
        cmd = " ".join(style_cmd),
    )

  native.genrule(
      name = name + "_gen",
      srcs = srcs,
      testonly = testonly,
      visibility = ["//visibility:private"],
      message = "Generating JavaScript Protocol Buffer file",
      outs = [name + ".js"],
      tools = [protocbin],
      cmd = " ".join(cmd),
  )

  closure_js_library(
      name = name,
      srcs = [name + ".js"],
      data = data,
      deps = [
          str(Label("//closure/library")),
          str(Label("//closure/protobuf:jspb")),
      ],
      visibility = visibility,
      suppress = [
          "CLANG_FORMAT",
      ],
  )
