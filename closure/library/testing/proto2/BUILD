# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "proto2",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/proto2/proto2.js"],
    lenient = True,
    deps = [
        "//closure/library/proto2:message",
        "//closure/library/proto2:objectserializer",
        "//closure/library/testing:asserts",
    ],
)
