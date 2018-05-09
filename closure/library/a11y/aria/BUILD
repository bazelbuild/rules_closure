# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":announcer",
        ":aria",
        ":attributes",
        ":datatables",
        ":roles",
    ],
)

closure_js_library(
    name = "announcer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/a11y/aria/announcer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "aria",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/a11y/aria/aria.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:datatables",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "attributes",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/a11y/aria/attributes.js"],
    lenient = True,
)

closure_js_library(
    name = "datatables",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/a11y/aria/datatables.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:attributes",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "roles",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/a11y/aria/roles.js"],
    lenient = True,
)
