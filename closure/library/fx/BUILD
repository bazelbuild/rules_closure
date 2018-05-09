# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractdragdrop",
        ":animation",
        ":animationqueue",
        ":cssspriteanimation",
        ":dom",
        ":dragdrop",
        ":dragdropgroup",
        ":dragger",
        ":draglistgroup",
        ":dragscrollsupport",
        ":easing",
        ":fx",
        ":transition",
        ":transitionbase",
        "//closure/library/fx/anim:all_js",
        "//closure/library/fx/css3:all_js",
    ],
)

closure_js_library(
    name = "abstractdragdrop",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/abstractdragdrop.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/fx:dragger",
        "//closure/library/math:box",
        "//closure/library/math:coordinate",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "animation",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/animation.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/events:event",
        "//closure/library/fx:transition",
        "//closure/library/fx:transitionbase",
        "//closure/library/fx/anim",
    ],
)

closure_js_library(
    name = "animationqueue",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/animationqueue.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/events",
        "//closure/library/fx:animation",
        "//closure/library/fx:transition",
        "//closure/library/fx:transitionbase",
    ],
)

closure_js_library(
    name = "cssspriteanimation",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/cssspriteanimation.js"],
    lenient = True,
    deps = ["//closure/library/fx:animation"],
)

closure_js_library(
    name = "dom",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/dom.js"],
    lenient = True,
    deps = [
        "//closure/library/color",
        "//closure/library/events",
        "//closure/library/fx:animation",
        "//closure/library/fx:transition",
        "//closure/library/style",
        "//closure/library/style:bidi",
    ],
)

closure_js_library(
    name = "dragdrop",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/dragdrop.js"],
    lenient = True,
    deps = ["//closure/library/fx:abstractdragdrop"],
)

closure_js_library(
    name = "dragdropgroup",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/dragdropgroup.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/fx:abstractdragdrop",
    ],
)

closure_js_library(
    name = "dragger",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/dragger.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/math:coordinate",
        "//closure/library/math:rect",
        "//closure/library/style",
        "//closure/library/style:bidi",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "draglistgroup",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/draglistgroup.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventid",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/fx:dragger",
        "//closure/library/math:coordinate",
        "//closure/library/string",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "dragscrollsupport",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/dragscrollsupport.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/math:coordinate",
        "//closure/library/style",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "easing",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/easing.js"],
    lenient = True,
)

closure_js_library(
    name = "fx",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/fx.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/fx:animation",
        "//closure/library/fx:easing",
        "//closure/library/fx:transition",
    ],
)

closure_js_library(
    name = "transition",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/transition.js"],
    lenient = True,
)

closure_js_library(
    name = "transitionbase",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fx/transitionbase.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/fx:transition",
    ],
)
