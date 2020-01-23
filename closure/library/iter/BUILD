# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":es6",
        ":iter",
    ],
)

closure_js_library(
    name = "es6",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/iter/es6.js"],
    lenient = True,
    deps = ["//closure/library/iter"],
)

closure_js_library(
    name = "iter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/iter/iter.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/functions",
        "//closure/library/math",
    ],
)
