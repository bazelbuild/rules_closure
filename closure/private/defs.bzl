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

"""Common build definitions for Closure Compiler build definitions.
"""

CSS_FILE_TYPE = FileType([".css", ".gss"])
HTML_FILE_TYPE = FileType([".html"])
JS_FILE_TYPE = FileType([".js"])
JS_LANGUAGE_DEFAULT = "ECMASCRIPT5_STRICT"
JS_TEST_FILE_TYPE = FileType(["_test.js"])
SOY_FILE_TYPE = FileType([".soy"])

JS_LANGUAGE_IN = "ECMASCRIPT6_STRICT"
JS_LANGUAGE_OUT_DEFAULT = "ECMASCRIPT5"
JS_LANGUAGES = set([
    "ECMASCRIPT3",
    "ECMASCRIPT5",
    "ECMASCRIPT5_STRICT",
    "ECMASCRIPT6",
    "ECMASCRIPT6_STRICT",
])

CLOSURE_LIBRARY_BASE_ATTR = attr.label(
    default=Label("@com_google_javascript_closure_library//:closure/goog/base.js"),
    allow_files=True,
    single_file=True)

CLOSURE_LIBRARY_DEPS_ATTR = attr.label(
    default=Label("@com_google_javascript_closure_library//:closure/goog/deps.js"),
    allow_files=True,
    single_file=True)

def unfurl(deps, provider=""):
  """Returns deps as well as deps exported by parent rules."""
  res = []
  for dep in deps:
    if not provider or hasattr(dep, provider):
      res.append(dep)
    if hasattr(dep, "exports"):
      for edep in dep.exports:
        if not provider or hasattr(edep, provider):
          res.append(edep)
  return res

def collect_js(ctx, deps,
               has_direct_srcs=False,
               no_closure_library=False,
               css=None):
  """Aggregates transitive JavaScript source files from unfurled deps."""
  srcs = set()
  infos = set()
  modules = set()
  descriptors = set()
  stylesheets = set()
  js_module_roots = set()
  has_closure_library = False
  for dep in deps:
    srcs += getattr(dep.closure_js_library, "srcs", [])
    infos += getattr(dep.closure_js_library, "infos", [])
    modules += getattr(dep.closure_js_library, "modules", [])
    descriptors += getattr(dep.closure_js_library, "descriptors", [])
    stylesheets += getattr(dep.closure_js_library, "stylesheets", [])
    js_module_roots += getattr(dep.closure_js_library, "js_module_roots", [])
    has_closure_library = (
        has_closure_library or
        getattr(dep.closure_js_library, "has_closure_library", False))
  if no_closure_library:
    if has_closure_library:
      fail("no_closure_library can't be used when Closure Library is " +
           "already part of the transitive closure")
  elif has_direct_srcs and not has_closure_library:
    tmp = set([ctx.file._closure_library_base,
               ctx.file._closure_library_deps])
    tmp += srcs
    srcs = tmp
    has_closure_library = True
  if css:
    tmp = set([ctx.file._closure_library_base,
               css.closure_css_binary.renaming_map])
    tmp += srcs
    srcs = tmp
  return struct(
      srcs=srcs,
      js_module_roots=js_module_roots,
      infos=infos,
      modules=modules,
      descriptors=descriptors,
      stylesheets=stylesheets,
      has_closure_library=has_closure_library)

def collect_css(deps, orientation=None):
  """Aggregates transitive CSS source files from unfurled deps."""
  srcs = set()
  labels = set()
  for dep in deps:
    srcs += getattr(dep.closure_css_library, "srcs", [])
    labels += getattr(dep.closure_css_library, "labels", [])
    if orientation:
      if dep.closure_css_library.orientation != orientation:
        fail("%s does not have the same orientation" % dep.label)
    orientation = dep.closure_css_library.orientation
  return struct(
      srcs=srcs,
      labels=labels,
      orientation=orientation)

def collect_runfiles(targets):
  """Aggregates data runfiles from targets."""
  data = set()
  for target in targets:
    if hasattr(target, "closure_legacy_js_runfiles"):
      data += target.closure_legacy_js_runfiles
      continue
    if hasattr(target, "runfiles"):
      data += target.runfiles.files
      continue
    if hasattr(target, "data_runfiles"):
      data += target.data_runfiles.files
    if hasattr(target, "default_runfiles"):
      data += target.default_runfiles.files
  return data

def find_js_module_roots(ctx, srcs):
  """Finds roots of JavaScript sources.

  This discovers --js_module_root paths for direct srcs that deviate from the
  working directory of ctx.action(). This is basically the cartesian product of
  generated roots, external repository roots, and includes prefixes.

  The includes attribute works the same way as it does in cc_library(). It
  contains a list of directories relative to the package. This feature is
  useful for third party libraries that weren't written with include paths
  relative to the root of a monolithic Bazel repository. Also, unlike the C++
  rules, there is no penalty for using includes in JavaScript compilation.
  """
  roots = set([f.root.path for f in srcs if f.root.path])
  # Bazel started prefixing external repo paths with ../
  new_bazel_version = Label('@foo//bar').workspace_root.startswith('../')
  if ctx.workspace_name != "__main__":
    if new_bazel_version:
      roots += ["%s" % root for root in roots]
      roots += ["../%s" % ctx.workspace_name]
    else:
      roots += ["%s/external/%s" % (root, ctx.workspace_name) for root in roots]
      roots += ["external/%s" % ctx.workspace_name]
  if getattr(ctx.attr, "includes", []):
    for f in srcs:
      if f.owner.package != ctx.label.package:
        fail("Can't have srcs from a different package when using includes")
    magic_roots = []
    for include in ctx.attr.includes:
      if include == ".":
        prefix = ctx.label.package
      else:
        prefix = "%s/%s" % (ctx.label.package, include)
        found = False
        for f in srcs:
          if f.owner.name.startswith(include + "/"):
            found = True
            break
        if not found:
          fail("No srcs found beginning with '%s/'" % include)
      for root in roots:
        magic_roots.append("%s/%s" % (root, prefix))
    roots += magic_roots
  return roots

def sort_roots(roots):
  """Sorts roots with the most labels first."""
  return [r for _, r in sorted([(-len(r.split("/")), r) for r in roots])]

def convert_path_to_es6_module_name(path, roots):
  """Equivalent to JsCheckerHelper#convertPathToModuleName."""
  if not path.endswith(".js"):
    fail("Path didn't end with .js: %s" % path)
  module = path[:-3]
  for root in roots:
    if module.startswith(root + "/"):
      return module[len(root) + 1:]
  return module

def make_jschecker_progress_message(srcs, label):
  if srcs:
    return "Checking %d JS files in %s" % (len(srcs), label)
  else:
    return "Checking %s" % (label)

def difference(a, b):
  return [i for i in a if i not in b]

def long_path(ctx, file_):
  """Returns short_path relative to parent directory."""
  if file_.short_path.startswith("../"):
    return file_.short_path[3:]
  if file_.owner and file_.owner.workspace_root:
    return file_.owner.workspace_root + "/" + file_.short_path
  return ctx.workspace_name + "/" + file_.short_path

def create_argfile(ctx, args):
  bin_dir = ctx.configuration.bin_dir
  if hasattr(ctx, 'bin_dir'):
    bin_dir = ctx.bin_dir
  argfile = ctx.new_file(bin_dir, "%s_worker_input" % ctx.label.name)
  ctx.file_action(output=argfile, content="\n".join(args))
  return argfile
