# Copyright 2026 The Closure Rules Authors. All rights reserved.
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

"""Build rule for running a Closure JS test under Node.js."""

load("@bazel_skylib//lib:shell.bzl", "shell")
load(
    "//closure/private:defs.bzl",
    "ClosureJsBinaryInfo",
    "ClosureJsLibraryInfo",
    "collect_runfiles",
)

def _nodejs_test_impl(ctx):
    if not ctx.attr.deps:
        fail("nodejs_test needs at least one dep")
    srcs = []
    direct_srcs = []
    for dep in ctx.attr.deps:
        if ClosureJsBinaryInfo in dep:
            direct_srcs.append(dep[ClosureJsBinaryInfo].bin)
        else:
            srcs.append(dep[ClosureJsLibraryInfo].srcs)
    srcs = depset(direct_srcs, transitive = srcs).to_list()

    node_bin = ctx.toolchains["@rules_nodejs//nodejs:toolchain_type"].nodeinfo.node
    harness = ctx.file._harness
    happy_dom_entry = [
        f
        for f in ctx.files._happy_dom
        if f.short_path.endswith("/lib/index.js")
    ][0]

    cmd_args = [
        shell.quote(node_bin.short_path),
        shell.quote(harness.short_path),
        shell.quote(happy_dom_entry.short_path),
    ] + [shell.quote(src.short_path) for src in srcs]

    ctx.actions.write(
        output = ctx.outputs.executable,
        is_executable = True,
        content = "#!/bin/sh\nexec %s \"$@\"\n" % " ".join(cmd_args),
    )

    runfiles = collect_runfiles(
        ctx,
        files = [ctx.outputs.executable, node_bin, harness] + srcs,
        extra_runfiles_attrs = ["deps", "data", "_happy_dom"],
    )
    return [DefaultInfo(
        executable = ctx.outputs.executable,
        files = depset([ctx.outputs.executable]),
        runfiles = runfiles,
    )]

nodejs_test = rule(
    implementation = _nodejs_test_impl,
    test = True,
    attrs = {
        "deps": attr.label_list(providers = [ClosureJsLibraryInfo]),
        "data": attr.label_list(allow_files = True),
        "_harness": attr.label(
            default = Label("//closure/testing:nodejs_harness"),
            allow_single_file = True,
        ),
        "_happy_dom": attr.label(
            default = Label("@happy_dom//:happy_dom"),
        ),
    },
    toolchains = ["@rules_nodejs//nodejs:toolchain_type"],
)
