# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":flashobject",
        ":flickr",
        ":googlevideo",
        ":media",
        ":mediamodel",
        ":mp3",
        ":photo",
        ":picasa",
        ":vimeo",
        ":youtube",
    ],
)

closure_js_library(
    name = "flashobject",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/flashobject.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/html:flash",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/log",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/structs:map",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/useragent",
        "//closure/library/useragent:flash",
    ],
)

closure_js_library(
    name = "flickr",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/flickr.js"],
    lenient = True,
    deps = [
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string:const",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
        "//closure/library/ui/media:mediamodel",
    ],
)

closure_js_library(
    name = "googlevideo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/googlevideo.js"],
    lenient = True,
    deps = [
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
        "//closure/library/ui/media:mediamodel",
    ],
)

closure_js_library(
    name = "media",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/media.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "mediamodel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/mediamodel.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/html:trustedresourceurl",
    ],
)

closure_js_library(
    name = "mp3",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/mp3.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
    ],
)

closure_js_library(
    name = "photo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/photo.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/ui/media",
    ],
)

closure_js_library(
    name = "picasa",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/picasa.js"],
    lenient = True,
    deps = [
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string:const",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
        "//closure/library/ui/media:mediamodel",
    ],
)

closure_js_library(
    name = "vimeo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/vimeo.js"],
    lenient = True,
    deps = [
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
        "//closure/library/ui/media:mediamodel",
    ],
)

closure_js_library(
    name = "youtube",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/media/youtube.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/ui:component",
        "//closure/library/ui/media",
        "//closure/library/ui/media:flashobject",
        "//closure/library/ui/media:mediamodel",
    ],
)
