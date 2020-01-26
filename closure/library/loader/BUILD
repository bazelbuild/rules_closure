# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractmodulemanager",
        ":activemodulemanager",
    ],
)

closure_js_library(
    name = "abstractmodulemanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/loader/abstractmodulemanager.js"],
    lenient = True,
    deps = [
        "//closure/library/module:abstractmoduleloader",
        "//closure/library/module:moduleinfo",
        "//closure/library/module:moduleloadcallback",
    ],
)

closure_js_library(
    name = "activemodulemanager",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/loader/activemodulemanager.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/loader:abstractmodulemanager",
    ],
)
