# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":emoji",
        ":emojipalette",
        ":emojipaletterenderer",
        ":emojipicker",
        ":popupemojipicker",
        ":progressiveemojipaletterenderer",
        ":spriteinfo",
    ],
)

closure_js_library(
    name = "emoji",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/emoji.js"],
    lenient = True,
)

closure_js_library(
    name = "emojipalette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/emojipalette.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtype",
        "//closure/library/net:imageloader",
        "//closure/library/ui:palette",
        "//closure/library/ui/emoji",
        "//closure/library/ui/emoji:emojipaletterenderer",
    ],
)

closure_js_library(
    name = "emojipaletterenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/emojipaletterenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:paletterenderer",
        "//closure/library/ui/emoji",
    ],
)

closure_js_library(
    name = "emojipicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/emojipicker.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:tabpane",
        "//closure/library/ui/emoji",
        "//closure/library/ui/emoji:emojipalette",
        "//closure/library/ui/emoji:emojipaletterenderer",
        "//closure/library/ui/emoji:progressiveemojipaletterenderer",
    ],
)

closure_js_library(
    name = "popupemojipicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/popupemojipicker.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtype",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredposition",
        "//closure/library/ui:component",
        "//closure/library/ui:popup",
        "//closure/library/ui/emoji:emojipicker",
    ],
)

closure_js_library(
    name = "progressiveemojipaletterenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/progressiveemojipaletterenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui/emoji:emojipaletterenderer",
    ],
)

closure_js_library(
    name = "spriteinfo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/emoji/spriteinfo.js"],
    lenient = True,
)
