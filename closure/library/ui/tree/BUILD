# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":basenode",
        ":treecontrol",
        ":treenode",
        ":typeahead",
    ],
)

closure_js_library(
    name = "basenode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tree/basenode.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/asserts",
        "//closure/library/dom:safe",
        "//closure/library/events:event",
        "//closure/library/events:keycodes",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestyle",
        "//closure/library/string",
        "//closure/library/string:stringbuffer",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "treecontrol",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tree/treecontrol.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/events:eventtype",
        "//closure/library/events:focushandler",
        "//closure/library/events:keyhandler",
        "//closure/library/html:safehtml",
        "//closure/library/log",
        "//closure/library/ui/tree:basenode",
        "//closure/library/ui/tree:treenode",
        "//closure/library/ui/tree:typeahead",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "treenode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tree/treenode.js"],
    lenient = True,
    deps = ["//closure/library/ui/tree:basenode"],
)

closure_js_library(
    name = "typeahead",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tree/typeahead.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events:keycodes",
        "//closure/library/string",
        "//closure/library/structs:trie",
    ],
)
