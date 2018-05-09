# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":deferred",
        ":deferredlist",
    ],
)

closure_js_library(
    name = "deferred",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/mochikit/async/deferred.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:error",
        "//closure/library/promise",
        "//closure/library/promise:thenable",
    ],
)

closure_js_library(
    name = "deferredlist",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/mochikit/async/deferredlist.js"],
    lenient = True,
    deps = ["//third_party/closure/library/mochikit/async:deferred"],
)
