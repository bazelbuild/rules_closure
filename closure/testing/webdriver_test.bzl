# Copyright 2022 The Closure Rules Authors. All rights reserved.
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

"""Macro for running webtest with a test driver."""

load("//closure:webfiles/web_library.bzl", "web_library")
load("@io_bazel_rules_webtesting//web:web.bzl", "web_test_suite")

def webdriver_test(
        name,
        browsers,
        test_file_js,
        data = None,
        tags = [],
        visibility = None,
        **kwargs):
    """ Macro for running Closure JavaScript binary on browsers.

    Args:
        test_file_js: JavaScipt binary output from closure_js_binary
        **kwargs: Additional arguments for web_test rules.

    To run the test target, use `bazel test :<name>`.

    To debug the test locally on the browser, add '_debug' to the name of your test. E.g.: `bazel run :<name>_debug`.
    Open the URL printed in the console and click on the html link to the generated testsuite.
    """

    html = "gen_html_%s" % name
    _gen_test_html(
        name = html,
        test_file_js = test_file_js,
    )

    path = "/"
    html_webpath = "%s%s.html" % (path, html)

    web_library(
        name = "%s_test_files" % name,
        srcs = [html, test_file_js],
        path = path,
        testonly = True,
    )

    # set up a development web server that links to the test for debugging purposes.
    web_library(
        name = "%s_debug" % name,
        srcs = data if data else [],
        deps = [":%s_test_files" % name],
        path = path,
        testonly = True,
        use_full_path = True,
    )

    web_library(
        name = "%s_test_runner" % name,
        srcs = data if data else [],
        deps = [":%s_test_files" % name],
        path = path,
        server = Label("//java/io/bazel/rules/closure/testing:webdriver_test_bin"),
        testonly = True,
        use_full_path = True,
    )

    web_test_suite(
        name = name,
        data = [test_file_js, html],
        test = ":%s_test_runner" % name,
        args = [html_webpath],
        browsers = browsers,
        tags = tags + ["no-sandbox", "native"],
        visibility = visibility,
        **kwargs
    )

def _gen_test_html_impl(ctx):
    """Implementation of the gen_test_html rule."""
    ctx.actions.expand_template(
        template = ctx.file._template,
        output = ctx.outputs.html_file,
        substitutions = {
            "{{TEST_FILE_JS}}": ctx.attr.test_file_js,
        },
    )
    runfiles = ctx.runfiles(files = [ctx.outputs.html_file], collect_default = True)
    return [DefaultInfo(runfiles = runfiles)]

# Used to generate default test.html file for running Closure-based JS tests.
# The test_file_js argument specifies the name of the JS file containing tests,
# typically created with closure_js_binary.
# The output is created from gen_test_html.template file.
_gen_test_html = rule(
    implementation = _gen_test_html_impl,
    attrs = {
        "test_file_js": attr.string(mandatory = True),
        "_template": attr.label(
            default = Label("//closure/testing:gen_webtest_html.template"),
            allow_single_file = True,
        ),
    },
    outputs = {"html_file": "%{name}.html"},
)
