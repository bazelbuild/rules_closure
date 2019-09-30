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

"""Common build definitions for Closure Compiler build definitions.
"""

CSS_FILE_TYPE = [".css", ".gss"]
HTML_FILE_TYPE = [".html"]
JS_FILE_TYPE = [".js"]
JS_LANGUAGE_DEFAULT = "ECMASCRIPT5_STRICT"
JS_TEST_FILE_TYPE = ["_test.js"]
SOY_FILE_TYPE = [".soy"]

JS_LANGUAGE_IN = "ECMASCRIPT_2017"
JS_LANGUAGE_OUT_DEFAULT = "ECMASCRIPT5"
JS_LANGUAGES = depset([
    "ECMASCRIPT3",
    "ECMASCRIPT5",
    "ECMASCRIPT5_STRICT",
    "ECMASCRIPT6",
    "ECMASCRIPT6_STRICT",
    "ECMASCRIPT6_TYPED",
    "ECMASCRIPT_2015",
    "ECMASCRIPT_2016",
    "ECMASCRIPT_2017",
    "ECMASCRIPT_2018",
    "ECMASCRIPT_2019",
    "ECMASCRIPT_NEXT",
    "STABLE",
    "NO_TRANSPILE",
])

CLOSURE_LIBRARY_BASE_ATTR = attr.label_list(
    default = [Label("//closure/library:base_lib")],
)

CLOSURE_WORKER_ATTR = attr.label(
    default = Label("//java/io/bazel/rules/closure:ClosureWorker"),
    executable = True,
    cfg = "host",
)

UNUSABLE_TYPE_DEFINITION = attr.label(
    default = Label("//closure/private:unusable_type.js"),
    allow_single_file = True,
)

CLOSURE_JS_TOOLCHAIN_ATTRS = {
    "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
    "_ClosureWorker": CLOSURE_WORKER_ATTR,
}

def get_jsfile_path(f):
    return f.path

def unfurl(deps, provider = ""):
    """Returns deps as well as deps exported by parent rules."""
    res = []
    for dep in deps:
        if not provider or hasattr(dep, provider):
            res.append(dep)
        if hasattr(dep, "exports"):
            for edep in dep.exports:
                if not provider or hasattr(edep, provider):
                    res.append(edep)
    return res

def collect_js(
        deps,
        closure_library_base,
        has_direct_srcs = False,
        no_closure_library = False,
        css = None):
    """Aggregates transitive JavaScript source files from unfurled deps."""
    srcs = []
    direct_srcs = []
    ijs_files = []
    infos = []
    modules = []
    descriptors = []
    stylesheets = []
    js_module_roots = []
    has_closure_library = False
    for dep in deps:
        srcs += [getattr(dep.closure_js_library, "srcs", depset())]
        ijs_files += [getattr(dep.closure_js_library, "ijs_files", depset())]
        infos += [getattr(dep.closure_js_library, "infos", depset())]
        modules += [getattr(dep.closure_js_library, "modules", depset())]
        descriptors += [getattr(dep.closure_js_library, "descriptors", depset())]
        stylesheets += [getattr(dep.closure_js_library, "stylesheets", depset())]
        js_module_roots += [getattr(dep.closure_js_library, "js_module_roots", depset())]
        has_closure_library = (
            has_closure_library or
            getattr(dep.closure_js_library, "has_closure_library", False)
        )
    if no_closure_library:
        if has_closure_library:
            fail("no_closure_library can't be used when Closure Library is " +
                 "already part of the transitive closure")
    elif has_direct_srcs and not has_closure_library:
        has_closure_library = True
        for lib in closure_library_base:
            ijs_files += [getattr(lib.closure_js_library, "ijs_files", depset())]
            lib_srcs = getattr(lib.closure_js_library, "srcs", None)
            if lib_srcs:
                direct_srcs += lib_srcs.to_list()
    if css:
        direct_srcs += [css.closure_css_binary.renaming_map]
        for lib in closure_library_base:
            lib_srcs = getattr(lib.closure_js_library, "srcs", None)
            if lib_srcs:
                direct_srcs += lib_srcs.to_list()

    return struct(
        srcs = depset(direct_srcs, transitive = srcs),
        js_module_roots = depset(transitive = js_module_roots),
        ijs_files = depset(transitive = ijs_files),
        infos = depset(transitive = infos),
        modules = depset(transitive = modules),
        descriptors = depset(transitive = descriptors),
        stylesheets = depset(transitive = stylesheets),
        has_closure_library = has_closure_library,
    )

def collect_css(deps, orientation = None):
    """Aggregates transitive CSS source files from unfurled deps."""
    srcs = []
    labels = []
    for dep in deps:
        if hasattr(dep.closure_css_library, "srcs"):
            srcs.append(getattr(dep.closure_css_library, "srcs"))
        if hasattr(dep.closure_css_library, "labels"):
            labels.append(getattr(dep.closure_css_library, "labels"))
        if orientation:
            if dep.closure_css_library.orientation != orientation:
                fail("%s does not have the same orientation" % dep.label)
        orientation = dep.closure_css_library.orientation
    return struct(
        srcs = depset(transitive = srcs),
        labels = depset(transitive = labels),
        orientation = orientation,
    )

def collect_runfiles(targets):
    """Aggregates data runfiles from targets."""
    data = []
    for target in targets:
        if hasattr(target, "closure_legacy_js_runfiles"):
            data.append(target.closure_legacy_js_runfiles)
            continue
        if hasattr(target, "runfiles"):
            data.append(target.runfiles.files)
            continue
        if hasattr(target, "data_runfiles"):
            data.append(target.data_runfiles.files)
        if hasattr(target, "default_runfiles"):
            data.append(target.default_runfiles.files)
    return depset(transitive = data)

def find_js_module_roots(srcs, workspace_name, label, includes):
    """Finds roots of JavaScript sources.

    This discovers --js_module_root paths for direct srcs that deviate from the
    working directory of ctx.action(). This is basically the cartesian product of
    generated roots, external repository roots, and includes prefixes.

    The includes attribute works the same way as it does in cc_library(). It
    contains a list of directories relative to the package. This feature is
    useful for third party libraries that weren't written with include paths
    relative to the root of a monolithic Bazel repository. Also, unlike the C++
    rules, there is no penalty for using includes in JavaScript compilation.
    """

    # TODO(davido): Find out how to avoid that hack
    srcs_it = srcs
    if type(srcs) == "depset":
        srcs_it = srcs.to_list()
    roots = [f.root.path for f in srcs_it if f.root.path]

    # Bazel started prefixing external repo paths with ../
    new_bazel_version = Label("@foo//bar").workspace_root.startswith("../")
    if workspace_name != "__main__":
        if new_bazel_version:
            roots += ["%s" % root for root in roots.to_list()]
            roots += ["../%s" % workspace_name]
        else:
            roots += ["%s/external/%s" % (root, workspace_name) for root in roots]
            roots += ["external/%s" % workspace_name]
    if includes:
        for f in srcs:
            if f.owner.package != label.package:
                fail("Can't have srcs from a different package when using includes")
        magic_roots = []
        for include in includes:
            if include == ".":
                prefix = label.package
            else:
                prefix = "%s/%s" % (label.package, include)
                found = False
                for f in srcs:
                    if f.owner.name.startswith(include + "/"):
                        found = True
                        break
                if not found:
                    fail("No srcs found beginning with '%s/'" % include)
            for root in roots.to_list():
                magic_roots.append("%s/%s" % (root, prefix))
        roots += magic_roots
    return depset(roots)

def sort_roots(roots):
    """Sorts roots with the most labels first."""
    return [r for _, r in sorted([(-len(r.split("/")), r) for r in roots.to_list()])]

def convert_path_to_es6_module_name(path, roots):
    """Equivalent to JsCheckerHelper#convertPathToModuleName."""
    if not path.endswith(".js") and not path.endswith(".zip"):
        fail("Path didn't end with .js or .zip: %s" % path)
    module = path[:-3]
    for root in roots:
        if module.startswith(root + "/"):
            return module[len(root) + 1:]
    return module

def make_jschecker_progress_message(srcs, label):
    if srcs:
        # TODO(davido): Find out how to avoid that hack
        srcs_it = srcs
        if type(srcs) == "depset":
            srcs_it = srcs.to_list()
        return "Checking %d JS files in %s" % (len(srcs_it), label)
    else:
        return "Checking %s" % (label)

def difference(a, b):
    return [i for i in a.to_list() if i not in b.to_list()]

def long_path(ctx, file_):
    """Returns short_path relative to parent directory."""
    if file_.short_path.startswith("../"):
        return file_.short_path[3:]
    if file_.owner and file_.owner.workspace_root:
        return file_.owner.workspace_root + "/" + file_.short_path
    return ctx.workspace_name + "/" + file_.short_path

def create_argfile(actions, name, args):
    argfile = actions.declare_file("%s_worker_input" % name)
    actions.write(output = argfile, content = "\n".join(args))
    return argfile

def library_level_checks(
        actions,
        label,
        ijs_deps,
        srcs,
        executable,
        output,
        suppress = [],
        internal_expect_failure = False,
        unusable_type_definition = []):
    args = [
        "JsCompiler",
        "--checks_only",
        "--warning_level",
        "VERBOSE",
        "--jscomp_off",
        "reportUnknownTypes",
        "--language_in",
        "ECMASCRIPT_2017",
        "--language_out",
        "ECMASCRIPT5",
        "--js_output_file",
        output.path,
    ]
    inputs = []
    for f in ijs_deps.to_list() + unusable_type_definition:
        args.append("--externs=%s" % f.path)
        inputs.append(f)

    # TODO(davido): Find out how to avoid that hack
    srcs_it = srcs
    if type(srcs) == "depset":
        srcs_it = srcs.to_list()
    for f in srcs_it:
        args.append("--js=%s" % f.path)
        inputs.append(f)
    for s in suppress:
        args.append("--suppress")
        args.append(s)
    if internal_expect_failure:
        args.append("--expect_failure")

    actions.run(
        inputs = inputs,
        outputs = [output],
        executable = executable,
        arguments = args,
        mnemonic = "LibraryLevelChecks",
        progress_message = "Doing library-level typechecking of " + str(label),
    )
