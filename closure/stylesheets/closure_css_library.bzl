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
     "CSS_FILE_TYPE",
     "collect_css",
     "collect_data",
     "unfurl")

def _impl(ctx):
  deps = unfurl(ctx.attr.deps)
  css = collect_css(deps, ctx.attr.orientation)
  data = collect_data(deps)
  return struct(
      files=set(),
      exports=unfurl(ctx.attr.exports),
      closure_data=data + ctx.files.data,
      closure_js_library=struct(),
      closure_css_library=struct(
          srcs=css.srcs + ctx.files.srcs,
          labels=css.labels + [ctx.label],
          orientation=ctx.attr.orientation),
      runfiles=ctx.runfiles(
          files=ctx.files.srcs + ctx.files.data,
          transitive_files=css.srcs + data))

closure_css_library = rule(
    implementation=_impl,
    attrs={
        "srcs": attr.label_list(allow_files=CSS_FILE_TYPE),
        "data": attr.label_list(cfg="data", allow_files=True),
        "deps": attr.label_list(providers=["closure_css_library"]),
        "exports": attr.label_list(providers=["closure_css_library"]),
        "orientation": attr.string(default="LTR"),
    })
