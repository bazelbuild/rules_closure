# Copyright 2018 The Closure Rules Authors. All rights reserved.
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

"""Utilities for building JavaScript Protocol Buffers.
"""

load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load("//closure/compiler:closure_js_library.bzl", "create_closure_js_library")
load("//closure/private:defs.bzl", "CLOSURE_JS_TOOLCHAIN_ATTRS", "unfurl")

def _generate_closure_js_progress_message(name):
    # TODO(yannic): Add a better message?
    return "Generating JavaScript Protocol Buffer %s" % name

def _generate_closure_js(target, ctx):
    # Support only `import_style=closure`, and always add
    # |goog.require()| for enums.
    js_out_options = [
        "import_style=closure",
        "library=%s" % ctx.label.name,
        "add_require_for_enums",
    ]
    if getattr(ctx.rule.attr, "testonly", False):
        js_out_options.append("testonly")
    js = ctx.actions.declare_file("%s.js" % ctx.label.name)

    # Add include paths for all proto files,
    # to avoid copying/linking the files for every target.
    args = ["-I%s" % p for p in target[ProtoInfo].transitive_proto_path.to_list()]

    out_options = ",".join(js_out_options)
    out_path = "/".join(js.path.split("/")[:-1])
    args += ["--js_out=%s:%s" % (out_options, out_path)]

    # Add paths of protos we generate files for.
    args += [file.path for file in target[ProtoInfo].direct_sources]

    ctx.actions.run(
        inputs = target[ProtoInfo].transitive_imports,
        outputs = [js],
        executable = ctx.executable._protoc,
        arguments = args,
        progress_message =
            _generate_closure_js_progress_message(ctx.rule.attr.name),
    )

    return js

def _closure_proto_aspect_impl(target, ctx):
    js = _generate_closure_js(target, ctx)

    srcs = depset([js])
    deps = unfurl(ctx.rule.attr.deps, provider = "closure_js_library")
    deps += [ctx.attr._closure_library, ctx.attr._closure_protobuf_jspb]

    suppress = [
        "missingProperties",
        "unusedLocalVariables",
    ]

    library = create_closure_js_library(ctx, srcs, deps, [], suppress, True)
    return struct(
        exports = library.exports,
        closure_js_library = library.closure_js_library,
        # The usual suspects are exported as runfiles, in addition to raw source.
        runfiles = ctx.runfiles(files = [js]),
    )

closure_proto_aspect = aspect(
    attr_aspects = ["deps"],
    attrs = dict({
        # internal only
        "_protoc": attr.label(
            default = Label("@com_google_protobuf//:protoc"),
            executable = True,
            cfg = "host",
        ),
        "_closure_library": attr.label(
            default = Label("@com_google_javascript_closure_library//closure/goog/array"),
        ),
        "_closure_protobuf_jspb": attr.label(
            default = Label("//closure/protobuf:jspb"),
        ),
    }, **CLOSURE_JS_TOOLCHAIN_ATTRS),
    implementation = _closure_proto_aspect_impl,
)

_error_multiple_deps = "".join([
    "'deps' attribute must contain exactly one label ",
    "(we didn't name it 'dep' for consistency). ",
    "We may revisit this restriction later.",
])

def _closure_proto_library_impl(ctx):
    if len(ctx.attr.deps) > 1:
        # TODO(yannic): Revisit this restriction.
        fail(_error_multiple_deps, "deps")

    dep = ctx.attr.deps[0]
    return struct(
        files = depset(),
        exports = dep.exports,
        closure_js_library = dep.closure_js_library,
    )

closure_proto_library = rule(
    attrs = {
        "deps": attr.label_list(
            mandatory = True,
            providers = [ProtoInfo],
            aspects = [closure_proto_aspect],
        ),
    },
    implementation = _closure_proto_library_impl,
)
