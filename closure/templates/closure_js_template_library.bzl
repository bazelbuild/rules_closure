# -*- mode:python; -*-
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

"""Utilities for compiling Closure Templates to JavaScript.
"""

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")

def closure_js_template_library(
    name,
    srcs,
    data = None,
    deps = [],
    testonly = 0,
    visibility = None,
    globals = None,
    plugin_modules = [],
    should_generate_js_doc = 1,
    should_provide_require_soy_namespaces = 1,
    should_generate_soy_msg_defs = 0,
    soy_msgs_are_external = 0,
    incremental_dom = 0,
    soycompilerbin = str(Label("//closure/templates:SoyToJsSrcCompiler")),
    soyidomcompilerbin = str(Label("//closure/templates:SoyToIncrementalDomSrcCompiler"))):
  if incremental_dom:
    compilerbin = soyidomcompilerbin
    if not should_generate_js_doc:
      fail('should_generate_js_doc must be 1 when using incremental_dom')
    if not should_provide_require_soy_namespaces:
      fail('should_provide_require_soy_namespaces must be 1 when using incremental_dom')
    if should_generate_soy_msg_defs:
      fail('should_generate_soy_msg_defs must be 0 when using incremental_dom')
    if soy_msgs_are_external:
      fail('soy_msgs_are_external must be 0 when using incremental_dom')
  else:
    compilerbin = soycompilerbin

  js_srcs = [src + ".js" for src in srcs]
  cmd = ["$(location %s)" % compilerbin,
         "--outputPathFormat='$(@D)/{INPUT_FILE_NAME}.js'"]
  if not incremental_dom:
    if soy_msgs_are_external:
      cmd += ["--googMsgsAreExternal"]
    if should_generate_js_doc:
      cmd += ["--shouldGenerateJsdoc"]
    if should_provide_require_soy_namespaces:
      cmd += ["--shouldProvideRequireSoyNamespaces"]
    if should_generate_soy_msg_defs:
      cmd += "--shouldGenerateGoogMsgDefs"
  if plugin_modules:
    cmd += ["--pluginModules=%s" % ",".join(plugin_modules)]
  cmd += ["$(location " + src + ")" for src in srcs]
  if globals != None:
    cmd += ["--compileTimeGlobalsFile='$(location %s)'" % globals]
    srcs = srcs + [globals]

  native.genrule(
      name = name + "_soy_js",
      srcs = srcs,
      testonly = testonly,
      visibility = ["//visibility:private"],
      message = "Generating SOY v2 JS files",
      outs = js_srcs,
      tools = [compilerbin],
      cmd = " ".join(cmd),
  )

  deps = deps + [str(Label("//closure/library")),
                 str(Label("//closure/templates:soy_jssrc"))]
  if incremental_dom:
    deps = deps + [str(Label("//closure/templates:incremental_dom"))]

  closure_js_library(
      name = name,
      srcs = js_srcs,
      data = data,
      deps = deps,
      visibility = visibility,
      testonly = testonly,
  )


def closure_template_js_library(**kwargs):
  print("Deprecated: use closure_js_template_library() instead, " +
        "closure_template_java_library will be removed in version 0.3.0")
  closure_js_template_library(**kwargs)
