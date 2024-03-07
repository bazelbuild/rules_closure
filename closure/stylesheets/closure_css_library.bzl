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

"""Build definitions for Closure Stylesheet libraries."""

load(
    "//closure/private:defs.bzl",
    "CSS_FILE_TYPE",
    "ClosureCssLibraryInfo",
    "ClosureJsLibraryInfo",
    "collect_css",
    "collect_runfiles",
    "unfurl",
)

def _closure_css_library(ctx):
    deps = unfurl(ctx.attr.deps, provider = ClosureCssLibraryInfo)
    css = collect_css(deps, ctx.attr.orientation)
    return [
        ClosureCssLibraryInfo(
            srcs = depset(ctx.files.srcs, transitive = [css.srcs]),
            labels = depset([ctx.label], transitive = [css.labels]),
            orientation = ctx.attr.orientation,
            exports = unfurl(ctx.attr.exports),
        ),
        ClosureJsLibraryInfo(),
        DefaultInfo(
            files = depset(),
            runfiles = collect_runfiles(ctx, ctx.files.srcs),
        ),
    ]

closure_css_library = rule(
    implementation = _closure_css_library,
    attrs = {
        "srcs": attr.label_list(allow_files = CSS_FILE_TYPE),
        "data": attr.label_list(allow_files = True),
        "deps": attr.label_list(providers = [ClosureCssLibraryInfo]),
        "exports": attr.label_list(),
        "orientation": attr.string(default = "LTR"),
    },
)
