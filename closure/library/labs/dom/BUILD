# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":pagevisibilitymonitor"],
)

closure_js_library(
    name = "pagevisibilitymonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/dom/pagevisibilitymonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:vendor",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/memoize",
    ],
)
