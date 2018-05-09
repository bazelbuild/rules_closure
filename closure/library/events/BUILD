# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":actioneventwrapper",
        ":actionhandler",
        ":browserevent",
        ":browserfeature",
        ":event",
        ":eventhandler",
        ":eventid",
        ":events",
        ":eventtarget",
        ":eventtype",
        ":eventwrapper",
        ":filedrophandler",
        ":focushandler",
        ":imehandler",
        ":inputhandler",
        ":keycodes",
        ":keyhandler",
        ":keynames",
        ":keys",
        ":listenable",
        ":listener",
        ":listenermap",
        ":mousewheelhandler",
        ":onlinehandler",
        ":pastehandler",
        ":wheelevent",
        ":wheelhandler",
    ],
)

closure_js_library(
    name = "actioneventwrapper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/actioneventwrapper.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:eventwrapper",
        "//closure/library/events:keycodes",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "actionhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/actionhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "browserevent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/browserevent.js"],
    lenient = True,
    deps = [
        "//closure/library/debug",
        "//closure/library/events:browserfeature",
        "//closure/library/events:event",
        "//closure/library/events:eventtype",
        "//closure/library/reflect",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "browserfeature",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/browserfeature.js"],
    lenient = True,
    deps = ["//closure/library/useragent"],
)

closure_js_library(
    name = "event",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/event.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events:eventid",
    ],
)

closure_js_library(
    name = "eventhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "eventid",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventid.js"],
    lenient = True,
)

closure_js_library(
    name = "events",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/events.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:entrypointregistry",
        "//closure/library/events:browserevent",
        "//closure/library/events:browserfeature",
        "//closure/library/events:listenable",
        "//closure/library/events:listenermap",
    ],
)

closure_js_library(
    name = "eventtarget",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventtarget.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:listenable",
        "//closure/library/events:listenermap",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "eventtargettester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventtargettester.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/testing:asserts",
        "//closure/library/testing:recordfunction",
    ],
)

closure_js_library(
    name = "eventtype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventtype.js"],
    lenient = True,
    deps = [
        "//closure/library/events:browserfeature",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "eventwrapper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/eventwrapper.js"],
    lenient = True,
)

closure_js_library(
    name = "filedrophandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/filedrophandler.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "focushandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/focushandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtarget",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "imehandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/imehandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "inputhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/inputhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:keycodes",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "keycodes",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/keycodes.js"],
    lenient = True,
    deps = ["//closure/library/useragent"],
)

closure_js_library(
    name = "keyhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/keyhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "keynames",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/keynames.js"],
    lenient = True,
)

closure_js_library(
    name = "keys",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/keys.js"],
    lenient = True,
)

closure_js_library(
    name = "listenable",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/listenable.js"],
    lenient = True,
    deps = ["//closure/library/events:eventid"],
)

closure_js_library(
    name = "listener",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/listener.js"],
    lenient = True,
    deps = ["//closure/library/events:listenable"],
)

closure_js_library(
    name = "listenermap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/listenermap.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events:listener",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "mousewheelhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/mousewheelhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtarget",
        "//closure/library/math",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "onlinehandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/onlinehandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events:browserfeature",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/net:networkstatusmonitor",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "pastehandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/pastehandler.js"],
    lenient = True,
    deps = [
        "//closure/library/async:conditionaldelay",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/log",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "wheelevent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/wheelevent.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events:browserevent",
    ],
)

closure_js_library(
    name = "wheelhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/events/wheelhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:wheelevent",
        "//closure/library/style",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
        "//closure/library/useragent:product_isversion",
    ],
)
