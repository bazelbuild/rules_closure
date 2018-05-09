# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "mockmessagechannel",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/messaging/mockmessagechannel.js"],
    lenient = True,
    deps = [
        "//closure/library/messaging:abstractchannel",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "mockmessageevent",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/messaging/mockmessageevent.js"],
    lenient = True,
    deps = [
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtype",
        "//closure/library/testing/events",
    ],
)

closure_js_library(
    name = "mockmessageport",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/messaging/mockmessageport.js"],
    lenient = True,
    deps = ["//closure/library/events:eventtarget"],
)

closure_js_library(
    name = "mockportnetwork",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/messaging/mockportnetwork.js"],
    lenient = True,
    deps = [
        "//closure/library/messaging:portnetwork",
        "//closure/library/testing/messaging:mockmessagechannel",
    ],
)
