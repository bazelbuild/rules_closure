# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":emailaddress",
        ":format",
        ":htmlprettyprinter",
        ":internationalizedemailaddress",
        ":jsonprettyprinter",
    ],
)

closure_js_library(
    name = "emailaddress",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/format/emailaddress.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "format",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/format/format.js"],
    lenient = True,
    deps = [
        "//closure/library/i18n:graphemebreak",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "htmlprettyprinter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/format/htmlprettyprinter.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/string:stringbuffer",
    ],
)

closure_js_library(
    name = "internationalizedemailaddress",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/format/internationalizedemailaddress.js"],
    lenient = True,
    deps = [
        "//closure/library/format:emailaddress",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "jsonprettyprinter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/format/jsonprettyprinter.js"],
    lenient = True,
    deps = [
        "//closure/library/html:safehtml",
        "//closure/library/json",
        "//closure/library/string",
        "//closure/library/string:stringformat",
    ],
)
