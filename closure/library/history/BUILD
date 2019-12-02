# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":event",
        ":eventtype",
        ":history",
        ":html5history",
    ],
)

closure_js_library(
    name = "event",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/history/event.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/history:eventtype",
    ],
)

closure_js_library(
    name = "eventtype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/history/eventtype.js"],
    lenient = True,
)

closure_js_library(
    name = "history",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/history/history.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:safe",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/history:event",
        "//closure/library/history:eventtype",
        "//closure/library/html:safehtml",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/labs/useragent:device",
        "//closure/library/memoize",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "html5history",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/history/html5history.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/history:event",
    ],
)
