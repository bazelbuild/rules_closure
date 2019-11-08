# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":listformat",
        ":listsymbols",
        ":listsymbolsext",
    ],
)

closure_js_library(
    name = "listformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/i18n/listformat.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/labs/i18n:listsymbols",
    ],
)

closure_js_library(
    name = "listsymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/i18n/listsymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "listsymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/i18n/listsymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/labs/i18n:listsymbols"],
)
