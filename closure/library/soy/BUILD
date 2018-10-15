# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":data",
        ":renderer",
        ":soy",
    ],
)

closure_js_library(
    name = "data",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/soy/data.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:safehtml",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/i18n:bidi",
        "//closure/library/string:const",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "renderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/soy/renderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/soy",
        "//closure/library/soy:data",
    ],
)

closure_js_library(
    name = "soy",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/soy/soy.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:legacyconversions",
        "//closure/library/soy:data",
        "//closure/library/string",
    ],
)
