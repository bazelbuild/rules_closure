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

load("//closure/compiler:closure_js_library.bzl", "create_closure_js_library")
load("//closure/private:defs.bzl", "CLOSURE_JS_TOOLCHAIN_ATTRS", "unfurl")
load("@build_bazel_rules_proto//proto:proto_common.bzl", "proto_common")

def _closure_proto_output_name(src):
    # src is of format <path/to/file>.proto
    return ["{}.js".format(src[:-6])]

def _closure_proto_options(params):
    options = []

    # The framework in rules_protobuf requires that we generate one output
    # file for every input file.
    options.append("one_output_file_per_input_file")

    # Only `import_style=closure` is supported for now.
    # See https://github.com/grpc/grpc-web/pull/260#issuecomment-415443448
    options.append("import_style=closure")

    # Enums are allways |goog.require()|'d in the generated files to avoid
    # namespace-not-provided if no library |goog.require()|'s them.
    options.append("add_require_for_enums")

    # If the proto_library is marked as testonly, tell protoc to add
    # |goog.setTestOnly()| to the generated code.
    if params.testonly:
        options.append("testonly")

    return ",".join(options)

def _closure_proto_aspect_impl(target, ctx):
    srcs = proto_common.lang_proto_aspect_impl(
        actions = ctx.actions,
        toolchain = ctx.toolchains[proto_common.TOOLCHAIN_TYPE],
        flavor = "Closure",
        get_generator_options = _closure_proto_options,
        get_generator_options_params = struct(
            testonly = getattr(ctx.rule.attr, "testonly", False),
        ),
        get_output_files = _closure_proto_output_name,
        language = "js",
        target = target,
    )

    deps = unfurl(ctx.rule.attr.deps, provider = "closure_js_library")
    deps += [ctx.attr._closure_protobuf_runtime]

    suppress = [
        "missingProperties",
        "unusedLocalVariables",
    ]

    library = create_closure_js_library(ctx, srcs, deps, [], suppress, True)
    return struct(
        exports = library.exports,
        closure_js_library = library.closure_js_library,
    )

closure_proto_aspect = proto_common.lang_proto_aspect(
    attrs = dict({
        # internal only
        "_closure_protobuf_runtime": attr.label(
            default = Label("//closure/protobuf:runtime"),
        ),
    }, **CLOSURE_JS_TOOLCHAIN_ATTRS),
    implementation = _closure_proto_aspect_impl,
    provides = [
        "closure_js_library",
        "exports",
    ],
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
