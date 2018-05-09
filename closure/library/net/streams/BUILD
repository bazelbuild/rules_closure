# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":base64pbstreamparser",
        ":base64streamdecoder",
        ":jsonstreamparser",
        ":nodereadablestream",
        ":pbjsonstreamparser",
        ":pbstreamparser",
        ":streamfactory",
        ":streamparser",
        ":utils",
        ":xhrnodereadablestream",
        ":xhrstreamreader",
    ],
)

closure_js_library(
    name = "base64pbstreamparser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/base64pbstreamparser.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net/streams:base64streamdecoder",
        "//closure/library/net/streams:pbstreamparser",
        "//closure/library/net/streams:streamparser",
    ],
)

closure_js_library(
    name = "base64streamdecoder",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/base64streamdecoder.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/crypt:base64",
    ],
)

closure_js_library(
    name = "jsonstreamparser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/jsonstreamparser.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net/streams:streamparser",
        "//closure/library/net/streams:utils",
    ],
)

closure_js_library(
    name = "nodereadablestream",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/nodereadablestream.js"],
    lenient = True,
)

closure_js_library(
    name = "pbjsonstreamparser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/pbjsonstreamparser.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net/streams:jsonstreamparser",
        "//closure/library/net/streams:streamparser",
        "//closure/library/net/streams:utils",
    ],
)

closure_js_library(
    name = "pbstreamparser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/pbstreamparser.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net/streams:streamparser",
    ],
)

closure_js_library(
    name = "streamfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/streamfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net/streams:xhrnodereadablestream",
        "//closure/library/net/streams:xhrstreamreader",
    ],
)

closure_js_library(
    name = "streamparser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/streamparser.js"],
    lenient = True,
)

closure_js_library(
    name = "utils",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/utils.js"],
    lenient = True,
)

closure_js_library(
    name = "xhrnodereadablestream",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/xhrnodereadablestream.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/log",
        "//closure/library/net/streams:nodereadablestream",
        "//closure/library/net/streams:xhrstreamreader",
    ],
)

closure_js_library(
    name = "xhrstreamreader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/streams/xhrstreamreader.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventhandler",
        "//closure/library/log",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:httpstatus",
        "//closure/library/net:xhrio",
        "//closure/library/net:xmlhttp",
        "//closure/library/net/streams:base64pbstreamparser",
        "//closure/library/net/streams:jsonstreamparser",
        "//closure/library/net/streams:pbjsonstreamparser",
        "//closure/library/net/streams:pbstreamparser",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)
