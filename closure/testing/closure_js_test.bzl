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

"""Build rule for running Closure Library JsUnit tests in PhantomJS.
"""

# XXX: It would be significantly faster and produce better stacktraces if we
#      could avoid compilation by running in raw sources mode. This is not
#      possible due to a resource loading bug in PhantomJS.
#      https://github.com/ariya/phantomjs/issues/14028

load("//closure/private:defs.bzl",
     "CLOSURE_LIBRARY_BASE_ATTR",
     "CLOSURE_LIBRARY_DEPS_ATTR",
     "JS_DEPS_ATTR",
     "JS_HIDE_WARNING_ARGS",
     "JS_LANGUAGE_DEFAULT",
     "JS_PEDANTIC_ARGS",
     "JS_TEST_FILE_TYPE",
     "collect_js_srcs",
     "determine_js_language")

# Maps input language to preferred output language. Since PhantomJS (based on
# QtWebKit) supports ECMASCRIPT5_STRICT, we want to transpile to that language,
# or whatever is nearest: http://kangax.github.io/compat-table/es5/#webkit
_OUTPUT_LANGUAGE = {
    "ECMASCRIPT3": "ECMASCRIPT3",
    "ECMASCRIPT5": "ECMASCRIPT5",
    "ECMASCRIPT6": "ECMASCRIPT5",
    "ECMASCRIPT5_STRICT": "ECMASCRIPT5_STRICT",
    "ECMASCRIPT6_STRICT": "ECMASCRIPT5_STRICT",
    "ECMASCRIPT6_TYPED": "ECMASCRIPT5_STRICT",
}

def _impl(ctx):
  srcs, externs = collect_js_srcs(ctx)
  srcs += ctx.attr._phantomjs_jsunit_runner.transitive_js_srcs
  externs += ctx.attr._phantomjs_jsunit_runner.transitive_js_externs
  language_in = determine_js_language(ctx, normalize=True)
  language_out = _OUTPUT_LANGUAGE[language_in]
  args = [
      "--js_output_file=%s" % ctx.outputs.js.path,
      "--language_in=%s" % language_in,
      "--language_out=%s" % language_out,
      "--compilation_level=WHITESPACE_ONLY",
      "--warning_level=VERBOSE",
      "--formatting=PRETTY_PRINT",
      "--new_type_inf",
      "--debug",
      "--dependency_mode=LOOSE",
  ]
  if ctx.attr.pedantic:
    args += JS_PEDANTIC_ARGS
  args += JS_HIDE_WARNING_ARGS
  args += ctx.attr.defs
  args += ["--externs=%s" % extern.path for extern in externs]
  args += ["--js=%s" % src.path for src in srcs]
  ctx.action(
      inputs=list(srcs) + list(externs),
      outputs=[ctx.outputs.js],
      executable=ctx.executable._compiler,
      arguments=args,
      mnemonic="JSCompile",
      progress_message="Compiling %d JavaScript files to %s" % (
          len(srcs) + len(externs), ctx.outputs.js.short_path))
  ctx.file_action(
      executable=True,
      output=ctx.outputs.executable,
      content="\n".join([
          "#!/bin/sh",
          "exec %s \\" % ctx.files._phantomjs[0].short_path,
          "  %s \\" % ctx.file._phantomjs_runner.short_path,
          "  %s" % ctx.outputs.js.short_path,
          "",
      ]))
  return struct(
      files=set([ctx.outputs.executable,
                 ctx.outputs.js]),
      runfiles=ctx.runfiles(
          files=[ctx.file._phantomjs_runner,
                 ctx.outputs.js],
          transitive_files=ctx.attr._phantomjs.data_runfiles.files,
          collect_data=True))

_closure_js_test = rule(
    test=True,
    implementation=_impl,
    attrs={
        "srcs": attr.label_list(allow_files=JS_TEST_FILE_TYPE),
        "language": attr.string(default=JS_LANGUAGE_DEFAULT),
        "deps": JS_DEPS_ATTR,
        "pedantic": attr.bool(default=False),
        "defs": attr.string_list(),
        "_closure_library_base": CLOSURE_LIBRARY_BASE_ATTR,
        "_closure_library_deps": CLOSURE_LIBRARY_DEPS_ATTR,
        "_compiler": attr.label(
            default=Label("//closure/compiler"),
            executable=True),
        "_phantomjs": attr.label(
            default=Label("//third_party/phantomjs"),
            allow_files=True),
        "_phantomjs_runner": attr.label(
            default=Label("//closure/testing:phantomjs_runner.js"),
            allow_files=True,
            single_file=True),
        "_phantomjs_jsunit_runner": attr.label(
            default=Label("//closure/testing:phantomjs_jsunit_runner_lib"),
            allow_files=True,
            single_file=True),
    },
    outputs={"js": "%{name}_dbg.js"})

# XXX: In compiled mode, we're forced to compile each test file individually,
#      because tests might have overlapping global symbols. We compile in
#      WHITESPACE_ONLY mode because other modes would be unreasonably slow.

def closure_js_test(name, srcs, **kwargs):
  if not srcs:
    fail("closure_js_test rules can not have an empty 'srcs' list")
  elif len(srcs) == 1:
    _closure_js_test(name = name, srcs = srcs, **kwargs)
  else:
    tests = []
    for src in srcs:
      test = name + '_' + src.replace('_test.js', '').replace('-', '_')
      tests += [test]
      _closure_js_test(name = test, srcs = [src], **kwargs)
    native.test_suite(name = name, tests = tests)
