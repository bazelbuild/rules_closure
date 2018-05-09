# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":log"],
)

closure_js_library(
    name = "log",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/log/log.js"],
    lenient = True,
    deps = [
        "//closure/library/debug",
        "//closure/library/debug:logger",
        "//closure/library/debug:logrecord",
    ],
)
