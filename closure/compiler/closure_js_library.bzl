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
     "BASE_JS",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR",
     "JS_LANGUAGE_DEFAULT",
     "JS_DEPS_ATTR",
     "JS_FILE_TYPE",
     "collect_required_css_labels",
     "collect_transitive_js_srcs",
     "create_argfile",
     "determine_js_language")

def _impl(ctx):
  tsrcs, tdata = collect_transitive_js_srcs(ctx)
  srcs = tsrcs + JS_FILE_TYPE.filter(ctx.files.srcs)
  if ctx.files.externs:
    print("closure_js_library 'externs' is deprecated; use 'srcs'")
    srcs += JS_FILE_TYPE.filter(ctx.files.externs)
  if not ctx.files.srcs and not ctx.files.externs and not ctx.attr.exports:
    fail("Either 'srcs' or 'exports' must be specified")
  if ctx.attr.no_closure_library:
    if not ctx.files.srcs:
      fail("no_closure_library is pointless when srcs is empty")
    for src in srcs:
      if src.owner == BASE_JS:
        fail("no_closure_library is pointless when the Closure Library is " +
             "already part of the transitive closure")
  inputs = []
  args = [
      "JsChecker",
      "--output", ctx.outputs.provided.path,
      "--output_errors", ctx.outputs.stderr.path,
      "--label", ctx.label,
      "--convention", ctx.attr.convention,
      "--language", _determine_check_language(ctx.attr.language),
  ]
  proto_descriptor_sets = []
  if ctx.attr.proto_descriptor_set:
    proto_descriptor_sets += [ctx.attr.proto_descriptor_set]
  if ctx.attr.testonly:
    args.append("--testonly")
  roots = set(order="compile")
  for direct_src in ctx.files.srcs + ctx.files.externs:
    args.append("--src")
    args.append(direct_src.path)
    inputs.append(direct_src)
    root = direct_src.root.path
    if root:
      roots += [root]
  for src_root in roots:
    args.append("--root")
    args.append(src_root)
  for direct_dep in ctx.attr.deps:
    args.append("--dep")
    args.append(direct_dep.js_provided.path)
    inputs.append(direct_dep.js_provided)
    for edep in direct_dep.js_exports:
      args.append("--dep")
      args.append(edep.js_provided.path)
      inputs.append(edep.js_provided)
    if hasattr(direct_dep, "proto_descriptor_sets"):
      proto_descriptor_sets += direct_dep.proto_descriptor_sets
  for s in ctx.attr.suppress:
    args.append("--suppress")
    args.append(s)
  if ctx.attr.internal_expect_failure:
    args.append("--expect_failure")
  argfile = create_argfile(ctx, args)
  inputs.append(argfile)
  ctx.action(
      inputs=inputs,
      outputs=[ctx.outputs.provided, ctx.outputs.stderr],
      executable=ctx.executable._ClosureUberAlles,
      arguments=["@@" + argfile.path],
      mnemonic="Closure",
      execution_requirements={"supports-workers": "1"},
      progress_message="Checking %d JS files in %s" % (
          len(ctx.files.srcs) + len(ctx.files.externs), ctx.label))
  return struct(files=set(),
                proto_descriptor_sets=proto_descriptor_sets,
                js_language=determine_js_language(ctx),
                js_exports=ctx.attr.exports,
                js_provided=ctx.outputs.provided,
                required_css_labels=collect_required_css_labels(ctx),
                transitive_js_srcs=srcs,
                transitive_data=tdata + ctx.files.data,
                runfiles=ctx.runfiles(files=ctx.files.srcs + ctx.files.data,
                                      transitive_files=tsrcs + tdata))

def _determine_check_language(language):
  if language == "ANY":
    return "ECMASCRIPT3"
  return language

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
        "proto_descriptor_set": attr.label(allow_files=True),
        "suppress": attr.string_list(),
        "data": attr.label_list(cfg="data", allow_files=True),

        # internal only
        "internal_expect_failure": attr.bool(default=False),
        "_ClosureUberAlles": attr.label(
            default=Label("//java/io/bazel/rules/closure:ClosureUberAlles"),
            executable=True,
            cfg="host"),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
    },
    outputs={
        "provided": "%{name}-provided.txt",
        "stderr": "%{name}-stderr.txt",
    })
