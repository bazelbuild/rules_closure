# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":httpcors"],
)

closure_js_library(
    name = "httpcors",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/rpc/httpcors.js"],
    lenient = True,
    deps = [
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/uri",
        "//closure/library/uri:utils",
    ],
)
