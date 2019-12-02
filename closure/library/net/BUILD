# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":browserchannel",
        ":browsertestchannel",
        ":bulkloader",
        ":bulkloaderhelper",
        ":channeldebug",
        ":channelrequest",
        ":cookies",
        ":corsxmlhttpfactory",
        ":crossdomainrpc",
        ":errorcode",
        ":eventtype",
        ":fetchxmlhttpfactory",
        ":filedownloader",
        ":httpstatus",
        ":httpstatusname",
        ":iframeio",
        ":iframeloadmonitor",
        ":imageloader",
        ":ipaddress",
        ":jsloader",
        ":jsonp",
        ":mockiframeio",
        ":multiiframeloadmonitor",
        ":networkstatusmonitor",
        ":networktester",
        ":tmpnetwork",
        ":websocket",
        ":wrapperxmlhttpfactory",
        ":xhrio",
        ":xhriopool",
        ":xhrlike",
        ":xhrmanager",
        ":xmlhttp",
        ":xmlhttpfactory",
        "//closure/library/net/rpc:all_js",
        "//closure/library/net/streams:all_js",
        "//closure/library/net/xpc:all_js",
    ],
)

closure_js_library(
    name = "browserchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/browserchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:formatter",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/json",
        "//closure/library/json:nativejsonprocessor",
        "//closure/library/log",
        "//closure/library/net:browsertestchannel",
        "//closure/library/net:channeldebug",
        "//closure/library/net:channelrequest",
        "//closure/library/net:tmpnetwork",
        "//closure/library/net:xhrio",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/structs",
        "//closure/library/structs:circularbuffer",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "browsertestchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/browsertestchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/json:nativejsonprocessor",
        "//closure/library/net:channelrequest",
        "//closure/library/net:tmpnetwork",
        "//closure/library/string:parser",
    ],
)

closure_js_library(
    name = "bulkloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/bulkloader.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/log",
        "//closure/library/net:bulkloaderhelper",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
    ],
)

closure_js_library(
    name = "bulkloaderhelper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/bulkloaderhelper.js"],
    lenient = True,
    deps = ["//closure/library/disposable"],
)

closure_js_library(
    name = "channeldebug",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/channeldebug.js"],
    lenient = True,
    deps = [
        "//closure/library/json",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "channelrequest",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/channelrequest.js"],
    lenient = True,
    deps = [
        "//closure/library/async:throttle",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:xmlhttp",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "cookies",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/cookies.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "corsxmlhttpfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/corsxmlhttpfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/net:httpstatus",
        "//closure/library/net:xhrlike",
        "//closure/library/net:xmlhttp",
        "//closure/library/net:xmlhttpfactory",
    ],
)

closure_js_library(
    name = "crossdomainrpc",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/crossdomainrpc.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/html:safehtml",
        "//closure/library/log",
        "//closure/library/net:eventtype",
        "//closure/library/net:httpstatus",
        "//closure/library/string",
        "//closure/library/uri",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "errorcode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/errorcode.js"],
    lenient = True,
)

closure_js_library(
    name = "eventtype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/eventtype.js"],
    lenient = True,
)

closure_js_library(
    name = "fetchxmlhttpfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/fetchxmlhttpfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events:eventtarget",
        "//closure/library/functions",
        "//closure/library/log",
        "//closure/library/net:xhrlike",
        "//closure/library/net:xmlhttpfactory",
    ],
)

closure_js_library(
    name = "filedownloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/filedownloader.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/crypt:hash32",
        "//closure/library/debug:error",
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/fs",
        "//closure/library/fs:entry",
        "//closure/library/fs:error",
        "//closure/library/fs:filesaver",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
        "//closure/library/net:xhriopool",
        "//closure/library/object",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "httpstatus",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/httpstatus.js"],
    lenient = True,
)

closure_js_library(
    name = "httpstatusname",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/httpstatusname.js"],
    lenient = True,
)

closure_js_library(
    name = "iframeio",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/iframeio.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:formatter",
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/html:legacyconversions",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/json",
        "//closure/library/log",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/reflect",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/structs",
        "//closure/library/timer",
        "//closure/library/uri",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "iframeloadmonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/iframeloadmonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "imageloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/imageloader.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/net:eventtype",
        "//closure/library/object",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "ipaddress",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/ipaddress.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/math:integer",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "jsloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/jsloader.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/debug:error",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/object",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "jsonp",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/jsonp.js"],
    lenient = True,
    deps = [
        "//closure/library/html:trustedresourceurl",
        "//closure/library/net:jsloader",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "mockiframeio",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/mockiframeio.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:iframeio",
    ],
)

closure_js_library(
    name = "multiiframeloadmonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/multiiframeloadmonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/net:iframeloadmonitor",
    ],
)

closure_js_library(
    name = "networkstatusmonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/networkstatusmonitor.js"],
    lenient = True,
    deps = ["//closure/library/events:listenable"],
)

closure_js_library(
    name = "networktester",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/networktester.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:safe",
        "//closure/library/log",
        "//closure/library/timer",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "tmpnetwork",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/tmpnetwork.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:safe",
        "//closure/library/net:channeldebug",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "websocket",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/websocket.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:entrypointregistry",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/log",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "wrapperxmlhttpfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/wrapperxmlhttpfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/net:xhrlike",
        "//closure/library/net:xmlhttpfactory",
    ],
)

closure_js_library(
    name = "xhrio",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xhrio.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:entrypointregistry",
        "//closure/library/events:eventtarget",
        "//closure/library/json:hybrid",
        "//closure/library/log",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:httpstatus",
        "//closure/library/net:xmlhttp",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/structs",
        "//closure/library/structs:map",
        "//closure/library/timer",
        "//closure/library/uri:utils",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "xhriopool",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xhriopool.js"],
    lenient = True,
    deps = [
        "//closure/library/net:xhrio",
        "//closure/library/structs:prioritypool",
    ],
)

closure_js_library(
    name = "xhrlike",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xhrlike.js"],
    lenient = True,
)

closure_js_library(
    name = "xhrmanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xhrmanager.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/net:errorcode",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
        "//closure/library/net:xhriopool",
        "//closure/library/structs:map",
    ],
)

closure_js_library(
    name = "xmlhttp",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xmlhttp.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/net:wrapperxmlhttpfactory",
        "//closure/library/net:xmlhttpfactory",
    ],
)

closure_js_library(
    name = "xmlhttpfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/net/xmlhttpfactory.js"],
    lenient = True,
    deps = ["//closure/library/net:xhrlike"],
)
