# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":broadcastpubsub"],
)

closure_js_library(
    name = "broadcastpubsub",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/pubsub/broadcastpubsub.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/async:run",
        "//closure/library/disposable",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/log",
        "//closure/library/math",
        "//closure/library/pubsub",
        "//closure/library/storage",
        "//closure/library/storage/mechanism:html5localstorage",
        "//closure/library/string",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)
