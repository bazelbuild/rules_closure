# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":query"],
)

closure_js_library(
    name = "query",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/dojo/dom/query.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/functions",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)
