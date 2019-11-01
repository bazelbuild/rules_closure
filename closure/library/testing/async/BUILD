# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "mockcontrol",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/async/mockcontrol.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug",
        "//closure/library/testing:asserts",
        "//closure/library/testing:mockcontrol",
        "//closure/library/testing:mockmatchers",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)
