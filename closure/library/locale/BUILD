# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":countries",
        ":defaultlocalenameconstants",
        ":genericfontnames",
        ":genericfontnamesdata",
        ":locale",
        ":nativenameconstants",
        ":scriptToLanguages",
        ":timezonedetection",
        ":timezonefingerprint",
        ":timezonelist",
    ],
)

closure_js_library(
    name = "countries",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/countries.js"],
    lenient = True,
)

closure_js_library(
    name = "defaultlocalenameconstants",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/defaultlocalenameconstants.js"],
    lenient = True,
)

closure_js_library(
    name = "genericfontnames",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/genericfontnames.js"],
    lenient = True,
)

closure_js_library(
    name = "genericfontnamesdata",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/genericfontnamesdata.js"],
    lenient = True,
)

closure_js_library(
    name = "locale",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/locale.js"],
    lenient = True,
    deps = ["//closure/library/locale:nativenameconstants"],
)

closure_js_library(
    name = "nativenameconstants",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/nativenameconstants.js"],
    lenient = True,
)

closure_js_library(
    name = "scriptToLanguages",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/scriptToLanguages.js"],
    lenient = True,
    deps = ["//closure/library/locale"],
)

closure_js_library(
    name = "timezonedetection",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/timezonedetection.js"],
    lenient = True,
    deps = ["//closure/library/locale:timezonefingerprint"],
)

closure_js_library(
    name = "timezonefingerprint",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/timezonefingerprint.js"],
    lenient = True,
)

closure_js_library(
    name = "timezonelist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/locale/timezonelist.js"],
    lenient = True,
    deps = ["//closure/library/locale"],
)
