# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":alpha",
        ":color",
        ":names",
    ],
)

closure_js_library(
    name = "alpha",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/color/alpha.js"],
    lenient = True,
    deps = ["//closure/library/color"],
)

closure_js_library(
    name = "color",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/color/color.js"],
    lenient = True,
    deps = [
        "//closure/library/color:names",
        "//closure/library/math",
    ],
)

closure_js_library(
    name = "names",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/color/names.js"],
    lenient = True,
)
