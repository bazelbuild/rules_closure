# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":attributewhitelist",
        ":csspropertysanitizer",
        ":csssanitizer",
        ":elementweakmap",
        ":htmlsanitizer",
        ":noclobber",
        ":safedomtreeprocessor",
        ":tagblacklist",
        ":tagwhitelist",
        ":unsafe",
    ],
)

closure_js_library(
    name = "attributewhitelist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/attributewhitelist.js"],
    lenient = True,
)

closure_js_library(
    name = "csspropertysanitizer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/csspropertysanitizer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:safeurl",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "csssanitizer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/csssanitizer.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:cssspecificity",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/html/sanitizer:csspropertysanitizer",
        "//closure/library/html/sanitizer:noclobber",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:const",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "elementweakmap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/elementweakmap.js"],
    lenient = True,
    deps = ["//closure/library/html/sanitizer:noclobber"],
)

closure_js_library(
    name = "htmlsanitizer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/htmlsanitizer.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/html/sanitizer:attributewhitelist",
        "//closure/library/html/sanitizer:csssanitizer",
        "//closure/library/html/sanitizer:noclobber",
        "//closure/library/html/sanitizer:safedomtreeprocessor",
        "//closure/library/html/sanitizer:tagblacklist",
        "//closure/library/html/sanitizer:tagwhitelist",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "noclobber",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/noclobber.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:nodetype",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "safedomtreeprocessor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/safedomtreeprocessor.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/html/sanitizer:elementweakmap",
        "//closure/library/html/sanitizer:noclobber",
        "//closure/library/log",
        "//closure/library/string:const",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "tagblacklist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/tagblacklist.js"],
    lenient = True,
)

closure_js_library(
    name = "tagwhitelist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/tagwhitelist.js"],
    lenient = True,
)

closure_js_library(
    name = "unsafe",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/sanitizer/unsafe.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html/sanitizer:htmlsanitizer",
        "//closure/library/string",
        "//closure/library/string:const",
    ],
)
