# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":bidi",
        ":cursor",
        ":style",
        ":transform",
        ":transition",
    ],
)

closure_js_library(
    name = "bidi",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/bidi.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/style",
        "//closure/library/useragent",
        "//closure/library/useragent:platform",
        "//closure/library/useragent:product",
        "//closure/library/useragent:product_isversion",
    ],
)

closure_js_library(
    name = "cursor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/cursor.js"],
    lenient = True,
    deps = ["//closure/library/useragent"],
)

closure_js_library(
    name = "style",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/style.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/dom:vendor",
        "//closure/library/html:safestylesheet",
        "//closure/library/math:box",
        "//closure/library/math:coordinate",
        "//closure/library/math:rect",
        "//closure/library/math:size",
        "//closure/library/object",
        "//closure/library/reflect",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "stylescrollbartester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/stylescrollbartester.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "transform",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/transform.js"],
    lenient = True,
    deps = [
        "//closure/library/functions",
        "//closure/library/math:coordinate",
        "//closure/library/math:coordinate3",
        "//closure/library/style",
        "//closure/library/useragent",
        "//closure/library/useragent:product_isversion",
    ],
)

closure_js_library(
    name = "transition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/style/transition.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/dom:vendor",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)
