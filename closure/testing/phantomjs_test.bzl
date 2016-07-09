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

"""Build rule for running a PhantomJS test."""

# XXX: Loading a nontrivial number of external resources into PhantomJS will
#      cause it to freeze: https://github.com/ariya/phantomjs/issues/14028

load("//closure/private:defs.bzl",
     "HTML_FILE_TYPE",
     "JS_DEPS_ATTR",
     "JS_DEPS_PROVIDERS")

_INCOMPATIBLE_LANGUAGES = set([
    "ECMASCRIPT6",
    "ECMASCRIPT6_STRICT",
    "ECMASCRIPT6_TYPED",
])

def _impl(ctx):
  _check_language(ctx.attr.harness)
  if not ctx.attr.deps:
    fail("phantomjs_rule needs at least one dep")
  if len(ctx.attr.harness.transitive_js_srcs) != 1:
    fail("PhantomJS harness must specify exactly ONE .js file")
  srcs = set(order="compile")
  for dep in ctx.attr.deps:
    _check_language(dep)
    srcs += dep.transitive_js_srcs
  if ctx.attr.runner:
    _check_language(ctx.attr.runner)
    srcs += ctx.attr.runner.transitive_js_srcs
  runfiles = set([ctx.file.html], order="compile")
  runfiles += ctx.attr._phantomjs.data_runfiles.files
  runfiles += ctx.attr.harness.transitive_js_srcs
  runfiles += srcs
  args = ["#!/bin/sh\npwd\nexec " + _runpath(ctx.files._phantomjs[0]),
          _runpath(_first(ctx.attr.harness.transitive_js_srcs)),
          _runpath(ctx.file.html)]
  args += [_runpath(src) for src in srcs]
  ctx.file_action(
      executable=True,
      output=ctx.outputs.executable,
      content=" \\\n  ".join(args))
  return struct(
      files=set([ctx.outputs.executable]),
      runfiles=ctx.runfiles(transitive_files=runfiles,
                            collect_data=True,
                            collect_default=True))

def _runpath(f):
  if f.path.startswith('bazel-out/'):
    return f.short_path
  else:
    return f.path

def _check_language(dep):
  if dep.js_language in _INCOMPATIBLE_LANGUAGES:
    fail("%s is an %s library which is incompatible with PhantomJS" % (
        dep.label, dep.js_language))

def _first(iterable):
  for item in iterable:
    return item
  fail("iterable was empty")

phantomjs_test = rule(
    test=True,
    implementation=_impl,
    attrs={
        "deps": JS_DEPS_ATTR,
        "html": attr.label(
            single_file=True,
            allow_files=HTML_FILE_TYPE,
            default=Label("//closure/testing:empty.html")),
        "harness": attr.label(
            allow_files=False,
            providers=JS_DEPS_PROVIDERS,
            default=Label("//closure/testing:phantomjs_harness")),
        "runner": attr.label(
            allow_files=False,
            providers=JS_DEPS_PROVIDERS,
            default=Label("//closure/testing:phantomjs_jsunit_runner")),
        "data": attr.label_list(cfg=DATA_CFG, allow_files=True),
        "_phantomjs": attr.label(
            default=Label("//third_party/phantomjs"),
            allow_files=True),
    })
