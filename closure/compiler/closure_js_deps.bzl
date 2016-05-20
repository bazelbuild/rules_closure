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

"""Build definitions for JavaScript dependency files."""

load("//closure/private:defs.bzl",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR")

def _impl(ctx):
  # XXX: Other files in same directory will get schlepped in w/o sandboxing.
  if not ctx.attr.deps:
    fail("closure_js_deps rules can not have an empty 'deps' list")
  basejs = ctx.file._closure_library_base
  closure_root = _dirname(basejs.short_path)
  closure_rel = '/'.join(['..' for _ in range(len(closure_root.split('/')))])
  srcs = set(order="compile")
  for src in ctx.attr.deps:
    srcs += src.transitive_js_srcs
  ctx.action(
      inputs=list(srcs),
      outputs=[ctx.outputs.out],
      arguments=(["--output_file=%s" % ctx.outputs.out.path] +
                 ["--root_with_prefix=%s %s" % (
                     r, _make_prefix(p, closure_root, closure_rel))
                  for r, p in _find_roots(
                      [(src.dirname, src.short_path) for src in srcs])]),
      executable=ctx.executable._depswriter,
      progress_message="Calculating %d JavaScript deps to %s" % (
          len(srcs), ctx.outputs.out.short_path))
  return struct(files=set([ctx.outputs.out]))

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
        "deps": attr.label_list(
            allow_files=False,
            providers=["transitive_js_srcs"]),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
        "_depswriter": attr.label(
            default=Label("@closure_library//:depswriter"),
            executable=True),
    },
    outputs={"out": "%{name}.js"})
