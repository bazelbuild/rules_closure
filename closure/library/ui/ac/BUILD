# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":ac",
        ":arraymatcher",
        ":autocomplete",
        ":cachingmatcher",
        ":inputhandler",
        ":remote",
        ":remotearraymatcher",
        ":renderer",
        ":renderoptions",
        ":richinputhandler",
        ":richremote",
        ":richremotearraymatcher",
    ],
)

closure_js_library(
    name = "ac",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/ac.js"],
    lenient = True,
    deps = [
        "//closure/library/ui/ac:arraymatcher",
        "//closure/library/ui/ac:autocomplete",
        "//closure/library/ui/ac:inputhandler",
        "//closure/library/ui/ac:renderer",
    ],
)

closure_js_library(
    name = "arraymatcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/arraymatcher.js"],
    lenient = True,
    deps = ["//closure/library/string"],
)

closure_js_library(
    name = "autocomplete",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/autocomplete.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/object",
        "//closure/library/ui/ac:renderoptions",
    ],
)

closure_js_library(
    name = "cachingmatcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/cachingmatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/async:throttle",
        "//closure/library/ui/ac:arraymatcher",
        "//closure/library/ui/ac:renderoptions",
    ],
)

closure_js_library(
    name = "inputhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/inputhandler.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:selection",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/string",
        "//closure/library/timer",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "remote",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/remote.js"],
    lenient = True,
    deps = [
        "//closure/library/ui/ac:autocomplete",
        "//closure/library/ui/ac:inputhandler",
        "//closure/library/ui/ac:remotearraymatcher",
        "//closure/library/ui/ac:renderer",
    ],
)

closure_js_library(
    name = "remotearraymatcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/remotearraymatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events",
        "//closure/library/net:eventtype",
        "//closure/library/net:xhrio",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "renderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/renderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/fx:dom",
        "//closure/library/positioning",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:idgenerator",
        "//closure/library/ui/ac:autocomplete",
    ],
)

closure_js_library(
    name = "renderoptions",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/renderoptions.js"],
    lenient = True,
)

closure_js_library(
    name = "richinputhandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/richinputhandler.js"],
    lenient = True,
    deps = ["//closure/library/ui/ac:inputhandler"],
)

closure_js_library(
    name = "richremote",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/richremote.js"],
    lenient = True,
    deps = [
        "//closure/library/ui/ac:autocomplete",
        "//closure/library/ui/ac:remote",
        "//closure/library/ui/ac:renderer",
        "//closure/library/ui/ac:richinputhandler",
        "//closure/library/ui/ac:richremotearraymatcher",
    ],
)

closure_js_library(
    name = "richremotearraymatcher",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ac/richremotearraymatcher.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/ui/ac:remotearraymatcher",
    ],
)
