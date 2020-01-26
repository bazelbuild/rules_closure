# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":cursor",
        ":db",
        ":error",
        ":index",
        ":indexeddb",
        ":keyrange",
        ":objectstore",
        ":transaction",
    ],
)

closure_js_library(
    name = "cursor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/cursor.js"],
    lenient = True,
    deps = [
        "//closure/library/db:error",
        "//closure/library/db:keyrange",
        "//closure/library/debug",
        "//closure/library/events:eventtarget",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "db",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/db.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/db:error",
        "//closure/library/db:indexeddb",
        "//closure/library/db:transaction",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "error",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/error.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:error",
    ],
)

closure_js_library(
    name = "index",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/index.js"],
    lenient = True,
    deps = [
        "//closure/library/db:cursor",
        "//closure/library/db:error",
        "//closure/library/db:keyrange",
        "//closure/library/debug",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "indexeddb",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/indexeddb.js"],
    lenient = True,
    deps = [
        "//closure/library/db:error",
        "//closure/library/db:objectstore",
        "//closure/library/db:transaction",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
    ],
)

closure_js_library(
    name = "keyrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/keyrange.js"],
    lenient = True,
)

closure_js_library(
    name = "objectstore",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/objectstore.js"],
    lenient = True,
    deps = [
        "//closure/library/db:cursor",
        "//closure/library/db:error",
        "//closure/library/db:index",
        "//closure/library/db:keyrange",
        "//closure/library/debug",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "transaction",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/db/transaction.js"],
    lenient = True,
    deps = [
        "//closure/library/db:error",
        "//closure/library/db:objectstore",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)
