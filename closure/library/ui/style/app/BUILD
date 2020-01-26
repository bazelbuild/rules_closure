# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":buttonrenderer",
        ":menubuttonrenderer",
        ":primaryactionbuttonrenderer",
    ],
)

closure_js_library(
    name = "buttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/style/app/buttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:button",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:custombuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "menubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/style/app/menubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:menu",
        "//closure/library/ui:menurenderer",
        "//closure/library/ui/style/app:buttonrenderer",
    ],
)

closure_js_library(
    name = "primaryactionbuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/style/app/primaryactionbuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:button",
        "//closure/library/ui:registry",
        "//closure/library/ui/style/app:buttonrenderer",
    ],
)
