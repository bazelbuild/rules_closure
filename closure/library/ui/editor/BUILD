# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractdialog",
        ":bubble",
        ":defaulttoolbar",
        ":linkdialog",
        ":messages",
        ":tabpane",
        ":toolbarcontroller",
        ":toolbarfactory",
    ],
)

closure_js_library(
    name = "abstractdialog",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/abstractdialog.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events:eventtarget",
        "//closure/library/string",
        "//closure/library/ui:dialog",
        "//closure/library/ui:popupbase",
    ],
)

closure_js_library(
    name = "bubble",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/bubble.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/dom:viewportsizemonitor",
        "//closure/library/editor:style",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/functions",
        "//closure/library/log",
        "//closure/library/math:box",
        "//closure/library/object",
        "//closure/library/positioning",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:popupbase",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "defaulttoolbar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/defaulttoolbar.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/editor:command",
        "//closure/library/style",
        "//closure/library/ui/editor:messages",
        "//closure/library/ui/editor:toolbarfactory",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "linkdialog",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/linkdialog.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:focus",
        "//closure/library/editor:link",
        "//closure/library/editor:node",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:inputhandler",
        "//closure/library/html:safehtml",
        "//closure/library/html:safehtmlformatter",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:button",
        "//closure/library/ui:component",
        "//closure/library/ui:linkbuttonrenderer",
        "//closure/library/ui/editor:abstractdialog",
        "//closure/library/ui/editor:messages",
        "//closure/library/ui/editor:tabpane",
        "//closure/library/useragent",
        "//closure/library/window",
    ],
)

closure_js_library(
    name = "messages",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/messages.js"],
    lenient = True,
    deps = ["//closure/library/html:safehtmlformatter"],
)

closure_js_library(
    name = "tabpane",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/tabpane.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:tab",
        "//closure/library/ui:tabbar",
    ],
)

closure_js_library(
    name = "toolbarcontroller",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/toolbarcontroller.js"],
    lenient = True,
    deps = [
        "//closure/library/editor:field",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "toolbarfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/editor/toolbarfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:container",
        "//closure/library/ui:option",
        "//closure/library/ui:toolbar",
        "//closure/library/ui:toolbarbutton",
        "//closure/library/ui:toolbarcolormenubutton",
        "//closure/library/ui:toolbarmenubutton",
        "//closure/library/ui:toolbarrenderer",
        "//closure/library/ui:toolbarselect",
        "//closure/library/useragent",
    ],
)
