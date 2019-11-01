# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":fx",
        ":transition",
    ],
)

closure_js_library(
    name = "fx",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/css3/fx.js"],
    lenient = True,
    deps = ["//closure/library/fx/css3:transition"],
)

closure_js_library(
    name = "transition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/css3/transition.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/fx:transitionbase",
        "//closure/library/style",
        "//closure/library/style:transition",
        "//closure/library/timer",
    ],
)
