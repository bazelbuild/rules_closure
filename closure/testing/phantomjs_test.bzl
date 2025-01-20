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

"""Build rule for running a PhantomJS test."""

# XXX: Loading a nontrivial number of external resources into PhantomJS will
#      cause it to freeze: https://github.com/ariya/phantomjs/issues/14028

load(
    "//closure/private:defs.bzl",
    "ClosureJsBinaryInfo",
    "ClosureJsLibraryInfo",
    "HTML_FILE_TYPE",
    "collect_runfiles",
    "long_path",
)

def _impl(ctx):
    if not ctx.attr.deps:
        fail("phantomjs_rule needs at least one dep")
    files = [ctx.outputs.executable]
    srcs = []
    direct_srcs = []
    deps = list(ctx.attr.deps)
    for dep in deps:
        if ClosureJsBinaryInfo in dep:
            direct_srcs.append(dep[ClosureJsBinaryInfo].bin)
        else:
            srcs.append(dep[ClosureJsLibraryInfo].srcs)
    srcs = depset(direct_srcs, transitive = srcs)
    deps.append(ctx.attr.runner)

    args = [
        "#!/bin/sh\nexec " + ctx.executable._phantomjs.short_path,
    ]
    if ctx.attr.debug:
        args.append("--debug=true")
    args.append(ctx.attr.harness[ClosureJsBinaryInfo].bin.short_path)
    args.append(ctx.file.html.short_path)
    args += [long_path(ctx, src) for src in srcs.to_list()]
    args += [long_path(ctx, src) for src in ctx.attr.runner[ClosureJsLibraryInfo].srcs.to_list()]
    ctx.actions.write(
        is_executable = True,
        output = ctx.outputs.executable,
        content = " \\\n  ".join(args),
    )
    return DefaultInfo(
        files = depset(files),
        runfiles = collect_runfiles(
            ctx,
            files = files + [ctx.file.html],
            extra_runfiles_attrs = ["_phantomjs", "runner", "harness"],
        ),
    )

phantomjs_test = rule(
    test = True,
    implementation = _impl,
    attrs = {
        "deps": attr.label_list(providers = [ClosureJsLibraryInfo]),
        "runner": attr.label(providers = [ClosureJsLibraryInfo]),
        "harness": attr.label(
            providers = [ClosureJsBinaryInfo],
            default = Label("//closure/testing:phantomjs_harness_bin"),
        ),
        "html": attr.label(
            allow_single_file = HTML_FILE_TYPE,
            default = Label("//closure/testing:empty.html"),
        ),
        "data": attr.label_list(allow_files = True),
        "debug": attr.bool(
            doc = "Activate phantomjs debug logging",
            default = False,
        ),
        "_phantomjs": attr.label(
            default = Label("//third_party/phantomjs"),
            executable = True,
            cfg = "exec",
        ),
    },
)
