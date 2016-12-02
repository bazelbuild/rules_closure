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
load("//closure/private:defs.bzl", "SOY_FILE_TYPE", "unfurl")

_SOYTOJSSRCCOMPILER = '//third_party/java/soy:SoyToJsSrcCompiler'

_SOYTOINCREMENTALDOMSRCCOMPILER = '//third_party/java/soy:SoyToIncrementalDomSrcCompiler'

def _impl(ctx):
  if ctx.attr.incremental_dom:
    if not ctx.attr.should_generate_js_doc:
      fail('should_generate_js_doc must be 1 when using incremental_dom')
    if not ctx.attr.should_provide_require_soy_namespaces:
      fail('should_provide_require_soy_namespaces must be 1 ' +
           'when using incremental_dom')
    if ctx.attr.should_generate_soy_msg_defs:
      fail('should_generate_soy_msg_defs must be 0 when using incremental_dom')
    if ctx.attr.soy_msgs_are_external:
      fail('soy_msgs_are_external must be 0 when using incremental_dom')
    args = ["--outputPathFormat=%s/{INPUT_DIRECTORY}/{INPUT_FILE_NAME}_idom.js" %
            ctx.configuration.genfiles_dir.path]
  else:
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
      args += ["--shouldGenerateGoogMsgDefs"]
  if ctx.attr.plugin_modules:
    args += ["--pluginModules=%s" % ",".join(ctx.attr.plugin_modules)]
  inputs = []
  for f in ctx.files.srcs:
    args.append(f.path)
    inputs.append(f)
  if ctx.file.globals:
    args += ["--compileTimeGlobalsFile=%s" % ctx.file.globals.path]
    inputs.append(ctx.file.globals)
  for dep in unfurl(ctx.attr.deps):
    for f in dep.closure_js_library.descriptors:
      args += ["--protoFileDescriptors=%s" % f.path]
      inputs.append(f)
  ctx.action(
      inputs=inputs,
      outputs=ctx.outputs.outputs,
      executable=ctx.executable.compiler,
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
        "deps": attr.label_list(
            providers=["closure_js_library"]),
        "outputs": attr.output_list(),
        "globals": attr.label(allow_files=True, single_file=True),
        "plugin_modules": attr.label_list(),
        "should_generate_js_doc": attr.bool(default=True),
        "should_provide_require_soy_namespaces": attr.bool(default=True),
        "should_generate_soy_msg_defs": attr.bool(),
        "soy_msgs_are_external": attr.bool(),
        "incremental_dom": attr.bool(),
        "compiler": attr.label(cfg="host", executable=True, mandatory=True),
    },
)

def closure_js_template_library(
    name,
    srcs,
    deps = [],
    suppress = [],
    incremental_dom = False,
    testonly = None,
    globals = None,
    plugin_modules = None,
    should_generate_js_doc = None,
    should_provide_require_soy_namespaces = None,
    should_generate_soy_msg_defs = None,
    soy_msgs_are_external = None,
    **kwargs):
  if incremental_dom:
    compiler = str(Label(_SOYTOINCREMENTALDOMSRCCOMPILER))
    js_srcs = [src + "_idom.js" for src in srcs]
  else:
    compiler = str(Label(_SOYTOJSSRCCOMPILER))
    js_srcs = [src + ".js" for src in srcs]
  _closure_js_template_library(
      name = name + "_soy_js",
      srcs = srcs,
      deps = deps,
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
      compiler = compiler,
  )

  deps = deps + [str(Label("//closure/library")),
                 str(Label("//closure/templates:soy_jssrc"))]
  if incremental_dom:
    deps = deps + [str(Label("//third_party/javascript/incremental_dom"))]

  closure_js_library(
      name = name,
      srcs = js_srcs,
      deps = deps,
      testonly = testonly,
      suppress = suppress + [
          "JSC_NTI_COULD_NOT_INFER_CONST_TYPE",
          "analyzerChecks",
          "reportUnknownTypes",
      ],
      **kwargs
  )
