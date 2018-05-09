# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":verificationmode"],
)

closure_js_library(
    name = "mock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/mock/mock.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug",
        "//closure/library/debug:error",
        "//closure/library/functions",
        "//closure/library/labs/mock:verificationmode",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "verificationmode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/mock/verificationmode.js"],
    lenient = True,
)
