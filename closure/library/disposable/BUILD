# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":disposable",
        ":idisposable",
    ],
)

closure_js_library(
    name = "disposable",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/disposable/disposable.js"],
    lenient = True,
    deps = ["//closure/library/disposable:idisposable"],
)

closure_js_library(
    name = "idisposable",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/disposable/idisposable.js"],
    lenient = True,
)
