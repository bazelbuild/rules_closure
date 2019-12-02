# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":entries",
        ":registry",
        ":tweak",
        ":tweakui",
    ],
)

closure_js_library(
    name = "entries",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/tweak/entries.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/log",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "registry",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/tweak/registry.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/log",
        "//closure/library/string",
        "//closure/library/tweak:entries",
        "//closure/library/uri:utils",
    ],
)

closure_js_library(
    name = "testhelpers",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/tweak/testhelpers.js"],
    lenient = True,
    deps = [
        "//closure/library/tweak",
        "//closure/library/tweak:entries",
        "//closure/library/tweak:registry",
    ],
)

closure_js_library(
    name = "tweak",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/tweak/tweak.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/tweak:entries",
        "//closure/library/tweak:registry",
    ],
)

closure_js_library(
    name = "tweakui",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/tweak/tweakui.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestylesheet",
        "//closure/library/object",
        "//closure/library/string:const",
        "//closure/library/style",
        "//closure/library/tweak",
        "//closure/library/tweak:entries",
        "//closure/library/ui:zippy",
        "//closure/library/useragent",
    ],
)
