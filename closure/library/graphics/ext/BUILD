# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":coordinates",
        ":element",
        ":ellipse",
        ":ext",
        ":graphics",
        ":group",
        ":image",
        ":path",
        ":rectangle",
        ":shape",
        ":strokeandfillelement",
    ],
)

closure_js_library(
    name = "coordinates",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/coordinates.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "element",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/element.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/functions",
        "//closure/library/graphics/ext:coordinates",
    ],
)

closure_js_library(
    name = "ellipse",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/ellipse.js"],
    lenient = True,
    deps = ["//closure/library/graphics/ext:strokeandfillelement"],
)

closure_js_library(
    name = "ext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/ext.js"],
    lenient = True,
    deps = [
        "//closure/library/graphics/ext:coordinates",
        "//closure/library/graphics/ext:ellipse",
        "//closure/library/graphics/ext:graphics",
        "//closure/library/graphics/ext:group",
        "//closure/library/graphics/ext:image",
        "//closure/library/graphics/ext:rectangle",
        "//closure/library/graphics/ext:shape",
    ],
)

closure_js_library(
    name = "graphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/graphics.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/graphics",
        "//closure/library/graphics/ext:group",
    ],
)

closure_js_library(
    name = "group",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/group.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/graphics/ext:element",
    ],
)

closure_js_library(
    name = "image",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/image.js"],
    lenient = True,
    deps = ["//closure/library/graphics/ext:element"],
)

closure_js_library(
    name = "path",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/path.js"],
    lenient = True,
    deps = [
        "//closure/library/graphics:affinetransform",
        "//closure/library/graphics:path",
        "//closure/library/math:rect",
    ],
)

closure_js_library(
    name = "rectangle",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/rectangle.js"],
    lenient = True,
    deps = ["//closure/library/graphics/ext:strokeandfillelement"],
)

closure_js_library(
    name = "shape",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/shape.js"],
    lenient = True,
    deps = ["//closure/library/graphics/ext:strokeandfillelement"],
)

closure_js_library(
    name = "strokeandfillelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ext/strokeandfillelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics/ext:element"],
)
