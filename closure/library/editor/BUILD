# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":browserfeature",
        ":clicktoeditwrapper",
        ":command",
        ":contenteditablefield",
        ":defines",
        ":field",
        ":focus",
        ":icontent",
        ":link",
        ":node",
        ":plugin",
        ":plugin_impl",
        ":range",
        ":seamlessfield",
        ":style",
        ":table",
        "//closure/library/editor/plugins:all_js",
    ],
)

closure_js_library(
    name = "browserfeature",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/browserfeature.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:defines",
        "//closure/library/labs/useragent:browser",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
        "//closure/library/useragent:product_isversion",
    ],
)

closure_js_library(
    name = "clicktoeditwrapper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/clicktoeditwrapper.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:field",
        "//closure/library/editor:range",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
    ],
)

closure_js_library(
    name = "command",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/command.js"],
    lenient = True,
)

closure_js_library(
    name = "contenteditablefield",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/contenteditablefield.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/editor:field",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "defines",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/defines.js"],
    lenient = True,
)

closure_js_library(
    name = "field",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/field.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/async:delay",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:range",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:icontent",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin_impl",
        "//closure/library/editor:range",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestylesheet",
        "//closure/library/log",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "focus",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/focus.js"],
    lenient = True,
    deps = ["//closure/library/dom:selection"],
)

closure_js_library(
    name = "icontent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/icontent.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/editor:browserfeature",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "link",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/link.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:field",
        "//closure/library/editor:node",
        "//closure/library/editor:range",
        "//closure/library/string",
        "//closure/library/uri:utils",
    ],
)

closure_js_library(
    name = "node",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/node.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:iter",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/iter",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "plugin",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugin.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:field",
        "//closure/library/editor:plugin_impl",
    ],
)

closure_js_library(
    name = "plugin_impl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugin_impl.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/functions",
        "//closure/library/log",
        "//closure/library/object",
        "//closure/library/reflect",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "range",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/range.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:rangeendpoint",
        "//closure/library/dom:savedcaretrange",
        "//closure/library/editor:node",
        "//closure/library/editor:style",
        "//closure/library/iter",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "seamlessfield",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/seamlessfield.js"],
    lenient = True,
    deps = [
        "//closure/library/cssom/iframe:style",
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:field",
        "//closure/library/editor:icontent",
        "//closure/library/editor:node",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/html:safehtml",
        "//closure/library/log",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "style",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/style.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/object",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "table",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/table.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/log",
        "//closure/library/string",
        "//closure/library/style",
    ],
)
