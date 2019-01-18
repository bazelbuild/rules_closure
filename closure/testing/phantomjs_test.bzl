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
    "HTML_FILE_TYPE",
    "collect_runfiles",
    "long_path",
    "unfurl",
)

def _impl(ctx):
    if not ctx.attr.deps:
        fail("phantomjs_rule needs at least one dep")
    files = [ctx.outputs.executable]
    srcs = depset()
    deps = unfurl(ctx.attr.deps, provider = "closure_js_library")
    deps.append(ctx.attr.runner)
    for dep in deps:
        if hasattr(dep, "closure_js_binary"):
            srcs += [dep.closure_js_binary.bin]
        else:
            srcs += dep.closure_js_library.srcs
    args = [
        "#!/bin/sh\nexec " + ctx.executable._phantomjs.short_path,
        ctx.attr.harness.closure_js_binary.bin.short_path,
        ctx.file.html.short_path,
    ]
    args += [long_path(ctx, src) for src in srcs.to_list()]
    ctx.actions.write(
        is_executable = True,
        output = ctx.outputs.executable,
        content = " \\\n  ".join(args),
    )
    return struct(
        files = depset(files),
        runfiles = ctx.runfiles(
            files = files + ctx.attr.data + [ctx.file.html],
            transitive_files = (collect_runfiles(deps) |
                                collect_runfiles(ctx.attr.data) |
                                collect_runfiles([
                                    ctx.attr._phantomjs,
                                    ctx.attr.runner,
                                    ctx.attr.harness,
                                ])),
        ),
    )

_phantomjs_test = rule(
    test = True,
    implementation = _impl,
    attrs = {
        "deps": attr.label_list(providers = ["closure_js_library"]),
        "runner": attr.label(providers = ["closure_js_library"]),
        "harness": attr.label(
            providers = ["closure_js_binary"],
            default = Label("//closure/testing:phantomjs_harness_bin"),
        ),
        "html": attr.label(
            allow_single_file = HTML_FILE_TYPE,
            default = Label("//closure/testing:empty.html"),
        ),
        "data": attr.label_list(allow_files = True),
        "_phantomjs": attr.label(
            default = Label("//third_party/phantomjs"),
            executable = True,
            cfg = "host",
        ),
    },
)

# Workaround https://github.com/ariya/phantomjs/issues/13876 by setting
# phantomjs_test to local.
# TODO(user): Remove when https://github.com/ariya/phantomjs/issues/13876
# is fixed.
def phantomjs_test(**kwargs):
    tags = kwargs.pop("tags", [])
    tags = ["local"] + tags
    _phantomjs_test(tags = tags, **kwargs)
