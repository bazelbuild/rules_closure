# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":absoluteposition",
        ":abstractposition",
        ":anchoredposition",
        ":anchoredviewportposition",
        ":clientposition",
        ":menuanchoredposition",
        ":positioning",
        ":viewportclientposition",
        ":viewportposition",
    ],
)

closure_js_library(
    name = "absoluteposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/absoluteposition.js"],
    lenient = True,
    deps = [
        "//closure/library/math:coordinate",
        "//closure/library/positioning",
        "//closure/library/positioning:abstractposition",
    ],
)

closure_js_library(
    name = "abstractposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/abstractposition.js"],
    lenient = True,
)

closure_js_library(
    name = "anchoredposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/anchoredposition.js"],
    lenient = True,
    deps = [
        "//closure/library/positioning",
        "//closure/library/positioning:abstractposition",
    ],
)

closure_js_library(
    name = "anchoredviewportposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/anchoredviewportposition.js"],
    lenient = True,
    deps = [
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredposition",
    ],
)

closure_js_library(
    name = "clientposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/clientposition.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/math:coordinate",
        "//closure/library/positioning",
        "//closure/library/positioning:abstractposition",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "menuanchoredposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/menuanchoredposition.js"],
    lenient = True,
    deps = [
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredviewportposition",
    ],
)

closure_js_library(
    name = "positioning",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/positioning.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/math:coordinate",
        "//closure/library/math:rect",
        "//closure/library/math:size",
        "//closure/library/style",
        "//closure/library/style:bidi",
    ],
)

closure_js_library(
    name = "viewportclientposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/viewportclientposition.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/math:coordinate",
        "//closure/library/positioning",
        "//closure/library/positioning:clientposition",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "viewportposition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/positioning/viewportposition.js"],
    lenient = True,
    deps = [
        "//closure/library/math:coordinate",
        "//closure/library/positioning",
        "//closure/library/positioning:abstractposition",
        "//closure/library/style",
    ],
)
