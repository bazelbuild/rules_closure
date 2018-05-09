# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":descriptor",
        ":fielddescriptor",
        ":lazydeserializer",
        ":message",
        ":objectserializer",
        ":pbliteserializer",
        ":serializer",
        ":textformatserializer",
        ":util",
    ],
)

closure_js_library(
    name = "descriptor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/descriptor.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "fielddescriptor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/fielddescriptor.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "lazydeserializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/lazydeserializer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/proto2:message",
        "//closure/library/proto2:serializer",
    ],
)

closure_js_library(
    name = "message",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/message.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/proto2:descriptor",
        "//closure/library/proto2:fielddescriptor",
    ],
)

closure_js_library(
    name = "objectserializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/objectserializer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/proto2:fielddescriptor",
        "//closure/library/proto2:serializer",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "pbliteserializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/pbliteserializer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/proto2:fielddescriptor",
        "//closure/library/proto2:lazydeserializer",
        "//closure/library/proto2:serializer",
    ],
)

closure_js_library(
    name = "serializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/serializer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/proto2:fielddescriptor",
        "//closure/library/proto2:message",
    ],
)

closure_js_library(
    name = "test.pb",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/test.pb.js"],
    lenient = True,
    deps = ["//closure/library/proto2:message"],
)

closure_js_library(
    name = "textformatserializer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/textformatserializer.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/math",
        "//closure/library/object",
        "//closure/library/proto2:fielddescriptor",
        "//closure/library/proto2:message",
        "//closure/library/proto2:serializer",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "util",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/proto2/util.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)
