# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":window"],
)

closure_js_library(
    name = "window",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/window/window.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/labs/useragent:platform",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/useragent",
    ],
)
