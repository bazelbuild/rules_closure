# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":animationframe",
        ":polyfill",
    ],
)

closure_js_library(
    name = "animationframe",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/animationframe/animationframe.js"],
    lenient = True,
    deps = ["//closure/library/dom/animationframe:polyfill"],
)

closure_js_library(
    name = "polyfill",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/animationframe/polyfill.js"],
    lenient = True,
)
