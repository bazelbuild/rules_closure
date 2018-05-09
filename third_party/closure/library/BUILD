# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        "//third_party/closure/library/caja/string/html:all_js",
        "//third_party/closure/library/dojo/dom:all_js",
        "//third_party/closure/library/loremipsum/text:all_js",
        "//third_party/closure/library/mochikit/async:all_js",
        "//third_party/closure/library/svgpan:all_js",
    ],
)

closure_js_library(
    name = "base",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/base.js"],
    lenient = True,
    no_closure_library = True,
)

closure_js_library(
    name = "deps",
    srcs = ["@com_google_javascript_closure_library//:third_party/closure/goog/deps.js"],
    lenient = True,
    no_closure_library = True,
)
