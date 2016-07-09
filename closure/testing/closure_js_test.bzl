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

"""Build macro for running JavaScript unit tests in PhantomJS."""

load("//closure/compiler:closure_js_binary.bzl", "closure_js_binary")
load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/private:defs.bzl", "JS_LANGUAGE_DEFAULT")
load("//closure/testing:phantomjs_test.bzl", "phantomjs_test")

def closure_js_test(name,
                    srcs,
                    data=None,
                    deps=None,
                    compilation_level=None,
                    css=None,
                    defs=None,
                    entry_points=None,
                    html=None,
                    language=None,
                    pedantic=None,
                    suppress=None,
                    visibility=None,
                    **kwargs):
  if not srcs:
    fail("closure_js_test rules can not have an empty 'srcs' list")
  for src in srcs:
    if not src.endswith('_test.js'):
      fail("closure_js_test srcs must be files ending with _test.js")
  if len(srcs) == 1:
    work = [(name, srcs)]
  else:
    work = [(name + _make_suffix(src), [src]) for src in srcs]
  for shard, sauce in work:

    closure_js_library(
        name = "%s_lib" % shard,
        srcs = sauce,
        data = data,
        deps = deps,
        language = language,
        suppress = suppress,
        visibility = visibility,
        testonly = True,
    )

    closure_js_binary(
        name = "%s_bin" % shard,
        deps = [":%s_lib" % shard],
        compilation_level = compilation_level,
        css = css,
        debug = True,
        defs = defs,
        entry_points = entry_points,
        formatting = "PRETTY_PRINT",
        pedantic = pedantic,
        visibility = visibility,
        testonly = True,
    )

    phantomjs_test(
        name = shard,
        deps = [":%s_bin" % shard],
        html = html,
        visibility = visibility,
        **kwargs
    )

  if len(srcs) > 1:
    native.test_suite(
        name = name,
        tests = [":" + shard for shard, _ in work],
    )


def _make_suffix(path):
  return '_' + path.replace('_test.js', '').replace('-', '_').replace('/', '_')
