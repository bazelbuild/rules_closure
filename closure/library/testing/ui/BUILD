# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "rendererasserts",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/ui/rendererasserts.js"],
    lenient = True,
    deps = [
        "//closure/library/testing:asserts",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "rendererharness",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/ui/rendererharness.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom:nodetype",
        "//closure/library/testing:asserts",
        "//closure/library/testing:dom",
        "//closure/library/ui:control",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "style",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/ui/style.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/testing:asserts",
    ],
)
