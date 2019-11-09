# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@rules_python//python:defs.bzl", "py_binary")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":adobereader",
        ":flash",
        ":iphoto",
        ":jscript",
        ":keyboard",
        ":platform",
        ":product",
        ":product_isversion",
        ":useragent",
    ],
)

closure_js_library(
    name = "adobereader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/adobereader.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "flash",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/flash.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "iphoto",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/iphoto.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "jscript",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/jscript.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "keyboard",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/keyboard.js"],
    lenient = True,
    deps = ["//closure/library/labs/useragent:platform"],
)

closure_js_library(
    name = "platform",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/platform.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "product",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/product.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:browser",
        "//closure/library/labs/useragent:platform",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "product_isversion",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/product_isversion.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:platform",
        "//closure/library/string",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "useragent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/useragent.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:browser",
        "//closure/library/labs/useragent:engine",
        "//closure/library/labs/useragent:platform",
        "//closure/library/labs/useragent:util",
        "//closure/library/reflect",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "useragenttestutil",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/useragent/useragenttestutil.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:browser",
        "//closure/library/labs/useragent:engine",
        "//closure/library/labs/useragent:platform",
        "//closure/library/object",
        "//closure/library/useragent",
        "//closure/library/useragent:keyboard",
        "//closure/library/useragent:platform",
        "//closure/library/useragent:product",
        "//closure/library/useragent:product_isversion",
    ],
)
