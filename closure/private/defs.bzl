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

"""Common build definitions for Closure Compiler build definitions.
"""

BASE_JS = Label("@closure_library//:closure/goog/base.js")
DEPS_JS = Label("@closure_library//:closure/goog/deps.js")
JSON_JS = Label("@closure_library//:closure/goog/json/json.js")
SOYUTILS_USEGOOG_JS = Label("@soy_jssrc//:soyutils_usegoog.js")

CSS_FILE_TYPE = FileType([".css", ".gss"])
HTML_FILE_TYPE = FileType([".html"])
JS_FILE_TYPE = FileType([".js"])
JS_LANGUAGE_DEFAULT = "ECMASCRIPT5_STRICT"
JS_TEST_FILE_TYPE = FileType(["_test.js"])
SOY_FILE_TYPE = FileType([".soy"])

JS_LANGUAGES = set([
    "ANY",
    "ECMASCRIPT3",
    "ECMASCRIPT5",
    "ECMASCRIPT5_STRICT",
    "ECMASCRIPT6",
    "ECMASCRIPT6_STRICT",
    "ECMASCRIPT6_TYPED",
])

JS_PEDANTIC_ARGS = [
    "--jscomp_error=*",
    "--jscomp_warning=unnecessaryCasts",
]

JS_HIDE_WARNING_ARGS = [
    "--hide_warnings_for=/incremental_dom/",
]

JS_DEPS_PROVIDERS = [
    "js_language",
    "js_exports",
    "js_provided",
    "required_css_labels",
    "transitive_js_srcs",
]

JS_DEPS_ATTR = attr.label_list(allow_files=False, providers=JS_DEPS_PROVIDERS)

CSS_DEPS_ATTR = attr.label_list(
    allow_files=False,
    providers=["css_orientation",
               "transitive_css_srcs",
               "transitive_css_labels"])

SOY_DEPS_ATTR = attr.label_list(
    allow_files=False, providers=["proto_descriptor_sets"])
CLOSURE_LIBRARY_BASE_ATTR = attr.label(
    default=BASE_JS, allow_files=True, single_file=True)
CLOSURE_LIBRARY_DEPS_ATTR = attr.label(
    default=DEPS_JS, allow_files=True, single_file=True)

def collect_transitive_js_srcs(ctx):
  srcs = set(order="compile")
  data = set(order="compile")
  if hasattr(ctx.attr, 'css'):
    if ctx.attr.css:
      srcs += [ctx.file._closure_library_base,
               ctx.file._closure_library_deps,
               ctx.attr.css.js_css_renaming_map]
  elif (hasattr(ctx.file, '_closure_library_base')
        and (not hasattr(ctx.attr, 'no_closure_library')
             or not ctx.attr.no_closure_library)
        and (not hasattr(ctx.files, 'srcs')
             or ctx.files.srcs)):
    srcs += [ctx.file._closure_library_base,
             ctx.file._closure_library_deps]
  for dep in ctx.attr.deps:
    srcs += dep.transitive_js_srcs
    data += dep.transitive_data
    for edep in dep.js_exports:
      srcs += edep.transitive_js_srcs
      data += edep.transitive_data
  return srcs, data

def collect_transitive_css_labels(ctx):
  result = set(order="compile")
  if not hasattr(ctx.attr, "debug"):
    result += [ctx.label]
  for dep in ctx.attr.deps:
    result += dep.transitive_css_labels
  return result

def collect_required_css_labels(ctx):
  result = set(order="compile")
  for dep in ctx.attr.deps:
    result += dep.required_css_labels
    if hasattr(dep, 'transitive_css_srcs'):
      result += [dep.label]
      if hasattr(dep, 'compilation_level'):
        fail("A closure_js_binary can't depend on a closure_css_library. " +
             "Use the 'css' attribute to depend on the closure_css_binary")
  return result

def difference(a, b):
  return [i for i in a if i not in b]

def determine_js_language(ctx, normalize=False):
  language = "ANY"
  if hasattr(ctx.attr, "language"):
    # Don't do the language mixing check for closure_js_binary()
    if not hasattr(ctx.attr, "entry_points"):
      language = _check_js_language(ctx.attr.language)
  for dep in ctx.attr.deps:
    language = _mix_js_languages(ctx, language, dep.js_language)
  if hasattr(ctx.attr, "exports"):
    for dep in ctx.attr.exports:
      language = _mix_js_languages(ctx, language, dep.js_language)
  if normalize and language == "ANY":
    language = JS_LANGUAGE_DEFAULT
  return language

def long_path(ctx, f):
  """Returns short_path relative to parent directory."""
  short = f.short_path
  if short.startswith("../"):
    return short[3:]
  else:
    return ctx.workspace_name + "/" + short

# Maps (current, dependent) -> (compatible, is_decay)
_JS_LANGUAGE_COMBINATIONS = {
    ("ECMASCRIPT3", "ECMASCRIPT5"): ("ECMASCRIPT5", False),
    ("ECMASCRIPT3", "ECMASCRIPT5_STRICT"): ("ECMASCRIPT5", False),
    ("ECMASCRIPT3", "ECMASCRIPT6_STRICT"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT5", "ECMASCRIPT3"): ("ECMASCRIPT5", False),
    ("ECMASCRIPT5", "ECMASCRIPT5_STRICT"): ("ECMASCRIPT5", False),
    ("ECMASCRIPT5", "ECMASCRIPT6_STRICT"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT6", "ECMASCRIPT3"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT6", "ECMASCRIPT5"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT6", "ECMASCRIPT5_STRICT"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT6", "ECMASCRIPT6_STRICT"): ("ECMASCRIPT6", False),
    ("ECMASCRIPT5_STRICT", "ECMASCRIPT3"): ("ECMASCRIPT5", True),
    ("ECMASCRIPT5_STRICT", "ECMASCRIPT5"): ("ECMASCRIPT5", True),
    ("ECMASCRIPT5_STRICT", "ECMASCRIPT6_STRICT"): ("ECMASCRIPT6_STRICT", False),
    ("ECMASCRIPT5_STRICT", "ECMASCRIPT6_TYPED"): ("ECMASCRIPT6_TYPED", False),
    ("ECMASCRIPT6_STRICT", "ECMASCRIPT3"): ("ECMASCRIPT6", True),
    ("ECMASCRIPT6_STRICT", "ECMASCRIPT5"): ("ECMASCRIPT6", True),
    ("ECMASCRIPT6_STRICT", "ECMASCRIPT6"): ("ECMASCRIPT6", True),
    ("ECMASCRIPT6_STRICT", "ECMASCRIPT5_STRICT"): ("ECMASCRIPT6_STRICT", False),
    ("ECMASCRIPT6_STRICT", "ECMASCRIPT6_TYPED"): ("ECMASCRIPT6_TYPED", False),
    ("ECMASCRIPT6_TYPED", "ECMASCRIPT5_STRICT"): ("ECMASCRIPT6_TYPED", False),
    ("ECMASCRIPT6_TYPED", "ECMASCRIPT6_STRICT"): ("ECMASCRIPT6_TYPED", False),
}

def _check_js_language(language):
  if language not in JS_LANGUAGES:
    fail("Invalid JS language '%s', expected one of %s" % (
        language, ", ".join(list(JS_LANGUAGES))))
  return language

def _mix_js_languages(ctx, current, dependent):
  if current == dependent:
    return current
  if current == "ANY":
    return dependent
  if dependent == "ANY":
    return current
  if (current, dependent) in _JS_LANGUAGE_COMBINATIONS:
    compatible, is_decay = _JS_LANGUAGE_COMBINATIONS[(current, dependent)]
    if is_decay:
      print(("%s dependency on %s library caused JS language strictness to " +
             "decay from %s to %s") % (
                 ctx.label.name, dependent, current, compatible))
    return compatible
  fail("Can not link an %s library against an %s one." % (dependent, current))

def create_argfile(ctx, args):
  argfile = ctx.new_file(ctx.configuration.bin_dir,
                         "%s_worker_input" % ctx.label.name)
  ctx.file_action(output=argfile, content="\n".join(args))
  return argfile
