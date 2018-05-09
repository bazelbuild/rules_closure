# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":image",
        ":webchannel",
        ":webchanneltransport",
        ":webchanneltransportfactory",
        ":xhr",
        "//closure/library/labs/net/webchannel:all_js",
    ],
)

closure_js_library(
    name = "image",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/image.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/net:eventtype",
        "//closure/library/promise",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "webchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/net:xmlhttpfactory",
    ],
)

closure_js_library(
    name = "webchanneltransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchanneltransport.js"],
    lenient = True,
)

closure_js_library(
    name = "webchanneltransportfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchanneltransportfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/functions",
        "//closure/library/labs/net/webchannel:webchannelbasetransport",
    ],
)

closure_js_library(
    name = "xhr",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/xhr.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:error",
        "//closure/library/net:httpstatus",
        "//closure/library/net:xmlhttp",
        "//closure/library/object",
        "//closure/library/promise",
        "//closure/library/string",
        "//closure/library/uri:utils",
        "//closure/library/useragent",
    ],
)
