# -*- mode: python; -*-
#
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

load("//closure/private:defs.bzl",
     "CSS_DEPS_ATTR",
     "CSS_FILE_TYPE",
     "collect_transitive_css_labels")

def _impl(ctx):
  tsrcs = set()
  tdata = set()
  for dep in ctx.attr.deps:
    tsrcs += dep.transitive_css_srcs
    tdata += dep.transitive_data
    if dep.css_orientation != ctx.attr.orientation:
      fail("%s does not have the same orientation" % dep.label)
  # TODO: Write thing that extracts css:class-name provides.
  ctx.file_action(output=ctx.outputs.provided, content="")
  return struct(files=set(),
                js_language="ANY",
                js_exports=[],
                js_provided=ctx.outputs.provided,
                transitive_js_srcs=set(),
                transitive_js_externs=set(),
                css_orientation=ctx.attr.orientation,
                required_css_labels=set(),
                transitive_css_labels=collect_transitive_css_labels(ctx),
                transitive_css_srcs=tsrcs + ctx.files.srcs,
                transitive_data=tdata + ctx.files.data,
                runfiles=ctx.runfiles(files=ctx.files.srcs + ctx.files.data,
                                      transitive_files=tsrcs + tdata))

closure_css_library = rule(
    implementation=_impl,
    attrs={
        "srcs": attr.label_list(allow_files=CSS_FILE_TYPE),
        "deps": CSS_DEPS_ATTR,
        "orientation": attr.string(default="LTR"),
        "data": attr.label_list(cfg=DATA_CFG, allow_files=True),
    },
    outputs={
        "provided": "%{name}-provided.txt",
    })
