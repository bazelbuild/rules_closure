# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":promise",
        ":resolver",
        ":thenable",
    ],
)

closure_js_library(
    name = "promise",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/promise/promise.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/async:freelist",
        "//closure/library/async:nexttick",
        "//closure/library/async:run",
        "//closure/library/debug:error",
        "//closure/library/promise:resolver",
        "//closure/library/promise:thenable",
    ],
)

closure_js_library(
    name = "resolver",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/promise/resolver.js"],
    lenient = True,
)

closure_js_library(
    name = "testsuiteadapter",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/promise/testsuiteadapter.js"],
    lenient = True,
    deps = ["//closure/library/promise"],
)

closure_js_library(
    name = "thenable",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/promise/thenable.js"],
    lenient = True,
)
