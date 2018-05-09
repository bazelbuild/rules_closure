# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":console",
        ":debug",
        ":debugwindow",
        ":divconsole",
        ":entrypointregistry",
        ":error",
        ":errorcontext",
        ":errorhandler",
        ":errorhandlerweakdep",
        ":errorreporter",
        ":fancywindow",
        ":formatter",
        ":fpsdisplay",
        ":logbuffer",
        ":logger",
        ":logrecord",
        ":logrecordserializer",
        ":relativetimeprovider",
        ":tracer",
        "//closure/library/debug/devcss:all_js",
    ],
)

closure_js_library(
    name = "console",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/console.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:formatter",
        "//closure/library/debug:logger",
    ],
)

closure_js_library(
    name = "debug",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/debug.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/debug:errorcontext",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "debugwindow",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/debugwindow.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:formatter",
        "//closure/library/debug:logger",
        "//closure/library/dom:safe",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestylesheet",
        "//closure/library/string:const",
        "//closure/library/structs:circularbuffer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "divconsole",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/divconsole.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:formatter",
        "//closure/library/debug:logger",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestylesheet",
        "//closure/library/string:const",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "entrypointregistry",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/entrypointregistry.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)

closure_js_library(
    name = "error",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/error.js"],
    lenient = True,
)

closure_js_library(
    name = "errorcontext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/errorcontext.js"],
    lenient = True,
)

closure_js_library(
    name = "errorhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/errorhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug",
        "//closure/library/debug:entrypointregistry",
        "//closure/library/debug:error",
        "//closure/library/debug:tracer",
        "//closure/library/disposable",
    ],
)

closure_js_library(
    name = "errorhandlerweakdep",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/errorhandlerweakdep.js"],
    lenient = True,
)

closure_js_library(
    name = "errorreporter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/errorreporter.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug",
        "//closure/library/debug:entrypointregistry",
        "//closure/library/debug:error",
        "//closure/library/debug:errorcontext",
        "//closure/library/debug:errorhandler",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/log",
        "//closure/library/net:xhrio",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/uri:utils",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "fancywindow",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/fancywindow.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:debugwindow",
        "//closure/library/debug:logger",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestylesheet",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "formatter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/formatter.js"],
    lenient = True,
    deps = [
        "//closure/library/debug",
        "//closure/library/debug:logger",
        "//closure/library/debug:relativetimeprovider",
        "//closure/library/html:safehtml",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "fpsdisplay",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/fpsdisplay.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/async:animationdelay",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "logbuffer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/logbuffer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:logrecord",
    ],
)

closure_js_library(
    name = "logger",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/logger.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug",
        "//closure/library/debug:logbuffer",
        "//closure/library/debug:logrecord",
    ],
)

closure_js_library(
    name = "logrecord",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/logrecord.js"],
    lenient = True,
)

closure_js_library(
    name = "logrecordserializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/logrecordserializer.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:logger",
        "//closure/library/debug:logrecord",
        "//closure/library/json",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "relativetimeprovider",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/relativetimeprovider.js"],
    lenient = True,
)

closure_js_library(
    name = "tracer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/debug/tracer.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:logger",
        "//closure/library/iter",
        "//closure/library/log",
        "//closure/library/structs:map",
        "//closure/library/structs:simplepool",
    ],
)
