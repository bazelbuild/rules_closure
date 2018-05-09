# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":anim"],
)

closure_js_library(
    name = "anim",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/anim/anim.js"],
    lenient = True,
    deps = [
        "//closure/library/async:animationdelay",
        "//closure/library/async:delay",
        "//closure/library/object",
    ],
)
