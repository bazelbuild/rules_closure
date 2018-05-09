# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":browser",
        ":device",
        ":engine",
        ":platform",
        ":util",
        ":verifier",
    ],
)

closure_js_library(
    name = "browser",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/browser.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/labs/useragent:util",
        "//closure/library/object",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "device",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/device.js"],
    lenient = True,
    deps = ["//closure/library/labs/useragent:util"],
)

closure_js_library(
    name = "engine",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/engine.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/labs/useragent:util",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "platform",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/platform.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:util",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "test_agents",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/test_agents.js"],
    lenient = True,
)

closure_js_library(
    name = "util",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/util.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "verifier",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/labs/useragent/verifier.js"],
    lenient = True,
)
