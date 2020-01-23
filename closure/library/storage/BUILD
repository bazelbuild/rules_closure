# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":collectablestorage",
        ":encryptedstorage",
        ":errorcode",
        ":expiringstorage",
        ":richstorage",
        ":storage",
        "//closure/library/storage/mechanism:all_js",
    ],
)

closure_js_library(
    name = "collectablestorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/collectablestorage.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/iter",
        "//closure/library/storage:errorcode",
        "//closure/library/storage:expiringstorage",
        "//closure/library/storage:richstorage",
    ],
)

closure_js_library(
    name = "collectablestoragetester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/collectablestoragetester.js"],
    lenient = True,
    deps = ["//closure/library/testing:asserts"],
)

closure_js_library(
    name = "encryptedstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/encryptedstorage.js"],
    lenient = True,
    deps = [
        "//closure/library/crypt",
        "//closure/library/crypt:arc4",
        "//closure/library/crypt:base64",
        "//closure/library/crypt:sha1",
        "//closure/library/json",
        "//closure/library/storage:collectablestorage",
        "//closure/library/storage:errorcode",
        "//closure/library/storage:richstorage",
    ],
)

closure_js_library(
    name = "errorcode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/errorcode.js"],
    lenient = True,
)

closure_js_library(
    name = "expiringstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/expiringstorage.js"],
    lenient = True,
    deps = ["//closure/library/storage:richstorage"],
)

closure_js_library(
    name = "richstorage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/richstorage.js"],
    lenient = True,
    deps = [
        "//closure/library/storage",
        "//closure/library/storage:errorcode",
    ],
)

closure_js_library(
    name = "storage",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/storage.js"],
    lenient = True,
    deps = [
        "//closure/library/json",
        "//closure/library/storage:errorcode",
    ],
)

closure_js_library(
    name = "storagetester",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/storage/storagetester.js"],
    lenient = True,
    deps = [
        "//closure/library/storage",
        "//closure/library/structs:map",
        "//closure/library/testing:asserts",
    ],
)
