# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

load("//closure:defs.bzl", "closure_js_library")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

# closure_js_library(
#     name = "all_js",
#     exports = [
#         ":deferred",
#         ":deferredlist",
#     ],
# )

closure_js_library(
    name = "deferred",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/mochikit/async/deferred.js"],
    lenient = True,
    deps = [
        "@com_google_javascript_closure_library//closure/goog/array",
        "@com_google_javascript_closure_library//closure/goog/asserts",
        "@com_google_javascript_closure_library//closure/goog/debug:error",
        "@com_google_javascript_closure_library//closure/goog/promise",
        "@com_google_javascript_closure_library//closure/goog/promise:thenable",
    ],
)

closure_js_library(
    name = "deferredlist",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/mochikit/async/deferredlist.js"],
    lenient = True,
    deps = ["//third_party/closure/library/mochikit/async:deferred"],
)
