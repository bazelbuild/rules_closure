# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":cssspecificity",
        ":flash",
        ":legacyconversions",
        ":safehtml",
        ":safehtmlformatter",
        ":safescript",
        ":safestyle",
        ":safestylesheet",
        ":safeurl",
        ":silverlight",
        ":textextractor",
        ":trustedresourceurl",
        ":trustedtypes",
        ":uncheckedconversions",
        ":utils",
        "//closure/library/html/sanitizer:all_js",
    ],
)

closure_js_library(
    name = "cssspecificity",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/cssspecificity.js"],
    lenient = True,
    deps = [
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "flash",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/flash.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:safehtml",
    ],
)

closure_js_library(
    name = "legacyconversions",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/legacyconversions.js"],
    lenient = True,
    deps = [
        "//closure/library/html:safehtml",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
    ],
)

closure_js_library(
    name = "safehtml",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safehtml.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:tagname",
        "//closure/library/dom:tags",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/html:trustedtypes",
        "//closure/library/i18n:bidi",
        "//closure/library/labs/useragent:browser",
        "//closure/library/object",
        "//closure/library/string:const",
        "//closure/library/string:internal",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "safehtmlformatter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safehtmlformatter.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:tags",
        "//closure/library/html:safehtml",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "safescript",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safescript.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:trustedtypes",
        "//closure/library/string:const",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "safestyle",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safestyle.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/html:safeurl",
        "//closure/library/string:const",
        "//closure/library/string:internal",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "safestylesheet",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safestylesheet.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/html:safestyle",
        "//closure/library/object",
        "//closure/library/string:const",
        "//closure/library/string:internal",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "safeurl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/safeurl.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/fs:url",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/html:trustedtypes",
        "//closure/library/i18n:bidi",
        "//closure/library/string:const",
        "//closure/library/string:internal",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "silverlight",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/silverlight.js"],
    lenient = True,
    deps = [
        "//closure/library/html:flash",
        "//closure/library/html:safehtml",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "testing",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/testing.js"],
    lenient = True,
    deps = [
        "//closure/library/html:safehtml",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/testing:mockmatchers",
    ],
)

closure_js_library(
    name = "textextractor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/textextractor.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom:tagname",
        "//closure/library/html/sanitizer:htmlsanitizer",
        "//closure/library/object",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "trustedresourceurl",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/trustedresourceurl.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:trustedtypes",
        "//closure/library/i18n:bidi",
        "//closure/library/string:const",
        "//closure/library/string:typedstring",
    ],
)

closure_js_library(
    name = "trustedtypes",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/trustedtypes.js"],
    lenient = True,
)

closure_js_library(
    name = "uncheckedconversions",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/uncheckedconversions.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/html:safehtml",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safestylesheet",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string:const",
        "//closure/library/string:internal",
    ],
)

closure_js_library(
    name = "utils",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/html/utils.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)
