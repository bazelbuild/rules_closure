# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":callback",
        ":counter",
        ":test",
    ],
)

closure_js_library(
    name = "callback",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/callback/callback.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagiterator",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "counter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/callback/counter.js"],
    lenient = True,
)

closure_js_library(
    name = "test",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/callback/test.js"],
    lenient = True,
    deps = ["//closure/library/iter"],
)
