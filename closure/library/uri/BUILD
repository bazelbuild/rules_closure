# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":uri",
        ":utils",
    ],
)

closure_js_library(
    name = "uri",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/uri/uri.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/string",
        "//closure/library/structs",
        "//closure/library/structs:map",
        "//closure/library/uri:utils",
    ],
)

closure_js_library(
    name = "utils",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/uri/utils.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/string",
    ],
)
