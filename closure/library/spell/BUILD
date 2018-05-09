# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":spellcheck"],
)

closure_js_library(
    name = "spellcheck",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/spell/spellcheck.js"],
    lenient = True,
    deps = [
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/structs:set",
        "//closure/library/timer",
    ],
)
