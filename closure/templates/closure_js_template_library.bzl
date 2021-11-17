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

load("//closure/compiler:closure_js_aspect.bzl", "closure_js_aspect")
load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/private:defs.bzl", "SOY_FILE_TYPE", "unfurl")
load("//closure/templates:closure_templates_plugin.bzl", "SoyPluginInfo")

_SOYTOJSSRCCOMPILER = "@com_google_template_soy//:SoyToJsSrcCompiler"

def _impl(ctx):
    args = ["--outputPathFormat=%s/{INPUT_DIRECTORY}/{INPUT_FILE_NAME}.js" %
            ctx.configuration.genfiles_dir.path]
    if ctx.attr.soy_msgs_are_external:
        args += ["--googMsgsAreExternal"]
    if ctx.attr.should_generate_soy_msg_defs:
        args += ["--shouldGenerateGoogMsgDefs"]
    if ctx.attr.bidi_global_dir:
        args += ["--bidiGlobalDir=%s" % ctx.attr.bidi_global_dir]
    if ctx.attr.plugins:
        args += ["--pluginModules=%s" % ",".join([
            m[SoyPluginInfo].generator.module
            for m in ctx.attr.plugins
        ])]
    for arg in ctx.attr.defs:
        if not arg.startswith("--") or (" " in arg and "=" not in arg):
            fail("Please use --flag=value syntax for defs")
        args += [arg]
    inputs = []
    for f in ctx.files.srcs:
        args.append("--srcs=" + f.path)
        inputs.append(f)
    if ctx.file.globals:
        args += ["--compileTimeGlobalsFile", ctx.file.globals.path]
        inputs.append(ctx.file.globals)
    for dep in unfurl(ctx.attr.deps, provider = "closure_js_library"):
        for f in dep.closure_js_library.descriptors.to_list():
            args += ["--protoFileDescriptors=%s" % f.path]
            inputs.append(f)

    plugin_transitive_deps = depset(
        transitive = [m[SoyPluginInfo].generator.runtime.transitive_runtime_deps for m in ctx.attr.plugins],
    ).to_list()
    inputs.extend(plugin_transitive_deps)
    plugin_classpath = [dep.path for dep in plugin_transitive_deps]
    if len(plugin_classpath) > 0:
        args.insert(0, "--main_advice_classpath=" +
                       ctx.configuration.host_path_separator.join(plugin_classpath))

    ctx.actions.run(
        inputs = inputs,
        outputs = ctx.outputs.outputs,
        executable = ctx.executable.compiler,
        arguments = args,
        mnemonic = "SoyCompiler",
        progress_message = "Generating %d SOY v2 JS file(s)" % len(
            ctx.attr.outputs,
        ),
    )

_closure_js_template_library = rule(
    implementation = _impl,
    output_to_genfiles = True,
    attrs = {
        "srcs": attr.label_list(allow_files = SOY_FILE_TYPE),
        "deps": attr.label_list(
            aspects = [closure_js_aspect],
            providers = ["closure_js_library"],
        ),
        "outputs": attr.output_list(),
        "globals": attr.label(allow_single_file = True),
        "plugins": attr.label_list(
            providers = [SoyPluginInfo],
        ),
        "should_generate_soy_msg_defs": attr.bool(),
        "bidi_global_dir": attr.int(default = 1, values = [1, -1]),
        "soy_msgs_are_external": attr.bool(),
        "compiler": attr.label(cfg = "host", executable = True, mandatory = True),
        "defs": attr.string_list(),
    },
)

def closure_js_template_library(
        name,
        srcs,
        deps = [],
        suppress = [],
        testonly = None,
        globals = None,
        plugins = None,
        should_generate_soy_msg_defs = None,
        bidi_global_dir = None,
        soy_msgs_are_external = None,
        defs = [],
        **kwargs):
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
        plugins = plugins,
        should_generate_soy_msg_defs = should_generate_soy_msg_defs,
        bidi_global_dir = bidi_global_dir,
        soy_msgs_are_external = soy_msgs_are_external,
        compiler = compiler,
        defs = defs,
    )

    deps = deps + [
        "@com_google_javascript_closure_library//closure/goog/array",
        "@com_google_javascript_closure_library//closure/goog/asserts",
        "@com_google_javascript_closure_library//closure/goog/debug",
        "@com_google_javascript_closure_library//closure/goog/format",
        "@com_google_javascript_closure_library//closure/goog/html:safehtml",
        "@com_google_javascript_closure_library//closure/goog/html:safescript",
        "@com_google_javascript_closure_library//closure/goog/html:safestyle",
        "@com_google_javascript_closure_library//closure/goog/html:safestylesheet",
        "@com_google_javascript_closure_library//closure/goog/html:safeurl",
        "@com_google_javascript_closure_library//closure/goog/html:trustedresourceurl",
        "@com_google_javascript_closure_library//closure/goog/html:uncheckedconversions",
        "@com_google_javascript_closure_library//closure/goog/i18n:bidi",
        "@com_google_javascript_closure_library//closure/goog/i18n:bidiformatter",
        "@com_google_javascript_closure_library//closure/goog/i18n:numberformat",
        "@com_google_javascript_closure_library//closure/goog/object",
        "@com_google_javascript_closure_library//closure/goog/soy",
        "@com_google_javascript_closure_library//closure/goog/soy:data",
        "@com_google_javascript_closure_library//closure/goog/soy:renderer",
        "@com_google_javascript_closure_library//closure/goog/string",
        "@com_google_javascript_closure_library//closure/goog/string:const",
        "@com_google_javascript_closure_library//closure/goog/uri",
        str(Label("//closure/templates:soy_jssrc")),
    ]

    closure_js_library(
        name = name,
        srcs = js_srcs,
        deps = deps,
        testonly = testonly,
        suppress = suppress + [
            "analyzerChecks",
            "deprecated",
            "reportUnknownTypes",
            "strictCheckTypes",
            "unusedLocalVariables",
        ],
        **kwargs
    )
