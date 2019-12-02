# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractrange",
        ":browserrange",
        ":geckorange",
        ":ierange",
        ":operarange",
        ":w3crange",
        ":webkitrange",
    ],
)

closure_js_library(
    name = "abstractrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/abstractrange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:rangeendpoint",
        "//closure/library/dom:tagname",
        "//closure/library/dom:textrangeiterator",
        "//closure/library/iter",
        "//closure/library/math:coordinate",
        "//closure/library/string",
        "//closure/library/string:stringbuffer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "browserrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/browserrange.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:browserfeature",
        "//closure/library/dom:nodetype",
        "//closure/library/dom/browserrange:geckorange",
        "//closure/library/dom/browserrange:ierange",
        "//closure/library/dom/browserrange:operarange",
        "//closure/library/dom/browserrange:w3crange",
        "//closure/library/dom/browserrange:webkitrange",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "geckorange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/geckorange.js"],
    lenient = True,
    deps = ["//closure/library/dom/browserrange:w3crange"],
)

closure_js_library(
    name = "ierange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/ierange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:rangeendpoint",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/dom/browserrange:abstractrange",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/log",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "operarange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/operarange.js"],
    lenient = True,
    deps = ["//closure/library/dom/browserrange:w3crange"],
)

closure_js_library(
    name = "w3crange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/w3crange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:rangeendpoint",
        "//closure/library/dom:tagname",
        "//closure/library/dom/browserrange:abstractrange",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "webkitrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserrange/webkitrange.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:rangeendpoint",
        "//closure/library/dom/browserrange:w3crange",
        "//closure/library/useragent",
    ],
)
