# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "layoutasserts",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/style/layoutasserts.js"],
    lenient = True,
    deps = [
        "//closure/library/style",
        "//closure/library/testing:asserts",
        "//closure/library/testing/style",
    ],
)

closure_js_library(
    name = "style",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/style/style.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/math:rect",
        "//closure/library/style",
    ],
)
