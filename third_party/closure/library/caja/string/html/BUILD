# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":htmlparser"],
)

closure_js_library(
    name = "htmlparser",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/caja/string/html/htmlparser.js"],
    lenient = True,
)
