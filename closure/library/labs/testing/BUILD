# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "assertthat",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/assertthat.js"],
    lenient = True,
    deps = ["//closure/library/debug:error"],
)

closure_js_library(
    name = "decoratormatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/decoratormatcher.js"],
    lenient = True,
    deps = ["//closure/library/labs/testing:matcher"],
)

closure_js_library(
    name = "dictionarymatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/dictionarymatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/labs/testing:matcher",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "environment",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/environment.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/debug:console",
        "//closure/library/promise:thenable",
        "//closure/library/testing:jsunit",
        "//closure/library/testing:mockclock",
        "//closure/library/testing:mockcontrol",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "json_fuzzing",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/json_fuzzing.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/testing:pseudorandom",
    ],
)

closure_js_library(
    name = "logicmatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/logicmatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/labs/testing:matcher",
    ],
)

closure_js_library(
    name = "matcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/matcher.js"],
    lenient = True,
)

closure_js_library(
    name = "numbermatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/numbermatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/labs/testing:matcher",
    ],
)

closure_js_library(
    name = "objectmatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/objectmatcher.js"],
    lenient = True,
    deps = ["//closure/library/labs/testing:matcher"],
)

closure_js_library(
    name = "stringmatcher",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/testing/stringmatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/labs/testing:matcher",
        "//closure/library/string",
    ],
)
