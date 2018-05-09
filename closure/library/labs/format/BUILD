# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":csv"],
)

closure_js_library(
    name = "csv",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/format/csv.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:error",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:newlines",
    ],
)
