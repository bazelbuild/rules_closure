# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":date",
        ":datelike",
        ":daterange",
        ":duration",
        ":relative",
        ":relativewithplurals",
        ":utcdatetime",
    ],
)

closure_js_library(
    name = "date",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/date.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/date:datelike",
        "//closure/library/i18n:datetimesymbols",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "datelike",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/datelike.js"],
    lenient = True,
)

closure_js_library(
    name = "daterange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/daterange.js"],
    lenient = True,
    deps = [
        "//closure/library/date",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "duration",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/duration.js"],
    lenient = True,
    deps = [
        "//closure/library/i18n:datetimeformat",
        "//closure/library/i18n:messageformat",
    ],
)

closure_js_library(
    name = "relative",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/relative.js"],
    lenient = True,
    deps = [
        "//closure/library/i18n:datetimeformat",
        "//closure/library/i18n:datetimepatterns",
    ],
)

closure_js_library(
    name = "relativewithplurals",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/relativewithplurals.js"],
    lenient = True,
    deps = [
        "//closure/library/date:relative",
        "//closure/library/i18n:messageformat",
    ],
)

closure_js_library(
    name = "utcdatetime",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/date/utcdatetime.js"],
    lenient = True,
    deps = ["//closure/library/date"],
)
