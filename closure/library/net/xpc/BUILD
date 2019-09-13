# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":crosspagechannel",
        ":crosspagechannelrole",
        ":directtransport",
        ":frameelementmethodtransport",
        ":iframepollingtransport",
        ":iframerelaytransport",
        ":nativemessagingtransport",
        ":nixtransport",
        ":relay",
        ":transport",
        ":xpc",
    ],
)

closure_js_library(
    name = "crosspagechannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/crosspagechannel.js"],
    lenient = True,
    deps = [
        "//closure/library/async:delay",
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/html:legacyconversions",
        "//closure/library/json",
        "//closure/library/log",
        "//closure/library/messaging:abstractchannel",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:directtransport",
        "//closure/library/net/xpc:frameelementmethodtransport",
        "//closure/library/net/xpc:iframerelaytransport",
        "//closure/library/net/xpc:nativemessagingtransport",
        "//closure/library/net/xpc:nixtransport",
        "//closure/library/string",
        "//closure/library/uri",
        "//closure/library/uri:utils",
        "//closure/library/useragent",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "crosspagechannelrole",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/crosspagechannelrole.js"],
    lenient = True,
)

closure_js_library(
    name = "directtransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/directtransport.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventhandler",
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:transport",
        "//closure/library/object",
        "//closure/library/timer",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "frameelementmethodtransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/frameelementmethodtransport.js"],
    lenient = True,
    deps = [
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:transport",
    ],
)

closure_js_library(
    name = "iframepollingtransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/iframepollingtransport.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:transport",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "iframerelaytransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/iframerelaytransport.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/html:safehtml",
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:transport",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "nativemessagingtransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/nativemessagingtransport.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:transport",
        "//closure/library/timer",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "nixtransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/nixtransport.js"],
    lenient = True,
    deps = [
        "//closure/library/log",
        "//closure/library/net/xpc",
        "//closure/library/net/xpc:crosspagechannelrole",
        "//closure/library/net/xpc:transport",
        "//closure/library/reflect",
    ],
)

closure_js_library(
    name = "relay",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/relay.js"],
    lenient = True,
)

closure_js_library(
    name = "transport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/transport.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/net/xpc",
    ],
)

closure_js_library(
    name = "xpc",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xpc/xpc.js"],
    lenient = True,
    deps = ["//closure/library/log"],
)
