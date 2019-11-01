# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "mockiframeio",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/net/mockiframeio.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:iframeio",
        "//closure/library/testing:testqueue",
    ],
)

closure_js_library(
    name = "xhrio",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/net/xhrio.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom:xml",
        "//closure/library/events",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:httpstatus",
        "//closure/library/net:xhrio",
        "//closure/library/net:xmlhttp",
        "//closure/library/object",
        "//closure/library/structs",
        "//closure/library/structs:map",
        "//closure/library/testing:testqueue",
        "//closure/library/uri",
        "//closure/library/uri:utils",
    ],
)

closure_js_library(
    name = "xhriopool",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/net/xhriopool.js"],
    lenient = True,
    deps = [
        "//closure/library/net:xhriopool",
        "//closure/library/testing/net:xhrio",
    ],
)
