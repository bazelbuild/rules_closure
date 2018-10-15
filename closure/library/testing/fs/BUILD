# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "blob",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/blob.js"],
    lenient = True,
    deps = [
        "//closure/library/crypt",
        "//closure/library/crypt:base64",
    ],
)

closure_js_library(
    name = "entry",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/entry.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/fs:entry",
        "//closure/library/fs:entryimpl",
        "//closure/library/fs:error",
        "//closure/library/functions",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/testing/fs:file",
        "//closure/library/testing/fs:filewriter",
        "//closure/library/timer",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "file",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/file.js"],
    lenient = True,
    deps = ["//closure/library/testing/fs:blob"],
)

closure_js_library(
    name = "filereader",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/filereader.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/fs:error",
        "//closure/library/fs:filereader",
        "//closure/library/testing/fs:blob",
        "//closure/library/testing/fs:progressevent",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "filesystem",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/filesystem.js"],
    lenient = True,
    deps = [
        "//closure/library/fs:filesystem",
        "//closure/library/testing/fs:entry",
    ],
)

closure_js_library(
    name = "filewriter",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/filewriter.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/fs:error",
        "//closure/library/fs:filesaver",
        "//closure/library/string",
        "//closure/library/testing/fs:blob",
        "//closure/library/testing/fs:file",
        "//closure/library/testing/fs:progressevent",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "fs",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/fs.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/fs",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/testing/fs:blob",
        "//closure/library/testing/fs:filesystem",
        "//closure/library/timer",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "progressevent",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/fs/progressevent.js"],
    lenient = True,
    deps = ["//closure/library/events:event"],
)
