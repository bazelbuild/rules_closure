# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "nodejs",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/bootstrap/nodejs.js"],
    lenient = True,
    no_closure_library = True,
)

closure_js_library(
    name = "webworkers",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/bootstrap/webworkers.js"],
    lenient = True,
    no_closure_library = True,
)
