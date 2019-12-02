# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":pubsub",
        ":topicid",
        ":typedpubsub",
    ],
)

closure_js_library(
    name = "pubsub",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/pubsub/pubsub.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/async:run",
        "//closure/library/disposable",
    ],
)

closure_js_library(
    name = "topicid",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/pubsub/topicid.js"],
    lenient = True,
)

closure_js_library(
    name = "typedpubsub",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/pubsub/typedpubsub.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/pubsub",
    ],
)
