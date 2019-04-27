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

load(
    "//closure/private:defs.bzl",
    "CLOSURE_JS_TOOLCHAIN_ATTRS",
    "JS_FILE_TYPE",
    "JS_LANGUAGE_IN",
    "collect_js",
    "collect_runfiles",
    "convert_path_to_es6_module_name",
    "create_argfile",
    "find_js_module_roots",
    "library_level_checks",
    "make_jschecker_progress_message",
    "sort_roots",
    "unfurl",
)
load(
    "//closure/compiler:closure_js_aspect.bzl",
    "closure_js_aspect",
)

def _maybe_declare_file(actions, file, name):
    if file:
        return file
    return actions.declare_file(name)

def create_closure_js_library(
        ctx,
        srcs = [],
        deps = [],
        exports = [],
        suppress = [],
        lenient = False,
        convention = "CLOSURE"):
    """ Returns closure_js_library metadata with provided attributes.

    Note that the returned struct is not a proper provider since existing contract
    of closure_js_library is not compatible with it. The rule calling this method
    could assign properties of the returned struct to its own result to fullfil
    the contract expected by the bazel closure rules.

    Note that rules using this helper should extend its attribute set with
    CLOSURE_JS_TOOLCHAIN_ATTRS in order to make the closure toolchain available.

    Args:
      ctx: ctx for the rule
      srcs: JavaScript srcs for the library
      deps: deps of the library
      exports: exports for the library
      suppress: list of strings containing DiagnosticGroup (coarse grained) or
        DiagnosticType (fine grained) codes. These apply not only to JsChecker,
        but also propagate up to closure_js_binary.
      lenient: makes the library lenient which suppresses handful of checkings in
        one shot.

    Returns:
      A closure_js_library metadata struct with exports and closure_js_library attribute
    """

    if not hasattr(ctx.files, "_ClosureWorker") or not hasattr(ctx.files, "_closure_library_base"):
        fail("Closure toolchain undefined; rule should include CLOSURE_JS_TOOLCHAIN_ATTRS")

    # testonly exist for all rules but if it is an aspect it need to accessed over ctx.rule.
    testonly = ctx.attr.testonly if hasattr(ctx.attr, "testonly") else ctx.rule.attr.testonly

    return _closure_js_library_impl(
        ctx.actions,
        ctx.label,
        ctx.workspace_name,
        srcs = srcs,
        deps = deps,
        exports = exports,
        suppress = suppress,
        lenient = lenient,
        convention = convention,
        testonly = testonly,
        closure_library_base = ctx.files._closure_library_base,
        closure_worker = ctx.executable._ClosureWorker,
    )

def _closure_js_library_impl(
        actions,
        label,
        workspace_name,
        srcs,
        deps,
        testonly,
        suppress,
        lenient,
        convention,
        closure_library_base,
        closure_worker,
        includes = (),
        exports = depset(),
        internal_descriptors = depset(),
        no_closure_library = False,
        internal_expect_failure = False,

        # These file definitions for our outputs are deprecated,
        # and will be replaced with |actions.declare_file()| soon.
        deprecated_info_file = None,
        deprecated_stderr_file = None,
        deprecated_ijs_file = None,
        deprecated_typecheck_file = None):
    # TODO(yannic): Figure out how to modify |find_js_module_roots|
    # so that we won't need |workspace_name| anymore.

    if lenient:
        suppress = suppress + [
            "analyzerChecks",
            "analyzerChecksInternal",
            "deprecated",
            "legacyGoogScopeRequire",
            "lintChecks",
            "missingOverride",
            "reportUnknownTypes",
            "strictCheckTypes",
            "strictModuleChecks",
            "superfluousSuppress",
            "unnecessaryEscape",
            "underscore",
        ]

    # TODO(yannic): Always use |actions.declare_file()|.
    info_file = _maybe_declare_file(
        actions,
        deprecated_info_file,
        "%s.pbtxt" % label.name,
    )
    stderr_file = _maybe_declare_file(
        actions,
        deprecated_stderr_file,
        "%s-stderr.txt" % label.name,
    )
    ijs_file = _maybe_declare_file(
        actions,
        deprecated_ijs_file,
        "%s.i.js" % label.name,
    )

    # Create a list of direct children of this rule. If any direct dependencies
    # have the exports attribute, those labels become direct dependencies here.
    deps = unfurl(deps, provider = "closure_js_library")

    # Collect all the transitive stuff the child rules have propagated. Bazel has
    # a special nested set data structure that makes this efficient.
    js = collect_js(deps, closure_library_base, bool(srcs), no_closure_library)

    # If closure_js_library depends on closure_css_library, that means
    # goog.getCssName() is being used in srcs to reference CSS names in the
    # dependent library. In order to guarantee renaming works, we're going to
    # pass along all those CSS library labels to closure_js_binary. Then when the
    # JS binary is compiled, we'll make sure it's linked against a CSS binary
    # which is a superset of the CSS libraries in its transitive closure.
    stylesheets = []
    for dep in deps:
        if hasattr(dep, "closure_css_library"):
            stylesheets.append(dep.label)

    # JsChecker is a program that's run via the ClosureWorker persistent Bazel
    # worker. This program is a modded version of the Closure Compiler. It does
    # syntax checking and linting on the srcs files specified by this target, and
    # only this target. It does not output a JS file, but it does output a
    # ClosureJsLibrary protobuf info file with useful information extracted from
    # the abstract syntax tree, such as provided namespaces. This information is
    # propagated up to parent rules for strict dependency checking. It's also
    # used by the Closure Compiler when producing the final JS binary.
    args = [
        "JsChecker",
        "--label",
        str(label),
        "--output",
        info_file.path,
        "--output_errors",
        stderr_file.path,
        "--output_ijs_file",
        ijs_file.path,
        "--convention",
        convention,
    ]

    # Because JsChecker is an edge in the build graph, we need to declare all of
    # its input vertices.
    inputs = []

    # We want to test the failure conditions of this rule from within Bazel,
    # rather than from a meta-system like shell scripts. In order to do that, we
    # need a way to toggle the return status of the process.
    if internal_expect_failure:
        args.append("--expect_failure")

    # JsChecker wants to know if this is a testonly rule so it can throw an error
    # if goog.setTestOnly() is used.
    if testonly:
        args.append("--testonly")

    # The suppress attribute is a Closure Rules feature that makes warnings and
    # errors go away. It's a list of strings containing DiagnosticGroup (coarse
    # grained) or DiagnosticType (fine grained) codes. These apply not only to
    # JsChecker, but also propagate up to closure_js_binary.
    for s in suppress:
        args.append("--suppress")
        args.append(s)

    # Pass source file paths to JsChecker. Under normal circumstances, these
    # paths appear to be relative to the root of the repository. But they're
    # actually relative to the ctx.action working directory, which is a folder
    # full of symlinks generated by Bazel which point to the actual files. These
    # paths might contain weird bazel-out/blah/external/ prefixes. These paths
    # are by no means canonical and can change for a particular file based on
    # where the ctx.action is located.
    # TODO(davido): Find out how to avoid that hack
    srcs_it = srcs
    if type(srcs) == "depset":
        srcs_it = srcs.to_list()
    for f in srcs_it:
        args.append("--src")
        args.append(f.path)
        inputs.append(f)

    # In order for JsChecker to turn weird Bazel paths into ES6 module names, we
    # need to give it a list of path prefixes to strip. By default, the ES6
    # module name is the same as the filename relative to the root of the
    # repository, ignoring the workspace name. The exception is when the includes
    # attribute is being used, which chops the path down even further.
    js_module_roots = sort_roots(
        find_js_module_roots(srcs, workspace_name, label, includes),
    )
    for root in js_module_roots:
        args.append("--js_module_root")
        args.append(root)

    # We keep track of ES6 module names so we can guarantee that no namespace
    # collisions exist for any particular transitive closure. By making it
    # canonical, we can use it to propagate suppressions up to closure_js_binary.
    # TODO(davido): Find out how to avoid that hack
    modules = [
        convert_path_to_es6_module_name(
            f.path if not f.is_directory else f.path + "/*.js",
            js_module_roots,
        )
        for f in srcs_it
    ]
    for module in modules:
        if module in js.modules.to_list():
            fail(("ES6 namespace '%s' already defined by a dependency. Check the " +
                  "deps transitively. Remember that namespaces are relative to the " +
                  "root of the repository unless includes=[...] is used") % module)
    if len(modules) != len(depset(modules).to_list()):
        fail("Intrarule namespace collision detected")

    # Give JsChecker the ClosureJsLibrary protobufs outputted by direct children.
    for dep in deps:
        # Polymorphic rules, e.g. closure_css_library, might not provide this.
        info = getattr(dep.closure_js_library, "info", None)
        if info:
            args.append("--dep")
            args.append(info.path)
            inputs.append(info)

    # The list of flags could potentially be very long. So we're going to write
    # them all to a file which gets loaded automatically by our BazelWorker
    # middleware.
    argfile = create_argfile(actions, label.name, args)
    inputs.append(argfile)

    # Add a JsChecker edge to the build graph. The command itself will only be
    # executed if something that requires its output is executed.
    actions.run(
        inputs = inputs,
        outputs = [info_file, stderr_file, ijs_file],
        executable = closure_worker,
        arguments = ["@@" + argfile.path],
        mnemonic = "Closure",
        execution_requirements = {"supports-workers": "1"},
        progress_message = make_jschecker_progress_message(srcs, label),
    )

    library_level_checks(
        actions = actions,
        label = label,
        ijs_deps = js.ijs_files,
        srcs = srcs,
        executable = closure_worker,
        output = _maybe_declare_file(
            actions,
            deprecated_typecheck_file,
            "%s_typecheck" % label.name,
        ),
        suppress = suppress,
        internal_expect_failure = internal_expect_failure,
    )

    if type(internal_descriptors) == "list":
        internal_descriptors = depset(internal_descriptors)

    # We now export providers to any parent Target. This is considered a public
    # interface because other Skylark rules can be designed to do things with
    # this data. Other Skylark rules can even export their own provider with the
    # same name to become polymorphically compatible with this one.
    return struct(
        # Iterable<Target> of deps that should only become deps in parent rules.
        # Exports are not deps of the Target to which they belong. The exports
        # provider does not contain the exports its deps export. Targets in this
        # provider are not necessarily guaranteed to have a closure_js_library
        # provider. Rules allowing closure_js_library deps MUST also treat
        # exports of those deps as direct dependencies of the Target. If those
        # rules are library rules, then they SHOULD also provide an exports
        # attribute of their own which is propagated to parent targets via the
        # exports provider, along with any exports those exports export. The
        # exports attribute MUST NOT contain files and SHOULD NOT impose
        # restrictions on what providers a Target must have. Rules exporting this
        # provider MUST NOT allow deps to be set if srcs is empty. Aspects
        # exporting this provider MAY turn deps into exports if srcs is empty and
        # the exports attribute does not exist. The exports feature can be abused
        # by users to circumvent strict deps checking and therefore should be
        # used with caution.
        exports = unfurl(exports),
        # All of the subproviders below are considered optional and MUST be
        # accessed using getattr(x, y, default). See collect_js() in defs.bzl.
        closure_js_library = struct(
            # File pointing to a ClosureJsLibrary protobuf file in pbtxt format
            # that's generated by this specific Target. It contains some metadata
            # as well as information extracted from inside the srcs files, e.g.
            # goog.provide'd namespaces. It is used for strict dependency
            # checking, a.k.a. layering checks.
            info = info_file,
            # NestedSet<File> of all info files in the transitive closure. This
            # is used by JsCompiler to apply error suppression on a file-by-file
            # basis.
            infos = depset([info_file], transitive = [js.infos]),
            ijs = ijs_file,
            ijs_files = depset([ijs_file], transitive = [js.ijs_files]),
            # NestedSet<File> of all JavaScript source File artifacts in the
            # transitive closure. These files MUST be JavaScript.
            srcs = depset(srcs_it, transitive = [js.srcs]),
            # NestedSet<String> of all execroot path prefixes in the transitive
            # closure. For very simple projects, it will be empty. It is useful
            # for getting rid of Bazel generated directories, workspace names,
            # etc. out of module paths.  It contains the cartesian product of
            # generated roots, external repository roots, and includes
            # prefixes. This is passed to JSCompiler via the --js_module_root
            # flag. See find_js_module_roots() in defs.bzl.
            js_module_roots = depset(js_module_roots, transitive = [js.js_module_roots]),
            # NestedSet<String> of all ES6 module name strings in the transitive
            # closure. These are generated from the source file path relative to
            # the longest matching root prefix. It is used to guarantee that
            # within any given transitive closure, no namespace collisions
            # exist. These MUST NOT begin with "/" or ".", or contain "..".
            modules = depset(modules, transitive = [js.modules]),
            # NestedSet<File> of all protobuf definitions in the transitive
            # closure. It is used so Closure Templates can have information about
            # the structure of protobufs so they can be easily rendered in .soy
            # files with type safety. See closure_js_template_library.bzl.
            descriptors = depset(transitive = [js.descriptors, internal_descriptors]),
            # NestedSet<Label> of all closure_css_library rules in the transitive
            # closure. This is used by closure_js_binary can guarantee the
            # completeness of goog.getCssName() substitutions.
            stylesheets = depset(stylesheets, transitive = [js.stylesheets]),
            # Boolean indicating indicating if Closure Library's base.js is part
            # of the srcs subprovider. This field exists for optimization.
            has_closure_library = js.has_closure_library,
        ),
    )

def _closure_js_library(ctx):
    if not ctx.files.srcs and not ctx.files.externs and not ctx.attr.exports:
        fail("Either 'srcs' or 'exports' must be specified")
    if not ctx.files.srcs and ctx.attr.deps:
        fail("'srcs' must be set when using 'deps', otherwise consider 'exports'")
    if not ctx.files.srcs and (ctx.attr.suppress or ctx.attr.lenient):
        fail("'srcs' must be set when using 'suppress' or 'lenient'")
    if ctx.attr.language:
        print("The closure_js_library 'language' attribute is now removed and " +
              "is always set to " + JS_LANGUAGE_IN)

    # Create a list of the sources defined by this specific rule.
    srcs = ctx.files.srcs
    if ctx.files.externs:
        print("closure_js_library 'externs' is deprecated; just use 'srcs'")
        srcs = ctx.files.externs + srcs

    library = _closure_js_library_impl(
        ctx.actions,
        ctx.label,
        ctx.workspace_name,
        srcs,
        ctx.attr.deps,
        ctx.attr.testonly,
        ctx.attr.suppress,
        ctx.attr.lenient,
        ctx.attr.convention,
        ctx.files._closure_library_base,
        ctx.executable._ClosureWorker,
        getattr(ctx.attr, "includes", []),
        ctx.attr.exports,
        ctx.files.internal_descriptors,
        ctx.attr.no_closure_library,
        ctx.attr.internal_expect_failure,

        # Deprecated output files.
        ctx.outputs.info,
        ctx.outputs.stderr,
        ctx.outputs.ijs,
        ctx.outputs.typecheck,
    )

    return struct(
        files = depset(),
        exports = library.exports,
        closure_js_library = library.closure_js_library,
        # The usual suspects are exported as runfiles, in addition to raw source.
        runfiles = ctx.runfiles(
            files = srcs + ctx.files.data,
            transitive_files = depset(
                [] if ctx.attr.no_closure_library else ctx.files._closure_library_base,
                transitive = [
                    collect_runfiles(unfurl(ctx.attr.deps, provider = "closure_js_library")),
                    collect_runfiles(ctx.attr.data),
                ],
            ),
        ),
    )

closure_js_library = rule(
    implementation = _closure_js_library,
    attrs = dict({
        "convention": attr.string(
            default = "CLOSURE",
            # TODO(yannic): Define valid values.
            # values=["CLOSURE"],
        ),
        "data": attr.label_list(allow_files = True),
        "deps": attr.label_list(
            aspects = [closure_js_aspect],
            providers = ["closure_js_library"],
        ),
        "exports": attr.label_list(
            aspects = [closure_js_aspect],
            providers = ["closure_js_library"],
        ),
        "includes": attr.string_list(),
        "no_closure_library": attr.bool(),
        "srcs": attr.label_list(allow_files = JS_FILE_TYPE),
        "suppress": attr.string_list(),
        "lenient": attr.bool(),

        # deprecated
        "externs": attr.label_list(allow_files = JS_FILE_TYPE),
        "language": attr.string(),

        # internal only
        "internal_descriptors": attr.label_list(allow_files = True),
        "internal_expect_failure": attr.bool(default = False),
    }, **CLOSURE_JS_TOOLCHAIN_ATTRS),
    # TODO(yannic): Deprecate.
    #     https://docs.bazel.build/versions/master/skylark/lib/globals.html#rule.outputs
    outputs = {
        "info": "%{name}.pbtxt",
        "stderr": "%{name}-stderr.txt",
        "ijs": "%{name}.i.js",
        "typecheck": "%{name}_typecheck",  # dummy output file
    },
)
