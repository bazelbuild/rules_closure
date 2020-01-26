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

def _fake_ts_library(ctx):
    return struct(typescript=struct(
        es6_sources=depset(ctx.files.srcs),
        transitive_es6_sources=depset(
            ctx.files.srcs,
            transitive=[d.typescript.transitive_es6_sources for d in ctx.attr.deps]),
        declarations=depset(),
        runtime_deps=depset(
            ctx.attr.runtime_deps,
            transitive=[d.typescript.runtime_deps for d in ctx.attr.deps]),
    ),
    internal_expect_failure=ctx.attr.internal_expect_failure)

fake_ts_library = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "deps": attr.label_list(providers = ["typescript"]),
        "data": attr.label_list(
            default = [],
            allow_files = True,
            cfg = "data",
        ),
        "runtime_deps": attr.label_list(
            default = [],
        ),
        "internal_expect_failure": attr.bool(default = False),
    },
    implementation = _fake_ts_library,
)
