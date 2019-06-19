# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":datamanager",
        ":datasource",
        ":expr",
        ":fastdatanode",
        ":jsdatasource",
        ":jsondatasource",
        ":jsxmlhttpdatasource",
        ":xmldatasource",
    ],
)

closure_js_library(
    name = "datamanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/datamanager.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:expr",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/structs",
        "//closure/library/structs:map",
    ],
)

closure_js_library(
    name = "datasource",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/datasource.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "expr",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/expr.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "fastdatanode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/fastdatanode.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:datamanager",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "jsdatasource",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/jsdatasource.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:datamanager",
    ],
)

closure_js_library(
    name = "jsondatasource",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/jsondatasource.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:datamanager",
        "//closure/library/datasource:jsdatasource",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "jsxmlhttpdatasource",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/jsxmlhttpdatasource.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:datamanager",
        "//closure/library/datasource:fastdatanode",
        "//closure/library/events",
        "//closure/library/log",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "xmldatasource",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/datasource/xmldatasource.js"],
    lenient = True,
    deps = [
        "//closure/library/datasource",
        "//closure/library/datasource:datamanager",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:xml",
        "//closure/library/log",
        "//closure/library/net:xhrio",
        "//closure/library/string",
        "//closure/library/uri",
    ],
)
