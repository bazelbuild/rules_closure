# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":affinetransform",
        ":bezier",
        ":box",
        ":coordinate",
        ":coordinate3",
        ":exponentialbackoff",
        ":integer",
        ":irect",
        ":line",
        ":long",
        ":math",
        ":matrix",
        ":path",
        ":paths",
        ":range",
        ":rangeset",
        ":rect",
        ":size",
        ":tdma",
        ":vec2",
        ":vec3",
        "//closure/library/math/interpolator:all_js",
    ],
)

closure_js_library(
    name = "affinetransform",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/affinetransform.js"],
    lenient = True,
)

closure_js_library(
    name = "bezier",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/bezier.js"],
    lenient = True,
    deps = [
        "//closure/library/math",
        "//closure/library/math:coordinate",
    ],
)

closure_js_library(
    name = "box",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/box.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/math:coordinate",
    ],
)

closure_js_library(
    name = "coordinate",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/coordinate.js"],
    lenient = True,
    deps = ["//closure/library/math"],
)

closure_js_library(
    name = "coordinate3",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/coordinate3.js"],
    lenient = True,
)

closure_js_library(
    name = "exponentialbackoff",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/exponentialbackoff.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)

closure_js_library(
    name = "integer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/integer.js"],
    lenient = True,
    deps = ["//closure/library/reflect"],
)

closure_js_library(
    name = "irect",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/irect.js"],
    lenient = True,
)

closure_js_library(
    name = "line",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/line.js"],
    lenient = True,
    deps = [
        "//closure/library/math",
        "//closure/library/math:coordinate",
    ],
)

closure_js_library(
    name = "long",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/long.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/reflect",
    ],
)

closure_js_library(
    name = "math",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/math.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
    ],
)

closure_js_library(
    name = "matrix",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/matrix.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/math",
        "//closure/library/math:size",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "path",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/path.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/math",
        "//closure/library/math:affinetransform",
    ],
)

closure_js_library(
    name = "paths",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/paths.js"],
    lenient = True,
    deps = [
        "//closure/library/math:coordinate",
        "//closure/library/math:path",
    ],
)

closure_js_library(
    name = "range",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/range.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)

closure_js_library(
    name = "rangeset",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/rangeset.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/iter",
        "//closure/library/math:range",
    ],
)

closure_js_library(
    name = "rect",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/rect.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/math:box",
        "//closure/library/math:coordinate",
        "//closure/library/math:irect",
        "//closure/library/math:size",
    ],
)

closure_js_library(
    name = "size",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/size.js"],
    lenient = True,
)

closure_js_library(
    name = "tdma",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/tdma.js"],
    lenient = True,
)

closure_js_library(
    name = "vec2",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/vec2.js"],
    lenient = True,
    deps = [
        "//closure/library/math",
        "//closure/library/math:coordinate",
    ],
)

closure_js_library(
    name = "vec3",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/math/vec3.js"],
    lenient = True,
    deps = [
        "//closure/library/math",
        "//closure/library/math:coordinate3",
    ],
)
