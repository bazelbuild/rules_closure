# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "dom",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/editor/dom.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagiterator",
        "//closure/library/iter",
        "//closure/library/string",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "fieldmock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/editor/fieldmock.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/editor:field",
        "//closure/library/testing:loosemock",
        "//closure/library/testing:mockmatchers",
    ],
)

closure_js_library(
    name = "testhelper",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/editor/testhelper.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:range",
        "//closure/library/editor:browserfeature",
        "//closure/library/editor:node",
        "//closure/library/editor/plugins:abstractbubbleplugin",
        "//closure/library/testing:dom",
    ],
)
