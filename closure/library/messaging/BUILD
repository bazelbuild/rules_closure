# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractchannel",
        ":bufferedchannel",
        ":deferredchannel",
        ":loggerclient",
        ":loggerserver",
        ":messagechannel",
        ":messaging",
        ":multichannel",
        ":portcaller",
        ":portchannel",
        ":portnetwork",
        ":portoperator",
        ":respondingchannel",
    ],
)

closure_js_library(
    name = "abstractchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/abstractchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/json",
        "//closure/library/log",
        "//closure/library/messaging:messagechannel",
    ],
)

closure_js_library(
    name = "bufferedchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/bufferedchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/log",
        "//closure/library/messaging:messagechannel",
        "//closure/library/messaging:multichannel",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "deferredchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/deferredchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/messaging:messagechannel",
    ],
)

closure_js_library(
    name = "loggerclient",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/loggerclient.js"],
    lenient = True,
    deps = [
        "//closure/library/debug",
        "//closure/library/debug:logger",
        "//closure/library/disposable",
    ],
)

closure_js_library(
    name = "loggerserver",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/loggerserver.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "messagechannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/messagechannel.js"],
    lenient = True,
)

closure_js_library(
    name = "messaging",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/messaging.js"],
    lenient = True,
)

closure_js_library(
    name = "multichannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/multichannel.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/log",
        "//closure/library/messaging:messagechannel",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "portcaller",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/portcaller.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/messaging:deferredchannel",
        "//closure/library/messaging:portchannel",
        "//closure/library/messaging:portnetwork",
        "//closure/library/object",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "portchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/portchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/debug",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/json",
        "//closure/library/log",
        "//closure/library/messaging:abstractchannel",
        "//closure/library/messaging:deferredchannel",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/timer",
        "//closure/library/useragent",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "portnetwork",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/portnetwork.js"],
    lenient = True,
)

closure_js_library(
    name = "portoperator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/portoperator.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/disposable",
        "//closure/library/log",
        "//closure/library/messaging:portchannel",
        "//closure/library/messaging:portnetwork",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "respondingchannel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/messaging/respondingchannel.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/log",
        "//closure/library/messaging:multichannel",
        "//closure/library/promise",
    ],
)
