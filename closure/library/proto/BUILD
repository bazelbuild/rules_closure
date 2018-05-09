# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":proto",
        ":serializer",
    ],
)

closure_js_library(
    name = "proto",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto/proto.js"],
    lenient = True,
    deps = ["//closure/library/proto:serializer"],
)

closure_js_library(
    name = "serializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto/serializer.js"],
    lenient = True,
    deps = [
        "//closure/library/json",
        "//closure/library/string",
    ],
)
