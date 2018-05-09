# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":loremipsum"],
)

closure_js_library(
    name = "loremipsum",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/loremipsum/text/loremipsum.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/math",
        "//closure/library/string",
        "//closure/library/structs:map",
        "//closure/library/structs:set",
    ],
)
