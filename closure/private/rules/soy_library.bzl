# Copyright 2019 The Closure Rules Authors. All rights reserved.
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

load("//closure/private:closure_common.bzl", "closure_common")
load("//closure/private:providers.bzl", "SoyInfo")

def _soy_library_impl(ctx):
    soyh = ctx.actions.declare_file("{}.soyh.bin".format(ctx.label.name))
    return [
        DefaultInfo(
            files = depset([soyh]),
        ),
        closure_common.soy.compile(
            actions = ctx.actions,
            closure_toolchain = struct(
                soy = struct(
                    header_compiler = ctx.attr._compiler.files_to_run,
                ),
            ),
            srcs = ctx.files.srcs,
            output = soyh,
            deps = [dep[SoyInfo] for dep in ctx.attr.deps],
            proto_descriptor_sets = depset(
                direct = [],
                transitive = [dep[ProtoInfo].transitive_descriptor_sets for dep in ctx.attr.proto_deps],
            ),
        ),
    ]

soy_library = rule(
    implementation = _soy_library_impl,
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = [".soy"],
        ),
        "deps": attr.label_list(
            mandatory = False,
            providers = [SoyInfo],
        ),
        "proto_deps": attr.label_list(
            mandatory = False,
            providers = [ProtoInfo],
        ),
        # TODO(yannic): Add this to closure_toolchain.
        "_compiler": attr.label(
            default = "@com_google_template_soy//:SoyHeaderCompiler",
            executable = True,
            cfg = "host",
        ),
    },
    provides = [
        SoyInfo,
    ],
)
