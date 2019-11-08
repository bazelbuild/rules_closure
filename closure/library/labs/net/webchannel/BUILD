# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":basetestchannel",
        ":channel",
        ":channelrequest",
        ":connectionstate",
        ":environment",
        ":forwardchannelrequestpool",
        ":netutils",
        ":requeststats",
        ":webchannelbase",
        ":webchannelbasetransport",
        ":webchanneldebug",
        ":wire",
        ":wirev8",
    ],
)

closure_js_library(
    name = "basetestchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/basetestchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/net:webchannel",
        "//closure/library/labs/net/webchannel:channel",
        "//closure/library/labs/net/webchannel:channelrequest",
        "//closure/library/labs/net/webchannel:requeststats",
        "//closure/library/labs/net/webchannel:webchanneldebug",
    ],
)

closure_js_library(
    name = "channel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/channel.js"],
    lenient = True,
)

closure_js_library(
    name = "channelrequest",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/channelrequest.js"],
    lenient = True,
    deps = [
        "//closure/library/async:throttle",
        "//closure/library/events:eventhandler",
        "//closure/library/labs/net:webchannel",
        "//closure/library/labs/net/webchannel:channel",
        "//closure/library/labs/net/webchannel:environment",
        "//closure/library/labs/net/webchannel:requeststats",
        "//closure/library/labs/net/webchannel:webchanneldebug",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:xmlhttp",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "connectionstate",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/connectionstate.js"],
    lenient = True,
)

closure_js_library(
    name = "environment",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/environment.js"],
    lenient = True,
    deps = ["//closure/library/useragent"],
)

closure_js_library(
    name = "forwardchannelrequestpool",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/forwardchannelrequestpool.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/labs/net/webchannel:channelrequest",
        "//closure/library/labs/net/webchannel:wire",
        "//closure/library/string",
        "//closure/library/structs:set",
    ],
)

closure_js_library(
    name = "netutils",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/netutils.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/net/webchannel:webchanneldebug",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "requeststats",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/requeststats.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
    ],
)

closure_js_library(
    name = "webchannelbase",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/webchannelbase.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/async:run",
        "//closure/library/json",
        "//closure/library/labs/net:webchannel",
        "//closure/library/labs/net/webchannel:basetestchannel",
        "//closure/library/labs/net/webchannel:channel",
        "//closure/library/labs/net/webchannel:channelrequest",
        "//closure/library/labs/net/webchannel:connectionstate",
        "//closure/library/labs/net/webchannel:forwardchannelrequestpool",
        "//closure/library/labs/net/webchannel:netutils",
        "//closure/library/labs/net/webchannel:requeststats",
        "//closure/library/labs/net/webchannel:webchanneldebug",
        "//closure/library/labs/net/webchannel:wire",
        "//closure/library/labs/net/webchannel:wirev8",
        "//closure/library/net:xhrio",
        "//closure/library/net:xmlhttpfactory",
        "//closure/library/net/rpc:httpcors",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/structs",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "webchannelbasetransport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/webchannelbasetransport.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events:eventtarget",
        "//closure/library/json",
        "//closure/library/labs/net:webchannel",
        "//closure/library/labs/net:webchanneltransport",
        "//closure/library/labs/net/webchannel:channelrequest",
        "//closure/library/labs/net/webchannel:webchannelbase",
        "//closure/library/labs/net/webchannel:wire",
        "//closure/library/log",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:path",
    ],
)

closure_js_library(
    name = "webchanneldebug",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/webchanneldebug.js"],
    lenient = True,
    deps = [
        "//closure/library/json",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "wire",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/wire.js"],
    lenient = True,
)

closure_js_library(
    name = "wirev8",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/net/webchannel/wirev8.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/json",
        "//closure/library/json:nativejsonprocessor",
        "//closure/library/labs/net/webchannel:wire",
        "//closure/library/structs",
    ],
)
