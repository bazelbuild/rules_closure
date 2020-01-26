# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":defines",
        ":full",
        ":full_impl",
        ":full_native_impl",
        ":full_types",
        ":lite",
        ":lite_impl",
        ":lite_native_impl",
        ":lite_types",
    ],
)

closure_js_library(
    name = "defines",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/defines.js"],
    lenient = True,
)

closure_js_library(
    name = "full",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/full.js"],
    lenient = True,
    deps = [
        "//closure/library/streams:defines",
        "//closure/library/streams:full_impl",
        "//closure/library/streams:full_native_impl",
        "//closure/library/streams:full_types",
    ],
)

closure_js_library(
    name = "full_impl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/full_impl.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/promise:nativeresolver",
        "//closure/library/streams:full_types",
        "//closure/library/streams:lite_impl",
    ],
)

closure_js_library(
    name = "full_native_impl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/full_native_impl.js"],
    lenient = True,
    deps = [
        "//closure/library/streams:full_types",
        "//closure/library/streams:lite_native_impl",
    ],
)

closure_js_library(
    name = "full_types",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/full_types.js"],
    lenient = True,
    deps = ["//closure/library/streams:lite_types"],
)

closure_js_library(
    name = "lite",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/lite.js"],
    lenient = True,
    deps = [
        "//closure/library/streams:defines",
        "//closure/library/streams:lite_impl",
        "//closure/library/streams:lite_native_impl",
        "//closure/library/streams:lite_types",
    ],
)

closure_js_library(
    name = "lite_impl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/lite_impl.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/promise:nativeresolver",
        "//closure/library/streams:lite_types",
    ],
)

closure_js_library(
    name = "lite_native_impl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/lite_native_impl.js"],
    lenient = True,
    deps = ["//closure/library/streams:lite_types"],
)

closure_js_library(
    name = "lite_types",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/streams/lite_types.js"],
    lenient = True,
)
