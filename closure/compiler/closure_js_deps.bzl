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

"""Build definitions for JavaScript dependency files."""

load("//closure/private:defs.bzl",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "collect_js",
     "collect_runfiles",
     "long_path",
     "unfurl")

def _impl(ctx):
  deps = unfurl(ctx.attr.deps, provider="closure_js_library")
  js = collect_js(deps)
  closure_root = _dirname(long_path(ctx, ctx.files._closure_library_base[0]))
  closure_rel = '/'.join(['..' for _ in range(len(closure_root.split('/')))])
  outputs = [ctx.outputs.out]
  # XXX: Other files in same directory will get schlepped in w/o sandboxing.
  ctx.action(
      inputs=list(js.srcs),
      outputs=outputs,
      arguments=(["--output_file=%s" % ctx.outputs.out.path] +
                 ["--root_with_prefix=%s %s" % (
                     r, _make_prefix(p, closure_root, closure_rel))
                  for r, p in _find_roots(
                      [(src.dirname, long_path(ctx, src))
                       for src in js.srcs])]),
      executable=ctx.executable._depswriter,
      progress_message="Calculating %d JavaScript deps to %s" % (
          len(js.srcs), ctx.outputs.out.short_path))
  return struct(
      files=depset(outputs),
      runfiles=ctx.runfiles(
          files=outputs + ctx.files.data,
          transitive_files=(depset(ctx.files._closure_library_base) |
                            collect_runfiles(deps) |
                            collect_runfiles(ctx.attr.data))))

def _dirname(path):
  return path[:path.rindex('/')]

def _find_roots(dirs):
  roots = {}
  for _, d, p in sorted([(len(d.split("/")), d, p) for d, p in dirs]):
    parts = d.split("/")
    want = True
    for i in range(len(parts)):
      if "/".join(parts[:i + 1]) in roots:
        want = False
        break
    if want:
      roots[d] = p
  return roots.items()

def _make_prefix(prefix, closure_root, closure_rel):
  prefix = "/".join(prefix.split("/")[:-1])
  if not prefix:
    return closure_rel
  elif prefix == closure_root:
    return "."
  elif prefix.startswith(closure_root + "/"):
    return prefix[len(closure_root) + 1:]
  else:
    return closure_rel + "/" + prefix

closure_js_deps = rule(
    implementation=_impl,
    attrs={
        "deps": attr.label_list(),
        "data": attr.label_list(cfg="data", allow_files=True),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_depswriter": attr.label(
            default=Label("@com_google_javascript_closure_library//:depswriter"),
            executable=True,
            cfg="host"),
    },
    outputs={"out": "%{name}.js"})
