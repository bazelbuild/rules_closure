# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":bidi",
        ":bidiformatter",
        ":charlistdecompressor",
        ":charpickerdata",
        ":collation",
        ":compactnumberformatsymbols",
        ":compactnumberformatsymbolsext",
        ":currency",
        ":currencycodemap",
        ":dateintervalformat",
        ":dateintervalpatterns",
        ":dateintervalpatternsext",
        ":dateintervalsymbols",
        ":dateintervalsymbolsext",
        ":datetimeformat",
        ":datetimeparse",
        ":datetimepatterns",
        ":datetimepatternsext",
        ":datetimesymbols",
        ":datetimesymbolsext",
        ":graphemebreak",
        ":localefeature",
        ":messageformat",
        ":mime",
        ":numberformat",
        ":numberformatsymbols",
        ":numberformatsymbolsext",
        ":ordinalrules",
        ":pluralrules",
        ":relativedatetimeformat",
        ":relativedatetimesymbols",
        ":relativedatetimesymbolsext",
        ":timezone",
        ":uchar",
        ":ucharnames",
        "//closure/library/i18n/uchar:all_js",
    ],
)

closure_js_library(
    name = "bidi",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/bidi.js"],
    lenient = True,
)

closure_js_library(
    name = "bidiformatter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/bidiformatter.js"],
    lenient = True,
    deps = [
        "//closure/library/html:safehtml",
        "//closure/library/i18n:bidi",
    ],
)

closure_js_library(
    name = "charlistdecompressor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/charlistdecompressor.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/i18n:uchar",
    ],
)

closure_js_library(
    name = "charpickerdata",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/charpickerdata.js"],
    lenient = True,
)

closure_js_library(
    name = "collation",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/collation.js"],
    lenient = True,
)

closure_js_library(
    name = "compactnumberformatsymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/compactnumberformatsymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "compactnumberformatsymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/compactnumberformatsymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:compactnumberformatsymbols"],
)

closure_js_library(
    name = "currency",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/currency.js"],
    lenient = True,
)

closure_js_library(
    name = "currencycodemap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/currencycodemap.js"],
    lenient = True,
)

closure_js_library(
    name = "dateintervalformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/dateintervalformat.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/date",
        "//closure/library/date:datelike",
        "//closure/library/date:daterange",
        "//closure/library/i18n:dateintervalsymbols",
        "//closure/library/i18n:datetimeformat",
        "//closure/library/i18n:datetimesymbols",
        "//closure/library/i18n:timezone",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "dateintervalpatterns",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/dateintervalpatterns.js"],
    lenient = True,
    deps = ["//closure/library/i18n:dateintervalsymbols"],
)

closure_js_library(
    name = "dateintervalpatternsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/dateintervalpatternsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:dateintervalpatterns"],
)

closure_js_library(
    name = "dateintervalsymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/dateintervalsymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "dateintervalsymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/dateintervalsymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:dateintervalsymbols"],
)

closure_js_library(
    name = "datetimeformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimeformat.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/date",
        "//closure/library/i18n:datetimesymbols",
        "//closure/library/i18n:timezone",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "datetimeparse",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimeparse.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/date",
        "//closure/library/i18n:datetimeformat",
        "//closure/library/i18n:datetimesymbols",
    ],
)

closure_js_library(
    name = "datetimepatterns",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimepatterns.js"],
    lenient = True,
)

closure_js_library(
    name = "datetimepatternsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimepatternsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:datetimepatterns"],
)

closure_js_library(
    name = "datetimesymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimesymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "datetimesymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/datetimesymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:datetimesymbols"],
)

closure_js_library(
    name = "graphemebreak",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/graphemebreak.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/i18n:uchar",
        "//closure/library/structs:inversionmap",
    ],
)

closure_js_library(
    name = "localefeature",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/localefeature.js"],
    lenient = True,
)

closure_js_library(
    name = "messageformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/messageformat.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/i18n:compactnumberformatsymbols",
        "//closure/library/i18n:numberformat",
        "//closure/library/i18n:numberformatsymbols",
        "//closure/library/i18n:ordinalrules",
        "//closure/library/i18n:pluralrules",
    ],
)

closure_js_library(
    name = "mime",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/mime.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/i18n:uchar",
    ],
)

closure_js_library(
    name = "numberformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/numberformat.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/i18n:compactnumberformatsymbols",
        "//closure/library/i18n:currency",
        "//closure/library/i18n:numberformatsymbols",
        "//closure/library/math",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "numberformatsymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/numberformatsymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "numberformatsymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/numberformatsymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:numberformatsymbols"],
)

closure_js_library(
    name = "ordinalrules",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/ordinalrules.js"],
    lenient = True,
)

closure_js_library(
    name = "pluralrules",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/pluralrules.js"],
    lenient = True,
)

closure_js_library(
    name = "relativedatetimeformat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/relativedatetimeformat.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/i18n:messageformat",
        "//closure/library/i18n:relativedatetimesymbols",
    ],
)

closure_js_library(
    name = "relativedatetimesymbols",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/relativedatetimesymbols.js"],
    lenient = True,
)

closure_js_library(
    name = "relativedatetimesymbolsext",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/relativedatetimesymbolsext.js"],
    lenient = True,
    deps = ["//closure/library/i18n:relativedatetimesymbols"],
)

closure_js_library(
    name = "timezone",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/timezone.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/date:datelike",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "uchar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/uchar.js"],
    lenient = True,
)

closure_js_library(
    name = "ucharnames",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/i18n/ucharnames.js"],
    lenient = True,
    deps = ["//closure/library/i18n:uchar"],
)
