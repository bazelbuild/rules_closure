# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":animationdelay",
        ":conditionaldelay",
        ":debouncer",
        ":delay",
        ":freelist",
        ":nexttick",
        ":run",
        ":throttle",
        ":workqueue",
    ],
)

closure_js_library(
    name = "animationdelay",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/animationdelay.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/functions",
    ],
)

closure_js_library(
    name = "conditionaldelay",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/conditionaldelay.js"],
    lenient = True,
    deps = [
        "//closure/library/async:delay",
        "//closure/library/disposable",
    ],
)

closure_js_library(
    name = "debouncer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/debouncer.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "delay",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/delay.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "freelist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/freelist.js"],
    lenient = True,
)

closure_js_library(
    name = "nexttick",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/nexttick.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:entrypointregistry",
        "//closure/library/dom:tagname",
        "//closure/library/functions",
        "//closure/library/labs/useragent:browser",
        "//closure/library/labs/useragent:engine",
    ],
)

closure_js_library(
    name = "run",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/run.js"],
    lenient = True,
    deps = [
        "//closure/library/async:nexttick",
        "//closure/library/async:workqueue",
    ],
)

closure_js_library(
    name = "throttle",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/throttle.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "workqueue",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/async/workqueue.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/async:freelist",
    ],
)
