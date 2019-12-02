# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":hybrid",
        ":json",
        ":jsonable",
        ":nativejsonprocessor",
        ":processor",
    ],
)

closure_js_library(
    name = "hybrid",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/json/hybrid.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/json",
    ],
)

closure_js_library(
    name = "json",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/json/json.js"],
    lenient = True,
)

closure_js_library(
    name = "jsonable",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/json/jsonable.js"],
    lenient = True,
)

closure_js_library(
    name = "nativejsonprocessor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/json/nativejsonprocessor.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/json:processor",
    ],
)

closure_js_library(
    name = "processor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/json/processor.js"],
    lenient = True,
    deps = [
        "//closure/library/string:parser",
        "//closure/library/string:stringifier",
    ],
)
