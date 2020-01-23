# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":devcss",
        ":devcssrunner",
    ],
)

closure_js_library(
    name = "devcss",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/devcss/devcss.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/cssom",
        "//closure/library/dom:classlist",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "devcssrunner",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/devcss/devcssrunner.js"],
    lenient = True,
    deps = ["//closure/library/debug/devcss"],
)
