# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":style"],
)

closure_js_library(
    name = "style",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/cssom/iframe/style.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/cssom",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)
