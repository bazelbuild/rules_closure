# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":basicstat"],
)

closure_js_library(
    name = "basicstat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/stats/basicstat.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/log",
        "//closure/library/string:stringformat",
        "//closure/library/structs:circularbuffer",
    ],
)
