# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":localnamefetcher",
        ":namefetcher",
        ":remotenamefetcher",
    ],
)

closure_js_library(
    name = "localnamefetcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/uchar/localnamefetcher.js"],
    lenient = True,
    deps = [
        "//closure/library/i18n:ucharnames",
        "//closure/library/i18n/uchar:namefetcher",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "namefetcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/uchar/namefetcher.js"],
    lenient = True,
)

closure_js_library(
    name = "remotenamefetcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/uchar/remotenamefetcher.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/i18n:uchar",
        "//closure/library/i18n/uchar:namefetcher",
        "//closure/library/log",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
        "//closure/library/uri",
    ],
)
