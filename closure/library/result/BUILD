# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":deferredadaptor",
        ":dependentresult",
        ":result_interface",
        ":resultutil",
        ":simpleresult",
    ],
)

closure_js_library(
    name = "deferredadaptor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/result/deferredadaptor.js"],
    lenient = True,
    deps = [
        "//closure/library/result:result_interface",
        "//closure/library/result:resultutil",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "dependentresult",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/result/dependentresult.js"],
    lenient = True,
    deps = ["//closure/library/result:result_interface"],
)

closure_js_library(
    name = "result_interface",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/result/result_interface.js"],
    lenient = True,
    deps = ["//closure/library/promise:thenable"],
)

closure_js_library(
    name = "resultutil",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/result/resultutil.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/result:dependentresult",
        "//closure/library/result:result_interface",
        "//closure/library/result:simpleresult",
    ],
)

closure_js_library(
    name = "simpleresult",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/result/simpleresult.js"],
    lenient = True,
    deps = [
        "//closure/library/debug:error",
        "//closure/library/promise",
        "//closure/library/promise:thenable",
        "//closure/library/result:result_interface",
    ],
)
