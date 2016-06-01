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
load("//closure/private:defs.bzl", "SOY_FILE_TYPE")


def _impl(ctx):
  if ctx.attr.incremental_dom:
    compilerbin = ctx.executable._soyidomcompilerbin
    if not ctx.attr.should_generate_js_doc:
      fail('should_generate_js_doc must be 1 when using incremental_dom')
    if not ctx.attr.should_provide_require_soy_namespaces:
      fail('should_provide_require_soy_namespaces must be 1 when using incremental_dom')
    if ctx.attr.should_generate_soy_msg_defs:
      fail('should_generate_soy_msg_defs must be 0 when using incremental_dom')
    if ctx.attr.soy_msgs_are_external:
      fail('soy_msgs_are_external must be 0 when using incremental_dom')
  else:
    compilerbin = ctx.executable._soycompilerbin

  args = ["--outputPathFormat=%s/{INPUT_DIRECTORY}/{INPUT_FILE_NAME}.js" %
          ctx.configuration.genfiles_dir.path]
  if not ctx.attr.incremental_dom:
    if ctx.attr.soy_msgs_are_external:
      args += ["--googMsgsAreExternal"]
    if ctx.attr.should_generate_js_doc:
      args += ["--shouldGenerateJsdoc"]
    if ctx.attr.should_provide_require_soy_namespaces:
      args += ["--shouldProvideRequireSoyNamespaces"]
    if ctx.attr.should_generate_soy_msg_defs:
      args += "--shouldGenerateGoogMsgDefs"
  if ctx.attr.plugin_modules:
    args += ["--pluginModules=%s" % ",".join(ctx.attr.plugin_modules)]
  args += [src.path for src in ctx.files.srcs]
  srcs = ctx.files.srcs
  if ctx.attr.globals:
    args += ["--compileTimeGlobalsFile='%s'" % ctx.attr.globals.path]
    srcs += ctx.attr.globals

  ctx.action(
      inputs=srcs,
      outputs=ctx.outputs.outputs,
      executable=compilerbin,
      arguments=args,
      mnemonic="SoyCompiler",
      progress_message = "Generating %d SOY v2 JS file(s)" % len(
        ctx.attr.outputs),
  )


_closure_js_template_library = rule(
    implementation=_impl,
    output_to_genfiles = True,
    attrs={
        "srcs": attr.label_list(allow_files=SOY_FILE_TYPE),
        "outputs": attr.output_list(),
        "globals": attr.label_list(),
        "plugin_modules": attr.label_list(),
        "should_generate_js_doc": attr.bool(default=True),
        "should_provide_require_soy_namespaces": attr.bool(default=True),
        "should_generate_soy_msg_defs": attr.bool(default=False),
        "soy_msgs_are_external": attr.bool(default=False),
        "incremental_dom": attr.bool(default=False),

        # internal only
        "_soycompilerbin": attr.label(
            default=Label("//closure/templates:SoyToJsSrcCompiler"),
            executable=True),
        "_soyidomcompilerbin": attr.label(
            default=Label("//closure/templates:SoyToIncrementalDomSrcCompiler"),
            executable=True),
    },
)

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
    incremental_dom = 0):
  js_srcs = [src + ".js" for src in srcs]
  _closure_js_template_library(
      name = name + "_soy_js",
      srcs = srcs,
      outputs = js_srcs,
      testonly = testonly,
      visibility = ["//visibility:private"],
      globals = globals,
      plugin_modules = plugin_modules,
      should_generate_js_doc = should_generate_js_doc,
      should_provide_require_soy_namespaces = should_provide_require_soy_namespaces,
      should_generate_soy_msg_defs = should_generate_soy_msg_defs,
      soy_msgs_are_external = soy_msgs_are_external,
      incremental_dom = incremental_dom,
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
      suppress = [
          "CLANG_FORMAT",
      ],
  )


def closure_template_js_library(**kwargs):
  print("Deprecated: use closure_js_template_library() instead, " +
        "closure_template_java_library will be removed in version 0.3.0")
  closure_js_template_library(**kwargs)
