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

"""Rule for building JavaScript binaries with Closure Compiler.
"""

load("//closure/private:defs.bzl",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR",
     "JS_DEPS_ATTR",
     "JS_LANGUAGE_DEFAULT",
     "JS_PEDANTIC_ARGS",
     "JS_HIDE_WARNING_ARGS",
     "collect_js_srcs",
     "collect_required_css_labels",
     "determine_js_language",
     "difference",
     "is_using_closure_library")

def _impl(ctx):
  if not ctx.attr.deps:
    fail("closure_js_binary rules can not have an empty 'deps' list")
  srcs, externs = collect_js_srcs(ctx)
  if not srcs:
    fail("There are no source files in the transitive closure")
  _validate_css_graph(ctx)
  language_in = determine_js_language(ctx, normalize=True)
  language_out = ctx.attr.language
  args = [
      "--js_output_file=%s" % ctx.outputs.out.path,
      "--create_source_map=%s" % ctx.outputs.map.path,
      "--language_in=%s" % language_in,
      "--language_out=%s" % language_out,
      "--compilation_level=%s" % ctx.attr.compilation_level,
      "--dependency_mode=%s" % ctx.attr.dependency_mode,
      "--warning_level=VERBOSE",
      "--new_type_inf",
      "--generate_exports",
  ]
  roots = set([ctx.outputs.out.root.path], order="compile")
  for src in srcs:
    roots += [src.root.path]
  for root in roots:
    mapping = ""
    if root:
      args += ["--js_module_root=%s" % root]
    else:
      mapping += "/"
    args += ["--source_map_location_mapping=%s|%s" % (root, mapping)]
  args += JS_HIDE_WARNING_ARGS
  if ctx.attr.formatting:
    args += ["--formatting=" + ctx.attr.formatting]
  if ctx.attr.debug:
    args += ["--debug"]
  elif is_using_closure_library(srcs):
    args += ["--define=goog.DEBUG=false"]
  for entry_point in ctx.attr.entry_points:
    _validate_entry_point(entry_point, srcs)
    args += ["--entry_point=" + entry_point]
  if ctx.attr.pedantic:
    args += JS_PEDANTIC_ARGS
    args += ["--use_types_for_optimization"]
  args += ctx.attr.defs
  args += ["--externs=%s" % extern.path for extern in externs]
  args += ["--js=%s" % src.path for src in srcs]
  ctx.action(
      inputs=list(srcs) + list(externs),
      outputs=[ctx.outputs.out, ctx.outputs.map],
      executable=ctx.executable._compiler,
      arguments=args,
      mnemonic="JSCompile",
      progress_message="Compiling %d JavaScript files to %s" % (
          len(srcs) + len(externs),
          ctx.outputs.out.short_path))
  ctx.file_action(output=ctx.outputs.provided, content="")
  js_files = set([ctx.outputs.out], order="compile")
  return struct(files=js_files,
                js_language=language_out,
                js_exports=[],
                js_provided=ctx.outputs.provided,
                required_css_labels=set(order="compile"),
                transitive_js_srcs=js_files,
                transitive_js_externs=set(order="compile"))

def _validate_css_graph(ctx):
  required_css_labels = collect_required_css_labels(ctx)
  if ctx.attr.css:
    missing = difference(required_css_labels,
                         ctx.attr.css.transitive_css_labels)
    if missing:
      fail("Dependent JS libraries depend on CSS libraries that weren't " +
           "compiled into the referenced CSS binary: " +
           ", ".join(missing))
  else:
    if required_css_labels:
      fail("Dependent JS libraries depend on CSS libraries, but the 'css' " +
           "attribute is not set to a closure_css_binary that provides the " +
           "rename mapping for those CSS libraries")

def _validate_entry_point(entry_point, srcs):
  if entry_point.startswith('goog:'):
    if '/' in entry_point:
      fail("Closure namespace entry_point should not contain '/': " +
           entry_point)
  else:
    if entry_point.endswith('.js'):
      fail("Do not use '.js' at the end of entry_point: " + entry_point)
    found = False
    maybe = []
    for src in srcs:
      if src.short_path == entry_point + '.js':
        found = True
        break
      if entry_point in src.short_path and src.short_path.endswith('.js'):
        maybe += [src.short_path[:-3]]
    if not found:
      prefix = "Invalid entry_point: %s\n\n" % entry_point
      if maybe:
        fail(prefix + "Perhaps you meant one of following:\n\n  - " +
             "\n  - ".join(maybe))
      else:
        extra = ""
        if '/' not in entry_point:
          extra = (".\n\nIf you intended to specify a goog.provide'd " +
                   "namespace then you need to use a 'goog:' prefix")
        fail(prefix +
             "There is no JS source in the transitive closure of " +
             "dependencies for this rule whose path is equivalent " +
             "to this name" + extra)

closure_js_binary = rule(
    implementation=_impl,
    attrs={
        "compilation_level": attr.string(default="ADVANCED"),
        "css": attr.label(
            allow_files=False,
            providers=["js_css_renaming_map",
                       "transitive_css_labels"]),
        "debug": attr.bool(default=False),
        "defs": attr.string_list(),
        "dependency_mode": attr.string(default="LOOSE"),
        "deps": JS_DEPS_ATTR,
        "entry_points": attr.string_list(default=[]),
        "formatting": attr.string(),
        "language": attr.string(default="ECMASCRIPT3"),
        "pedantic": attr.bool(default=False),
        "_compiler": attr.label(
            default=Label("//closure/compiler"),
            executable=True),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
    },
    outputs={
        "out": "%{name}.js",
        "map": "%{name}.js.map",
        "provided": "%{name}-provided.txt",
    })
