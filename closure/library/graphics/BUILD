# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractgraphics",
        ":affinetransform",
        ":canvaselement",
        ":canvasgraphics",
        ":element",
        ":ellipseelement",
        ":fill",
        ":font",
        ":graphics",
        ":groupelement",
        ":imageelement",
        ":lineargradient",
        ":path",
        ":pathelement",
        ":paths",
        ":rectelement",
        ":solidfill",
        ":stroke",
        ":strokeandfillelement",
        ":svgelement",
        ":svggraphics",
        ":textelement",
        ":vmlelement",
        ":vmlgraphics",
        "//closure/library/graphics/ext:all_js",
    ],
)

closure_js_library(
    name = "abstractgraphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/abstractgraphics.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/graphics:affinetransform",
        "//closure/library/graphics:element",
        "//closure/library/graphics:ellipseelement",
        "//closure/library/graphics:fill",
        "//closure/library/graphics:font",
        "//closure/library/graphics:groupelement",
        "//closure/library/graphics:path",
        "//closure/library/graphics:pathelement",
        "//closure/library/graphics:rectelement",
        "//closure/library/graphics:stroke",
        "//closure/library/graphics:strokeandfillelement",
        "//closure/library/graphics:textelement",
        "//closure/library/math:coordinate",
        "//closure/library/math:size",
        "//closure/library/style",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "affinetransform",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/affinetransform.js"],
    lenient = True,
)

closure_js_library(
    name = "canvaselement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/canvaselement.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/graphics:ellipseelement",
        "//closure/library/graphics:font",
        "//closure/library/graphics:groupelement",
        "//closure/library/graphics:imageelement",
        "//closure/library/graphics:path",
        "//closure/library/graphics:pathelement",
        "//closure/library/graphics:rectelement",
        "//closure/library/graphics:textelement",
        "//closure/library/html:safehtml",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/math",
        "//closure/library/string",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "canvasgraphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/canvasgraphics.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/graphics:abstractgraphics",
        "//closure/library/graphics:canvaselement",
        "//closure/library/graphics:font",
        "//closure/library/graphics:solidfill",
        "//closure/library/math:size",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "element",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/element.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:listenable",
        "//closure/library/graphics:affinetransform",
        "//closure/library/math",
    ],
)

closure_js_library(
    name = "ellipseelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/ellipseelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:strokeandfillelement"],
)

closure_js_library(
    name = "fill",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/fill.js"],
    lenient = True,
)

closure_js_library(
    name = "font",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/font.js"],
    lenient = True,
)

closure_js_library(
    name = "graphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/graphics.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/graphics:canvasgraphics",
        "//closure/library/graphics:svggraphics",
        "//closure/library/graphics:vmlgraphics",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "groupelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/groupelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:element"],
)

closure_js_library(
    name = "imageelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/imageelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:element"],
)

closure_js_library(
    name = "lineargradient",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/lineargradient.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/graphics:fill",
    ],
)

closure_js_library(
    name = "path",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/path.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/graphics:affinetransform",
        "//closure/library/math",
    ],
)

closure_js_library(
    name = "pathelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/pathelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:strokeandfillelement"],
)

closure_js_library(
    name = "paths",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/paths.js"],
    lenient = True,
    deps = [
        "//closure/library/graphics:path",
        "//closure/library/math:coordinate",
    ],
)

closure_js_library(
    name = "rectelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/rectelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:strokeandfillelement"],
)

closure_js_library(
    name = "solidfill",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/solidfill.js"],
    lenient = True,
    deps = ["//closure/library/graphics:fill"],
)

closure_js_library(
    name = "stroke",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/stroke.js"],
    lenient = True,
)

closure_js_library(
    name = "strokeandfillelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/strokeandfillelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:element"],
)

closure_js_library(
    name = "svgelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/svgelement.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/graphics:ellipseelement",
        "//closure/library/graphics:groupelement",
        "//closure/library/graphics:imageelement",
        "//closure/library/graphics:pathelement",
        "//closure/library/graphics:rectelement",
        "//closure/library/graphics:textelement",
    ],
)

closure_js_library(
    name = "svggraphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/svggraphics.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/graphics:abstractgraphics",
        "//closure/library/graphics:font",
        "//closure/library/graphics:lineargradient",
        "//closure/library/graphics:path",
        "//closure/library/graphics:solidfill",
        "//closure/library/graphics:stroke",
        "//closure/library/graphics:svgelement",
        "//closure/library/math",
        "//closure/library/math:size",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "textelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/textelement.js"],
    lenient = True,
    deps = ["//closure/library/graphics:strokeandfillelement"],
)

closure_js_library(
    name = "vmlelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/vmlelement.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/graphics:ellipseelement",
        "//closure/library/graphics:groupelement",
        "//closure/library/graphics:imageelement",
        "//closure/library/graphics:pathelement",
        "//closure/library/graphics:rectelement",
        "//closure/library/graphics:textelement",
    ],
)

closure_js_library(
    name = "vmlgraphics",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/graphics/vmlgraphics.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/graphics:abstractgraphics",
        "//closure/library/graphics:font",
        "//closure/library/graphics:lineargradient",
        "//closure/library/graphics:path",
        "//closure/library/graphics:solidfill",
        "//closure/library/graphics:vmlelement",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/math",
        "//closure/library/math:size",
        "//closure/library/reflect",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)
