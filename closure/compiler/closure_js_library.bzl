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

"""Build definitions for Closure JavaScript libraries."""

load("//closure/private:defs.bzl",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR",
     "JS_LANGUAGE_DEFAULT",
     "JS_DEPS_ATTR",
     "JS_FILE_TYPE",
     "collect_required_css_labels",
     "collect_transitive_js_srcs",
     "determine_js_language",
     "is_using_closure_library")

def _impl(ctx):
  tsrcs, externs, tdata = collect_transitive_js_srcs(ctx)
  srcs = tsrcs + JS_FILE_TYPE.filter(ctx.files.srcs)
  externs += JS_FILE_TYPE.filter(ctx.files.externs)
  if not ctx.files.srcs and not ctx.files.externs and not ctx.attr.exports:
    fail("Either 'srcs', 'externs', or 'exports' must be specified")
  if ctx.attr.no_closure_library:
    if not ctx.files.srcs:
      fail("no_closure_library is pointless when srcs is empty")
    if is_using_closure_library(srcs):
      fail("no_closure_library is pointless when the Closure Library is " +
           "already part of the transitive closure")
  inputs = []
  args = ["--output=%s" % ctx.outputs.provided.path,
          "--output_errors=%s" % ctx.outputs.stderr.path,
          "--label=%s" % ctx.label,
          "--convention=%s" % ctx.attr.convention,
          "--language=%s" % _determine_check_language(ctx.attr.language)]
  if ctx.attr.testonly:
    args += ["--testonly"]
  roots = set(order="compile")
  for direct_src in ctx.files.srcs:
    args += ["--src=%s" % (direct_src.path)]
    inputs.append(direct_src)
    root = direct_src.root.path
    if root:
      roots += [root]
  for src_root in roots:
    args += ["--root=%s" % src_root]
  for direct_extern in ctx.files.externs:
    args += ["--extern=%s" % direct_extern.path]
    inputs.append(direct_extern)
  for direct_dep in ctx.attr.deps:
    args += ["--dep=%s" % direct_dep.js_provided.path]
    inputs.append(direct_dep.js_provided)
    for edep in direct_dep.js_exports:
      args += ["--dep=%s" % edep.js_provided.path]
      inputs.append(edep.js_provided)
  clangFormat = True
  for suppress in ctx.attr.suppress:
    if suppress == "CLANG_FORMAT":
      clangFormat = False
    else:
      args += ["--suppress=%s" % suppress]
  if ctx.attr.internal_expect_failure:
    args += ["--expect_failure"]
  if ctx.attr.internal_expect_warnings:
    args += ["--expect_warnings"]
  argfile = ctx.new_file(ctx.configuration.bin_dir,
                         "%s_worker_input" % ctx.label.name)
  ctx.file_action(output=argfile, content="\n".join(args))
  inputs.append(argfile)

  files = [ctx.outputs.provided, ctx.outputs.stderr]
  if clangFormat and len(ctx.files.srcs) > 0:
    files.append(ctx.outputs.jsstyle)
    style_args = [ctx.executable._clangformat.path,
                  ctx.outputs.jsstyle.path]
    style_inputs = [ctx.executable._clangformat]
    for direct_src in ctx.files.srcs:
      style_args += [direct_src.path]
      style_inputs.append(direct_src)
    ctx.action(
        inputs=style_inputs,
        outputs=[ctx.outputs.jsstyle],
        executable=ctx.executable._googleformat,
        arguments=style_args,
        mnemonic="JSStyleChecker",
        progress_message="Checking %d JS files for style in %s" % (
            len(ctx.files.srcs) + len(ctx.files.externs), ctx.label))

  ctx.action(
      inputs=inputs,
      outputs=[ctx.outputs.provided, ctx.outputs.stderr],
      executable=ctx.executable._jschecker,
      arguments=["@" + argfile.path],
      mnemonic="JsChecker",
      # This is needed to signal Blaze that the action actually supports
      # running as a worker.
      execution_requirements={"supports-workers": "1"},
      progress_message="Checking %d JS files in %s" % (
          len(ctx.files.srcs) + len(ctx.files.externs), ctx.label))
  return struct(files=set(),
                js_language=determine_js_language(ctx),
                js_exports=ctx.attr.exports,
                js_provided=ctx.outputs.provided,
                required_css_labels=collect_required_css_labels(ctx),
                transitive_js_srcs=srcs,
                transitive_js_externs=externs,
                transitive_data=tdata + ctx.files.data,
                runfiles=ctx.runfiles(files=ctx.files.srcs + ctx.files.data,
                                      transitive_files=tsrcs + tdata))

def _determine_check_language(language):
  if language == "ANY":
    return "ECMASCRIPT3"
  return language

def _outputs(attr):
  outputs = {
      "provided": "%{name}-provided.txt",
      "stderr": "%{name}-stderr.txt",
  }
  if "CLANG_FORMAT" not in attr.suppress and len(attr.srcs) > 0:
    outputs["jsstyle"] = "%{name}-jsstyle.txt"
  return outputs

closure_js_library = rule(
    implementation=_impl,
    attrs={
        "convention": attr.string(default="CLOSURE"),
        "deps": JS_DEPS_ATTR,
        "exports": JS_DEPS_ATTR,
        "externs": attr.label_list(allow_files=JS_FILE_TYPE),
        "language": attr.string(default=JS_LANGUAGE_DEFAULT),
        "no_closure_library": attr.bool(default=False),
        "srcs": attr.label_list(allow_files=JS_FILE_TYPE),
        "suppress": attr.string_list(),
        "data": attr.label_list(cfg=DATA_CFG, allow_files=True),

        # internal only
        "internal_expect_failure": attr.bool(default=False),
        "internal_expect_warnings": attr.bool(default=False),
        "_jschecker": attr.label(
            default=Label("//java/com/google/javascript/jscomp:jschecker"),
            executable=True),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
        "_googleformat": attr.label(
            default=Label("//third_party/llvm/llvm/tools/clang:google_format"),
            executable=True),
        "_clangformat": attr.label(
            default=Label("//third_party/llvm/llvm/tools/clang:clang_format_extract"),
            executable=True),
    },
    outputs=_outputs)
