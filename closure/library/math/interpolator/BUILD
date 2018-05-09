# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":interpolator1",
        ":linear1",
        ":pchip1",
        ":spline1",
    ],
)

closure_js_library(
    name = "interpolator1",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/interpolator/interpolator1.js"],
    lenient = True,
)

closure_js_library(
    name = "linear1",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/interpolator/linear1.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/math",
        "//closure/library/math/interpolator:interpolator1",
    ],
)

closure_js_library(
    name = "pchip1",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/interpolator/pchip1.js"],
    lenient = True,
    deps = [
        "//closure/library/math",
        "//closure/library/math/interpolator:spline1",
    ],
)

closure_js_library(
    name = "spline1",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/interpolator/spline1.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/math",
        "//closure/library/math:tdma",
        "//closure/library/math/interpolator:interpolator1",
    ],
)
