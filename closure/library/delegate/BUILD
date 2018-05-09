# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":delegateregistry",
        ":delegates",
    ],
)

closure_js_library(
    name = "delegateregistry",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/delegate/delegateregistry.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug",
    ],
)

closure_js_library(
    name = "delegates",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/delegate/delegates.js"],
    lenient = True,
)
