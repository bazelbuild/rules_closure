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

"""Rule for building JavaScript binaries with Closure Compiler."""

load("//closure/private:defs.bzl",
     "BASE_JS",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR",
     "JSON_JS",
     "JS_DEPS_ATTR",
     "JS_HIDE_WARNING_ARGS",
     "JS_LANGUAGE_DEFAULT",
     "JS_PEDANTIC_ARGS",
     "SOYUTILS_USEGOOG_JS",
     "collect_required_css_labels",
     "collect_transitive_js_srcs",
     "create_argfile",
     "determine_js_language",
     "difference")

_STRICT_LANGUAGES = set([
    "ECMASCRIPT6_TYPED",
    "ECMASCRIPT6_STRICT",
    "ECMASCRIPT5_STRICT",
])

# TODO(jart): Properly propagate exceptions up here.
_SUPPRESS_THINGS_JSCHECKER_ALREADY_DID = [
    # See also: WARNINGS and ERRORS in JsChecker.java
    "--jscomp_off=checkRegExp",
    "--jscomp_off=deprecated",
    "--jscomp_off=deprecatedAnnotations",
    "--jscomp_off=extraRequire",
    "--jscomp_off=lintChecks",
    "--jscomp_off=misplacedTypeAnnotation",
    "--jscomp_off=missingRequire",
    "--jscomp_off=nonStandardJsDocs",
    "--jscomp_off=strictMissingRequire",
]

def _impl(ctx):
  if not ctx.attr.deps:
    fail("closure_js_binary rules can not have an empty 'deps' list")
  srcs, tdata = collect_transitive_js_srcs(ctx)
  if not srcs:
    fail("There are no source files in the transitive closure")
  _validate_css_graph(ctx)
  language_in = determine_js_language(ctx, normalize=True)
  language_out = ctx.attr.language
  files = set([ctx.outputs.out, ctx.outputs.map], order="compile")
  outputs = [ctx.outputs.out, ctx.outputs.map, ctx.outputs.stderr]

  # build list of flags for closure compiler
  args = [
      "JsCompiler",
      "--js_output_file", ctx.outputs.out.path,
      "--create_source_map", ctx.outputs.map.path,
      "--output_errors", ctx.outputs.stderr.path,
      "--language_in", language_in,
      "--language_out", language_out,
      "--compilation_level", ctx.attr.compilation_level,
      "--dependency_mode", ctx.attr.dependency_mode,
      "--warning_level", ctx.attr.warning_level,
      "--generate_exports",
  ]
  if ctx.attr.internal_expect_failure:
    args.append("--expect_failure")
  if ctx.attr.internal_expect_warnings:
    args.append("--expect_warnings")
  roots = set([ctx.outputs.out.root.path], order="compile")
  for src in srcs:
    roots += [src.root.path]
  for root in roots:
    mapping = ""
    if root:
      args.append("--js_module_root")
      args.append(root)
    else:
      mapping += "/"
    args.append("--source_map_location_mapping=%s|%s" % (root, mapping))
  args.extend(JS_HIDE_WARNING_ARGS)
  if ctx.attr.formatting:
    args.append("--formatting")
    args.append(ctx.attr.formatting)
  if ctx.attr.debug:
    args.append("--debug")
  for entry_point in ctx.attr.entry_points:
    _validate_entry_point(entry_point, srcs)
    args.append("--entry_point")
    args.append(entry_point)
  if ctx.attr.testonly:
    args.append("--export_test_functions")
  if ctx.attr.pedantic:
    args.extend(JS_PEDANTIC_ARGS)
    args.append("--use_types_for_optimization")
  args.extend(_SUPPRESS_THINGS_JSCHECKER_ALREADY_DID)
  if ctx.attr.output_wrapper:
    args.append("--output_wrapper")
    args.append(ctx.attr.output_wrapper)
    if ctx.attr.output_wrapper == "(function(){%output%}).call(this);":
      args.append("--assume_function_wrapper")
  if ctx.outputs.property_renaming_report:
    report = ctx.outputs.property_renaming_report
    files += [report]
    outputs += [report]
    args.append("--property_renaming_report")
    args.append(report.path)

  # validate defs
  for flag in ctx.attr.defs:
    if not flag.startswith("--") or (" " in flag and "=" not in flag):
      fail("Please use --flag=value syntax for defs")
  args.extend(ctx.attr.defs)

  # add gigantic list of files
  for config in ctx.files.conformance:
    args.append("--conformance_configs")
    args.append(config.path)
  for src in srcs:
    args.append(src.path)
    if src.owner == BASE_JS:
      if not ctx.attr.debug:
        args.append("--define=goog.DEBUG=false")
      if language_out in _STRICT_LANGUAGES:
        args.append("--define=goog.STRICT_MODE_COMPATIBLE")
    elif src.owner == SOYUTILS_USEGOOG_JS:
      args.append("--define=goog.soy.REQUIRE_STRICT_AUTOESCAPE")
    elif src.owner == JSON_JS:
      # TODO(hochhaus): Make unknownDefines an error for user supplied defines.
      # https://github.com/bazelbuild/rules_closure/issues/79
      args.append("--jscomp_off=unknownDefines")
      args.append("--define=goog.json.USE_NATIVE_JSON")

  inputs = []
  for src in srcs:
    inputs.append(src)
  inputs.extend(ctx.files.conformance)

  # These rule-provided.txt files will not be used by JsCompiler. But we list
  # them as inputs anyway to ensure that JsChecker runs. This is because Bazel
  # only runs an action if something else in the graph depends on its output.
  for dep in ctx.attr.deps:
    inputs.append(dep.js_provided)

  # run our modded closure compiler
  argfile = create_argfile(ctx, args)
  inputs.append(argfile)
  ctx.action(
      inputs=inputs,
      outputs=outputs,
      executable=ctx.executable._ClosureUberAlles,
      arguments=["@" + argfile.path],
      mnemonic="Closure",
      execution_requirements={"supports-workers": "1"},
      progress_message="Compiling %d JavaScript files to %s" % (
          len(srcs), ctx.outputs.out.short_path))

  # this is necessary for closure_js_binary to behave like closure_js_library
  ctx.file_action(output=ctx.outputs.provided, content="")

  return struct(files=files,
                js_language=language_out,
                js_exports=[],
                js_provided=ctx.outputs.provided,
                required_css_labels=set(order="compile"),
                transitive_js_srcs=set([ctx.outputs.out], order="compile"),
                transitive_data=tdata + ctx.files.data,
                runfiles=ctx.runfiles(files=list(files) + ctx.files.data,
                                      transitive_files=srcs + tdata))

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
        "output_wrapper": attr.string(),
        "pedantic": attr.bool(default=False),
        "property_renaming_report": attr.output(),
        "warning_level": attr.string(default="VERBOSE"),
        "data": attr.label_list(cfg="data", allow_files=True),
        "conformance": attr.label_list(allow_files=True),

        # internal only
        "internal_expect_failure": attr.bool(default=False),
        "internal_expect_warnings": attr.bool(default=False),
        "_ClosureUberAlles": attr.label(
            default=Label("//java/io/bazel/rules/closure:ClosureUberAlles"),
            executable=True,
            cfg="host"),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
    },
    outputs={
        "out": "%{name}.js",
        "map": "%{name}.js.map",
        "provided": "%{name}-provided.txt",
        "stderr": "%{name}-stderr.txt",
    })
