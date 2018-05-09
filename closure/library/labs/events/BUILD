# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":nondisposableeventtarget",
        ":touch",
    ],
)

closure_js_library(
    name = "nondisposableeventtarget",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/events/nondisposableeventtarget.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/events:event",
        "//closure/library/events:listenable",
        "//closure/library/events:listenermap",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "touch",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/events/touch.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/events:eventtype",
        "//closure/library/string",
    ],
)
