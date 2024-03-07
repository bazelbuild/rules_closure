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

load(
    "//closure/private:defs.bzl",
    "CLOSURE_JS_TOOLCHAIN_ATTRS",
    "ClosureCssBinaryInfo",
    "ClosureJsBinaryInfo",
    "ClosureJsLibraryInfo",
    "JS_LANGUAGES",
    "JS_LANGUAGE_IN",
    "JS_LANGUAGE_OUT_DEFAULT",
    "collect_js",
    "collect_runfiles",
    "difference",
    "find_js_module_roots",
    "get_jsfile_path",
    "sort_roots",
    "unfurl",
)
load(
    "//closure/compiler:closure_js_aspect.bzl",
    "closure_js_aspect",
)

_dependency_mode_warning = "\n".join([
    "{target}: dependency_mode={old_mode} is deprecated and will be " +
    "removed soon; prefer to use its equivalent {new_mode}.",
    "",
    "  ** You can use the following buildozer command:",
    "buildozer 'set dependency_mode \"{new_mode}\"' {target}",
])

def _get_dependency_mode_flag(target, attr):
    if attr == "LOOSE":
        print(_dependency_mode_warning.format(
            target = str(target),
            old_mode = "LOOSE",
            new_mode = "PRUNE_LEGACY",
        ))
        return "PRUNE_LEGACY"
    if attr == "STRICT":
        print(_dependency_mode_warning.format(
            target = str(target),
            old_mode = "STRICT",
            new_mode = "PRUNE",
        ))
        return "PRUNE"
    return attr

def _get_src_path(f):
    path = get_jsfile_path(f)
    if path != None:
        if f.extension == "zip":
            return ["--jszip", path]
        return path
    return None

def _impl(ctx):
    if not ctx.attr.deps:
        fail("closure_js_binary rules can not have an empty 'deps' list")
    for flag in ctx.attr.defs:
        if not flag.startswith("--") or (" " in flag and "=" not in flag):
            fail("Please use --flag=value syntax for defs")
    if ctx.attr.language not in JS_LANGUAGES.to_list():
        fail("Unknown language %s try one of these: %s" % (
            ctx.attr.language,
            ", ".join(JS_LANGUAGES.to_list()),
        ))

    deps = unfurl(ctx.attr.deps, provider = ClosureJsLibraryInfo)
    js = collect_js(deps, ctx.attr._closure_library_base, css = ctx.attr.css)
    if not js.srcs:
        fail("There are no JS source files in the transitive closure")

    _validate_css_graph(ctx, js)

    # This is the list of files we'll be generating.
    outputs = [ctx.outputs.bin, ctx.outputs.map, ctx.outputs.stderr]

    # This is the subset of that list we'll report to parent rules.
    files = [ctx.outputs.bin, ctx.outputs.map]

    # JsCompiler is thin veneer over the Closure compiler. It's configured with a
    # superset of its flags. It introduces a private testing API, allows per-file
    # granularity of error suppression, and adds the suppression codes to printed
    # error messages.
    inputs = []
    args = [
        "JsCompiler",
        "--js_output_file",
        ctx.outputs.bin.path,
        "--create_source_map",
        ctx.outputs.map.path,
        "--output_errors",
        ctx.outputs.stderr.path,
        "--language_in",
        JS_LANGUAGE_IN,
        "--language_out",
        ctx.attr.language,
        "--compilation_level",
        ctx.attr.compilation_level,
        "--dependency_mode",
        _get_dependency_mode_flag(ctx.label, ctx.attr.dependency_mode),
        "--warning_level",
        ctx.attr.warning_level,
        "--generate_exports",
        "--process_closure_primitives",
        "--define=goog.json.USE_NATIVE_JSON",
        "--hide_warnings_for=closure/goog/base.js",
    ]

    if not ctx.attr.debug:
        args.append("--define=goog.DEBUG=false")

    # These ClosureJsLibrary protocol buffers contain information about which
    # errors should be suppressed in which files.
    for info in js.infos.to_list():
        args.append("--info")
        args.append(info.path)
        inputs.append(info)

    # We want to test the failure conditions of the compiler from within Bazel,
    # rather than from a system on top of Bazel like shell scripts. In order to
    # do that, we need a way to toggle the return status of the process.
    if ctx.attr.internal_expect_failure:
        args.append("--expect_failure")
    if ctx.attr.internal_expect_warnings:
        args.append("--expect_warnings")

    # We need to help the Closure Compiler turn these weird Bazel paths into
    # proper ES6 module names. So we give it all the directory prefixes that
    # should be cut off. These are basically the same thing as C++ include dirs,
    # except unlike C++ there's no I/O operation penalty to using them since all
    # source paths that exist are being passed as flags.
    js_module_roots = sort_roots(
        depset(transitive = [
            find_js_module_roots(
                [ctx.outputs.bin],
                ctx.workspace_name,
                ctx.label,
                getattr(ctx.attr, "includes", []),
            ),
            js.js_module_roots,
        ]),
    )

    for root in js_module_roots:
        args.append("--js_module_root")
        args.append(root)

    # For the sake of simplicity we're going to assume that the sourcemap file is
    # stored within the same directory as the compiled JS binary; therefore, the
    # JSON sourcemap file should cite that file as relative to itself.
    args.append("--source_map_location_mapping")
    args.append("%s|%s" % (ctx.outputs.bin.path, ctx.outputs.bin.basename))

    # By default we're going to include the raw sources in the .js.map file. This
    # can be disabled with the nodefs attribute.
    args.append("--source_map_include_content")

    # We still need to map the source files to paths on the web server. We're
    # going to use absolute paths relative to the root of the repository. For
    # example if the label is //foo/bar:lol.js then it will be /foo/bar/lol.js on
    # the web server, even if lol.js is generated. If the label is @a//b:c.js
    # then that will be /b/c.js on the web server. The only exception is when the
    # includes attribute has been used, in which case, directory prefixes may be
    # cut off.
    args.append("--source_map_location_mapping")
    args.append(" [synthetic:| [synthetic:")
    for root in js_module_roots:
        args.append("--source_map_location_mapping")
        args.append("%s/|/" % (root))
    args.append("--source_map_location_mapping")
    args.append("|/")

    # Some flags we're merely pass along as-is from our attributes.
    if ctx.attr.formatting:
        args.append("--formatting")
        args.append(ctx.attr.formatting)
    if ctx.attr.debug:
        args.append("--debug")
    for entry_point in ctx.attr.entry_points:
        args.append("--entry_point")
        args.append(entry_point)

    # It would be quite onerous to put an /** @export */ and entry_point on every
    # single testFoo, setUp, and tearDown function. This undocumented flag is a
    # godsend for testing in ADVANCED mode that releases us from this toil.
    if ctx.attr.testonly:
        args.append("--export_test_functions")

    # Those who write JavaScript on the hardest difficulty setting shall be
    # rewarded accordingly.
    if ctx.attr.compilation_level == "ADVANCED":
        args.append("--use_types_for_optimization")

    if ctx.attr.output_wrapper:
        output_wrapper_file = ctx.actions.declare_file(ctx.attr.name + "_output_wrapper_file")
        ctx.actions.write(output = output_wrapper_file, content = ctx.attr.output_wrapper)
        inputs.append(output_wrapper_file)
        args.append("--output_wrapper_file=" + output_wrapper_file.path)
        if ctx.attr.output_wrapper == "(function(){%output%}).call(this);":
            args.append("--assume_function_wrapper")

    if ctx.outputs.property_renaming_report:
        report = ctx.outputs.property_renaming_report
        files.append(report)
        outputs.append(report)
        args.append("--property_renaming_report")
        args.append(report.path)

    # All sources must conform to these protos.
    for config in ctx.files.conformance:
        args.append("--conformance_configs")
        args.append(config.path)
        inputs.append(config)

    # It is better to put a suppress code on the closure_js_library rule that
    # defined the source responsible for an error. We provide an escape hatch for
    # situations in which that would be unfeasible or burdensome.
    for code in ctx.attr.suppress_on_all_sources_in_transitive_closure:
        args.append("--suppress")
        args.append(code)

    # In order for us to feel comfortable creating an optimal experience for 99%
    # of users, we need to provide an escape hatch for the 1%. For example, a
    # user wishing to support IE6 might want to pass the attribute `nodefs =
    # ["--define=goog.json.USE_NATIVE_JSON"]`. Cf. nocopts in cc_library().
    if ctx.attr.nodefs:
        args = [arg for arg in args if arg not in ctx.attr.nodefs]

    all_args = ctx.actions.args()
    all_args.add_all(args)

    # We shall now pass all transitive sources, including externs files.
    all_args.add_all(
        js.srcs,
        map_each = _get_src_path,
        expand_directories = True,
    )
    inputs.extend(js.srcs.to_list())

    # As a matter of policy, we don't add attributes to this rule just because we
    # can. We only add attributes when the Skylark code adds value beyond merely
    # passing those flags along to the Closure Compiler. So users wishing to use
    # the more niche features of the Closure Compiler can do things like pass
    # `defs = ["--polymer_pass"]` to add type safety to Polymer, or the user
    # could pass `defs = ["--env=CUSTOM"]` to get rid of browser externs and
    # slightly speed up compilation.
    all_args.add_all(ctx.attr.defs)

    # Insert an edge into the build graph that produces the minified version of
    # all JavaScript sources in the transitive closure, sans dead code.
    all_args.use_param_file("@@%s", use_always = True)
    all_args.set_param_file_format("multiline")
    ctx.actions.run(
        inputs = inputs,
        outputs = outputs,
        executable = ctx.executable._ClosureWorker,
        arguments = [all_args],
        mnemonic = "Closure",
        execution_requirements = {"supports-workers": "1"},
        progress_message = "Compiling %d JavaScript files to %s" % (
            len(js.srcs.to_list()),
            ctx.outputs.bin.short_path,
        ),
    )

    # This data structure is not information about the compilation but rather a
    # promise to compile. Its fulfillment is the prerogative of ancestors which
    # are free to ignore the binary in favor of the raw sauces propagated by the
    # closure_js_library provider, in which case, no compilation is performed.
    return [
        ClosureJsBinaryInfo(
            bin = ctx.outputs.bin,
            map = ctx.outputs.map,
            language = ctx.attr.language,
        ),
        js,
        DefaultInfo(
            files = depset(files),
            runfiles = collect_runfiles(ctx, files, extra_runfiles_attrs = ["css"]),
        ),
    ]

def _validate_css_graph(ctx, js):
    if ctx.attr.css:
        missing = difference(js.stylesheets, ctx.attr.css[ClosureCssBinaryInfo].labels)
        if missing:
            fail("Dependent JS libraries depend on CSS libraries that weren't " +
                 "compiled into the referenced CSS binary: " +
                 ", ".join(missing))
    elif js.stylesheets:
        fail("Dependent JS libraries depend on CSS libraries, but the 'css' " +
             "attribute is not set to a closure_css_binary that provides the " +
             "rename mapping for those CSS libraries")

closure_js_binary = rule(
    implementation = _impl,
    attrs = dict({
        "compilation_level": attr.string(default = "ADVANCED"),
        "css": attr.label(providers = [ClosureCssBinaryInfo]),
        "debug": attr.bool(default = False),
        "defs": attr.string_list(),
        # TODO(tjgq): Remove the deprecated STRICT/LOOSE in favor of PRUNE/PRUNE_LEGACY.
        "dependency_mode": attr.string(
            default = "PRUNE_LEGACY",
            values = [
                "NONE",
                "SORT_ONLY",
                "LOOSE",
                "STRICT",
                "PRUNE",
                "PRUNE_LEGACY",
            ],
        ),
        "deps": attr.label_list(
            aspects = [closure_js_aspect],
            providers = [ClosureJsLibraryInfo],
        ),
        "entry_points": attr.string_list(),
        "formatting": attr.string(),
        "language": attr.string(default = JS_LANGUAGE_OUT_DEFAULT),
        "nodefs": attr.string_list(),
        "output_wrapper": attr.string(),
        "property_renaming_report": attr.output(),
        "warning_level": attr.string(default = "VERBOSE"),
        "data": attr.label_list(allow_files = True),
        "conformance": attr.label_list(allow_files = True),
        "suppress_on_all_sources_in_transitive_closure": attr.string_list(),

        # internal only
        "internal_expect_failure": attr.bool(default = False),
        "internal_expect_warnings": attr.bool(default = False),
    }, **CLOSURE_JS_TOOLCHAIN_ATTRS),
    outputs = {
        "bin": "%{name}.js",
        "map": "%{name}.js.map",
        "stderr": "%{name}-stderr.txt",
    },
)
