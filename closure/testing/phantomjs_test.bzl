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
     "JS_FILE_TYPE",
     "long_path",
     "unfurl")

_INCOMPATIBLE_LANGUAGES = set([
    "ECMASCRIPT6",
    "ECMASCRIPT6_STRICT",
    "ECMASCRIPT6_TYPED",
])

def _impl(ctx):
  _check_language(ctx.attr.harness.label,
                  ctx.attr.harness.closure_js_binary.language)
  if not ctx.attr.deps:
    fail("phantomjs_rule needs at least one dep")
  runfiles = set([ctx.file.html])
  runfiles += ctx.attr._phantomjs.data_runfiles.files
  runfiles += [ctx.attr.harness.closure_js_binary.bin]
  runfiles += getattr(ctx.attr.harness, 'closure_data', [])
  srcs = set()
  deps = unfurl(ctx.attr.deps)
  deps.append(ctx.attr.runner)
  for dep in deps:
    if hasattr(dep, 'closure_data'):
      runfiles += dep.closure_data
    if hasattr(dep, 'closure_js_binary'):
      _check_language(dep.label, dep.closure_js_binary.language)
      srcs += [dep.closure_js_binary.bin]
    else:
      _check_language(dep.label, dep.closure_js_library.language)
      srcs += dep.closure_js_library.srcs
  runfiles += srcs
  args = ["#!/bin/sh\nexec " + ctx.executable._phantomjs.short_path,
          ctx.attr.harness.closure_js_binary.bin.short_path,
          ctx.file.html.short_path]
  args += [long_path(ctx, src) for src in srcs]
  ctx.file_action(
      executable=True,
      output=ctx.outputs.executable,
      content=" \\\n  ".join(args))
  return struct(
      files=set([ctx.outputs.executable]),
      runfiles=ctx.runfiles(
          transitive_files=runfiles,
          collect_data=True,
          collect_default=True))

def _check_language(label, language):
  if language in _INCOMPATIBLE_LANGUAGES:
    fail("%s is an %s library which is incompatible with PhantomJS" % (
        label, language))

_phantomjs_test = rule(
    test=True,
    implementation=_impl,
    attrs={
        "deps": attr.label_list(providers=["closure_js_library"]),
        "runner": attr.label(providers=["closure_js_library"]),
        "harness": attr.label(
            providers=["closure_js_binary"],
            default=Label("//closure/testing:phantomjs_harness_bin")),
        "html": attr.label(
            single_file=True,
            allow_files=HTML_FILE_TYPE,
            default=Label("//closure/testing:empty.html")),
        "data": attr.label_list(cfg="data", allow_files=True),
        "_phantomjs": attr.label(
            default=Label("//third_party/phantomjs"),
            executable=True,
            cfg="host"),
    })

# Workaround https://github.com/ariya/phantomjs/issues/13876 by setting
# phantomjs_test to local.
# TODO(user): Remove when https://github.com/ariya/phantomjs/issues/13876
# is fixed.
def phantomjs_test(**kwargs):
  tags = kwargs.pop("tags", [])
  _phantomjs_test(tags = ["local"] + tags, **kwargs)
