# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":functions"],
)

closure_js_library(
    name = "functions",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/functions/functions.js"],
    lenient = True,
)
