# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":errorcode",
        ":errorhandlingmechanism",
        ":html5localstorage",
        ":html5sessionstorage",
        ":html5webstorage",
        ":ieuserdata",
        ":iterablemechanism",
        ":mechanism",
        ":mechanismfactory",
        ":prefixedmechanism",
    ],
)

closure_js_library(
    name = "errorcode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/errorcode.js"],
    lenient = True,
)

closure_js_library(
    name = "errorhandlingmechanism",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/errorhandlingmechanism.js"],
    lenient = True,
    deps = ["//closure/library/storage/mechanism"],
)

closure_js_library(
    name = "html5localstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/html5localstorage.js"],
    lenient = True,
    deps = ["//closure/library/storage/mechanism:html5webstorage"],
)

closure_js_library(
    name = "html5sessionstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/html5sessionstorage.js"],
    lenient = True,
    deps = ["//closure/library/storage/mechanism:html5webstorage"],
)

closure_js_library(
    name = "html5webstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/html5webstorage.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/iter",
        "//closure/library/storage/mechanism:errorcode",
        "//closure/library/storage/mechanism:iterablemechanism",
    ],
)

closure_js_library(
    name = "ieuserdata",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/ieuserdata.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/iter",
        "//closure/library/storage/mechanism:errorcode",
        "//closure/library/storage/mechanism:iterablemechanism",
        "//closure/library/structs:map",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "iterablemechanism",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/iterablemechanism.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/iter",
        "//closure/library/storage/mechanism",
    ],
)

closure_js_library(
    name = "iterablemechanismtester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/iterablemechanismtester.js"],
    lenient = True,
    deps = [
        "//closure/library/iter",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "mechanism",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanism.js"],
    lenient = True,
)

closure_js_library(
    name = "mechanismfactory",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanismfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/storage/mechanism:html5localstorage",
        "//closure/library/storage/mechanism:html5sessionstorage",
        "//closure/library/storage/mechanism:ieuserdata",
        "//closure/library/storage/mechanism:prefixedmechanism",
    ],
)

closure_js_library(
    name = "mechanismseparationtester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanismseparationtester.js"],
    lenient = True,
    deps = [
        "//closure/library/iter",
        "//closure/library/storage/mechanism:mechanismtestdefinition",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "mechanismsharingtester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanismsharingtester.js"],
    lenient = True,
    deps = [
        "//closure/library/iter",
        "//closure/library/storage/mechanism:mechanismtestdefinition",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "mechanismtestdefinition",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanismtestdefinition.js"],
    lenient = True,
)

closure_js_library(
    name = "mechanismtester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/mechanismtester.js"],
    lenient = True,
    deps = [
        "//closure/library/storage/mechanism:errorcode",
        "//closure/library/testing:asserts",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
        "//closure/library/useragent:product_isversion",
    ],
)

closure_js_library(
    name = "prefixedmechanism",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/mechanism/prefixedmechanism.js"],
    lenient = True,
    deps = [
        "//closure/library/iter",
        "//closure/library/storage/mechanism:iterablemechanism",
    ],
)
