# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "eventobserver",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/events/eventobserver.js"],
    lenient = True,
    deps = ["//closure/library/array"],
)

closure_js_library(
    name = "events",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/events/events.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/disposable",
        "//closure/library/dom:nodetype",
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:browserfeature",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/object",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "matchers",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/events/matchers.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/testing:mockmatchers",
    ],
)

closure_js_library(
    name = "onlinehandler",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/events/onlinehandler.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/net:networkstatusmonitor",
    ],
)
