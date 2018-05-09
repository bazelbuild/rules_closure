# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":const",
        ":linkify",
        ":newlines",
        ":parser",
        ":path",
        ":string",
        ":stringbuffer",
        ":stringformat",
        ":stringifier",
        ":typedstring",
    ],
)

closure_js_library(
    name = "const",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/const.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "linkify",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/linkify.js"],
    lenient = True,
    deps = [
        "//closure/library/html:safehtml",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "newlines",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/newlines.js"],
    lenient = True,
    deps = ["//closure/library/array"],
)

closure_js_library(
    name = "parser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/parser.js"],
    lenient = True,
)

closure_js_library(
    name = "path",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/path.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "string",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/string.js"],
    lenient = True,
)

closure_js_library(
    name = "stringbuffer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/stringbuffer.js"],
    lenient = True,
)

closure_js_library(
    name = "stringformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/stringformat.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "stringifier",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/stringifier.js"],
    lenient = True,
)

closure_js_library(
    name = "typedstring",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/string/typedstring.js"],
    lenient = True,
)
