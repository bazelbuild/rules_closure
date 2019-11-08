# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractbubbleplugin",
        ":abstractdialogplugin",
        ":abstracttabhandler",
        ":basictextformatter",
        ":blockquote",
        ":emoticons",
        ":enterhandler",
        ":firststrong",
        ":headerformatter",
        ":linkbubble",
        ":linkdialogplugin",
        ":linkshortcutplugin",
        ":listtabhandler",
        ":loremipsum",
        ":removeformatting",
        ":spacestabhandler",
        ":tableeditor",
        ":tagonenterhandler",
        ":undoredo",
        ":undoredomanager",
        ":undoredostate",
    ],
)

closure_js_library(
    name = "abstractbubbleplugin",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/abstractbubbleplugin.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:plugin",
        "//closure/library/editor:style",
        "//closure/library/events",
        "//closure/library/events:actioneventwrapper",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/functions",
        "//closure/library/string",
        "//closure/library/ui:component",
        "//closure/library/ui/editor:bubble",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "abstractdialogplugin",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/abstractdialogplugin.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/editor:field",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/events",
        "//closure/library/ui/editor:abstractdialog",
    ],
)

closure_js_library(
    name = "abstracttabhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/abstracttabhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:plugin",
        "//closure/library/events:keycodes",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "basictextformatter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/basictextformatter.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:link",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/editor:style",
        "//closure/library/iter",
        "//closure/library/log",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui/editor:messages",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "blockquote",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/blockquote.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/functions",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "emoticons",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/emoticons.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/functions",
        "//closure/library/ui/emoji",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "enterhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/enterhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodeoffset",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/editor:style",
        "//closure/library/editor/plugins:blockquote",
        "//closure/library/events:keycodes",
        "//closure/library/functions",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "firststrong",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/firststrong.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagiterator",
        "//closure/library/dom:tagname",
        "//closure/library/editor:command",
        "//closure/library/editor:field",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/i18n:bidi",
        "//closure/library/i18n:uchar",
        "//closure/library/iter",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "headerformatter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/headerformatter.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:command",
        "//closure/library/editor:plugin",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "linkbubble",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/linkbubble.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:command",
        "//closure/library/editor:link",
        "//closure/library/editor/plugins:abstractbubbleplugin",
        "//closure/library/functions",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui/editor:messages",
        "//closure/library/uri:utils",
        "//closure/library/window",
    ],
)

closure_js_library(
    name = "linkdialogplugin",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/linkdialogplugin.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/editor:command",
        "//closure/library/editor/plugins:abstractdialogplugin",
        "//closure/library/events:eventhandler",
        "//closure/library/functions",
        "//closure/library/ui/editor:abstractdialog",
        "//closure/library/ui/editor:linkdialog",
        "//closure/library/uri:utils",
    ],
)

closure_js_library(
    name = "linkshortcutplugin",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/linkshortcutplugin.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:command",
        "//closure/library/editor:plugin",
    ],
)

closure_js_library(
    name = "listtabhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/listtabhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/editor:command",
        "//closure/library/editor/plugins:abstracttabhandler",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "loremipsum",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/loremipsum.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/editor:command",
        "//closure/library/editor:field",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "removeformatting",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/removeformatting.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "spacestabhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/spacestabhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/editor:range",
        "//closure/library/editor/plugins:abstracttabhandler",
    ],
)

closure_js_library(
    name = "tableeditor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/tableeditor.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor:range",
        "//closure/library/editor:table",
        "//closure/library/object",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "tagonenterhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/tagonenterhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/dom:tagname",
        "//closure/library/editor:command",
        "//closure/library/editor:node",
        "//closure/library/editor:range",
        "//closure/library/editor:style",
        "//closure/library/editor/plugins:enterhandler",
        "//closure/library/events:keycodes",
        "//closure/library/functions",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "undoredo",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/undoredo.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodeoffset",
        "//closure/library/dom:range",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:command",
        "//closure/library/editor:field",
        "//closure/library/editor:node",
        "//closure/library/editor:plugin",
        "//closure/library/editor/plugins:undoredomanager",
        "//closure/library/editor/plugins:undoredostate",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/log",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "undoredomanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/undoredomanager.js"],
    lenient = True,
    deps = [
        "//closure/library/editor/plugins:undoredostate",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
    ],
)

closure_js_library(
    name = "undoredostate",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/editor/plugins/undoredostate.js"],
    lenient = True,
    deps = ["//closure/library/events:eventtarget"],
)
