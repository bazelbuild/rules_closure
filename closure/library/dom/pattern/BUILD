# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractpattern",
        ":allchildren",
        ":childmatches",
        ":endtag",
        ":fulltag",
        ":matcher",
        ":nodetype",
        ":pattern",
        ":repeat",
        ":sequence",
        ":starttag",
        ":tag",
        ":text",
        "//closure/library/dom/pattern/callback:all_js",
    ],
)

closure_js_library(
    name = "abstractpattern",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/abstractpattern.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagiterator",
        "//closure/library/dom/pattern",
    ],
)

closure_js_library(
    name = "allchildren",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/allchildren.js"],
    lenient = True,
    deps = [
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
    ],
)

closure_js_library(
    name = "childmatches",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/childmatches.js"],
    lenient = True,
    deps = [
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:allchildren",
    ],
)

closure_js_library(
    name = "endtag",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/endtag.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagiterator",
        "//closure/library/dom/pattern:tag",
    ],
)

closure_js_library(
    name = "fulltag",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/fulltag.js"],
    lenient = True,
    deps = [
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:starttag",
        "//closure/library/dom/pattern:tag",
    ],
)

closure_js_library(
    name = "matcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/matcher.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagiterator",
        "//closure/library/dom/pattern",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "nodetype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/nodetype.js"],
    lenient = True,
    deps = [
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
    ],
)

closure_js_library(
    name = "pattern",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/pattern.js"],
    lenient = True,
)

closure_js_library(
    name = "repeat",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/repeat.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:nodetype",
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
    ],
)

closure_js_library(
    name = "sequence",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/sequence.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:nodetype",
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
    ],
)

closure_js_library(
    name = "starttag",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/starttag.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagiterator",
        "//closure/library/dom/pattern:tag",
    ],
)

closure_js_library(
    name = "tag",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/tag.js"],
    lenient = True,
    deps = [
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "text",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/pattern/text.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:nodetype",
        "//closure/library/dom/pattern",
        "//closure/library/dom/pattern:abstractpattern",
    ],
)
