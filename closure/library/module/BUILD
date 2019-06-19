# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractmoduleloader",
        ":basemodule",
        ":loader",
        ":module",
        ":moduleinfo",
        ":moduleloadcallback",
        ":moduleloader",
        ":modulemanager",
    ],
)

closure_js_library(
    name = "abstractmoduleloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/abstractmoduleloader.js"],
    lenient = True,
    deps = [
        "//closure/library/module",
        "//closure/library/module:moduleinfo",
    ],
)

closure_js_library(
    name = "basemodule",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/basemodule.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/module",
    ],
)

closure_js_library(
    name = "loader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/loader.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:legacyconversions",
        "//closure/library/module",
        "//closure/library/object",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "module",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/module.js"],
    lenient = True,
)

closure_js_library(
    name = "moduleinfo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/moduleinfo.js"],
    lenient = True,
    deps = [
        "//closure/library/async:nexttick",
        "//closure/library/disposable",
        "//closure/library/functions",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/module",
        "//closure/library/module:basemodule",
        "//closure/library/module:moduleloadcallback",
    ],
)

closure_js_library(
    name = "moduleloadcallback",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/moduleloadcallback.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:entrypointregistry",
        "//closure/library/module",
    ],
)

closure_js_library(
    name = "moduleloader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/moduleloader.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventid",
        "//closure/library/events:eventtarget",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/labs/useragent:browser",
        "//closure/library/log",
        "//closure/library/module:abstractmoduleloader",
        "//closure/library/net:bulkloader",
        "//closure/library/net:eventtype",
        "//closure/library/net:jsloader",
        "//closure/library/timer",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "modulemanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/module/modulemanager.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:tracer",
        "//closure/library/disposable",
        "//closure/library/disposable:idisposable",
        "//closure/library/loader:abstractmodulemanager",
        "//closure/library/loader:activemodulemanager",
        "//closure/library/log",
        "//closure/library/module",
        "//closure/library/module:moduleinfo",
        "//closure/library/module:moduleloadcallback",
        "//closure/library/object",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)
