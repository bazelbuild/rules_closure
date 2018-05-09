# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":entry",
        ":entryimpl",
        ":error",
        ":filereader",
        ":filesaver",
        ":filesystem",
        ":filesystemimpl",
        ":filewriter",
        ":fs",
        ":progressevent",
        ":url",
    ],
)

closure_js_library(
    name = "entry",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/entry.js"],
    lenient = True,
)

closure_js_library(
    name = "entryimpl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/entryimpl.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/fs:entry",
        "//closure/library/fs:error",
        "//closure/library/fs:filewriter",
        "//closure/library/functions",
        "//closure/library/string",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "error",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/error.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:error",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "filereader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/filereader.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/fs:error",
        "//closure/library/fs:progressevent",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "filesaver",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/filesaver.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/fs:error",
        "//closure/library/fs:progressevent",
    ],
)

closure_js_library(
    name = "filesystem",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/filesystem.js"],
    lenient = True,
)

closure_js_library(
    name = "filesystemimpl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/filesystemimpl.js"],
    lenient = True,
    deps = [
        "//closure/library/fs:entryimpl",
        "//closure/library/fs:filesystem",
    ],
)

closure_js_library(
    name = "filewriter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/filewriter.js"],
    lenient = True,
    deps = [
        "//closure/library/fs:error",
        "//closure/library/fs:filesaver",
    ],
)

closure_js_library(
    name = "fs",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/fs.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/fs:error",
        "//closure/library/fs:filereader",
        "//closure/library/fs:filesystemimpl",
        "//closure/library/fs:url",
        "//closure/library/useragent",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "progressevent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/progressevent.js"],
    lenient = True,
    deps = ["//closure/library/events:event"],
)

closure_js_library(
    name = "url",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/fs/url.js"],
    lenient = True,
)
