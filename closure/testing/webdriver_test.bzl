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

load("@bazel_skylib//lib:shell.bzl", "shell")
load("@rules_browsers//browsers:named_files_info.bzl", "NamedFilesInfo")
load("//closure:webfiles/web_library.bzl", "web_library")
load("//closure/private:defs.bzl", "collect_runfiles")

ClosureBrowserInfo = provider(
    doc = "Provider for a custom browser with a metadata configuration file.",
    fields = {
        "named_files": "The underlying NamedFilesInfo provider.",
        "metadata": "Optional metadata JSON File configuring browser capabilities.",
    },
)

def _custom_browser_impl(ctx):
    runfiles = ctx.attr.browser[DefaultInfo].default_runfiles
    if ctx.file.metadata:
        runfiles = runfiles.merge(ctx.runfiles(files = [ctx.file.metadata]))
    return [
        DefaultInfo(runfiles = runfiles),
        ClosureBrowserInfo(
            named_files = ctx.attr.browser[NamedFilesInfo],
            metadata = ctx.file.metadata,
        ),
    ]

custom_browser = rule(
    implementation = _custom_browser_impl,
    doc = "Wraps a rules_browsers browser target with optional WebDriver metadata.",
    attrs = {
        "browser": attr.label(
            mandatory = True,
            providers = [NamedFilesInfo],
        ),
        "metadata": attr.label(
            allow_single_file = [".json"],
            doc = (
                "Optional JSON file configuring browser capabilities. The format is compatible with " +
                "https://github.com/bazelbuild/rules_webtesting/blob/master/go/metadata/metadata.go " +
                "(only the 'capabilities' field is read)."
            ),
        ),
    },
)

def _webdriver_test_impl(ctx):
    if ClosureBrowserInfo in ctx.attr.browser:
        info = ctx.attr.browser[ClosureBrowserInfo]
        named = info.named_files.value
        metadata = info.metadata
    else:
        named = ctx.attr.browser[NamedFilesInfo].value
        metadata = None

    if "CHROME-HEADLESS-SHELL" in named and "CHROMEDRIVER" in named:
        browser_type = "chrome"
        browser_binary = named["CHROME-HEADLESS-SHELL"]
        webdriver_binary = named["CHROMEDRIVER"]
    else:
        fail(
            "Browser target %s must provide 'CHROME-HEADLESS-SHELL' and 'CHROMEDRIVER' in NamedFilesInfo (got %s)" %
            (ctx.attr.browser.label, named.keys()),
        )

    cmd_args = [
        shell.quote(ctx.executable.test.short_path),
        shell.quote(ctx.attr.html_webpath),
        "--browser_type",
        shell.quote(browser_type),
        "--browser_binary",
        shell.quote(browser_binary.short_path),
        "--webdriver_binary",
        shell.quote(webdriver_binary.short_path),
    ]
    if metadata:
        cmd_args.extend(["--metadata", shell.quote(metadata.short_path)])

    ctx.actions.write(
        output = ctx.outputs.executable,
        is_executable = True,
        content = """\
#!/bin/sh
export SE_OFFLINE=true
exec {cmd} "$@"
""".format(cmd = " ".join(cmd_args)),
    )

    runfiles = collect_runfiles(
        ctx,
        files = [ctx.outputs.executable, browser_binary, webdriver_binary],
        extra_runfiles_attrs = ["test", "browser"],
    )
    return [DefaultInfo(
        executable = ctx.outputs.executable,
        files = depset([ctx.outputs.executable]),
        runfiles = runfiles,
    )]

_webdriver_test = rule(
    implementation = _webdriver_test_impl,
    test = True,
    attrs = {
        "browser": attr.label(
            mandatory = True,
            providers = [[ClosureBrowserInfo], [NamedFilesInfo]],
        ),
        "data": attr.label_list(allow_files = True),
        "html_webpath": attr.string(mandatory = True),
        "test": attr.label(executable = True, cfg = "target", mandatory = True),
    },
)

def webdriver_test(
        name,
        browsers,
        test_file_js,
        data = None,
        tags = None,
        visibility = None,
        **kwargs):
    """ Macro for running Closure JavaScript binary on browsers.

    Args:
        test_file_js: JavaScipt binary output from closure_js_binary
        **kwargs: Additional arguments for test rules.

    To run the test target, use `bazel test :<name>`.

    To debug the test locally on the browser, add '_debug' to the name of your test. E.g.: `bazel run :<name>_debug`.
    Open the URL printed in the console and click on the html link to the generated testsuite.
    """

    if not browsers:
        fail("webdriver_test requires at least one browser")

    tags = tags or []

    html = "gen_html_%s" % name
    _gen_test_html(
        name = html,
        test_file_js = test_file_js,
        tags = tags,
    )

    path = "/"
    html_webpath = "%s%s.html" % (path, html)

    web_library(
        name = "%s_test_files" % name,
        srcs = [html, test_file_js],
        path = path,
        tags = tags,
        testonly = True,
    )

    # set up a development web server that links to the test for debugging purposes.
    web_library(
        name = "%s_debug" % name,
        srcs = data if data else [],
        deps = [":%s_test_files" % name],
        path = path,
        tags = tags,
        testonly = True,
        use_full_path = True,
    )

    web_library(
        name = "%s_test_runner" % name,
        srcs = data if data else [],
        deps = [":%s_test_files" % name],
        path = path,
        server = Label("//java/io/bazel/rules/closure/testing:webdriver_test_bin"),
        tags = tags,
        testonly = True,
        use_full_path = True,
    )

    if len(browsers) == 1:
        _webdriver_test(
            name = name,
            data = [test_file_js, html],
            browser = browsers[0],
            test = ":%s_test_runner" % name,
            html_webpath = html_webpath,
            tags = tags + ["no-sandbox", "native"],
            visibility = visibility,
            **kwargs
        )
    else:
        test_names = []
        for i, browser in enumerate(browsers):
            sub_name = "%s_browser_%d" % (name, i)
            test_names.append(":" + sub_name)
            _webdriver_test(
                name = sub_name,
                data = [test_file_js, html],
                browser = browser,
                test = ":%s_test_runner" % name,
                html_webpath = html_webpath,
                tags = tags + ["no-sandbox", "native"],
                visibility = visibility,
                **kwargs
            )
        native.test_suite(
            name = name,
            tests = test_names,
            tags = tags,
            visibility = visibility,
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
