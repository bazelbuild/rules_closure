# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [":jstdasyncwrapper"],
)

closure_js_library(
    name = "assertionfailure",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/assertionfailure.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "asserts",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/asserts.js"],
    lenient = True,
    deps = ["//closure/library/testing:jsunitexception"],
)

closure_js_library(
    name = "asynctestcase",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/asynctestcase.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/testing:asserts",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "benchmark",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/benchmark.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/testing:performancetable",
        "//closure/library/testing:performancetimer",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "continuationtestcase",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/continuationtestcase.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/testing:asserts",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "deferredtestcase",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/deferredtestcase.js"],
    lenient = True,
    deps = [
        "//closure/library/testing:asynctestcase",
        "//closure/library/testing:testcase",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "dom",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/dom.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:nodeiterator",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagiterator",
        "//closure/library/dom:tagname",
        "//closure/library/iter",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/testing:asserts",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "expectedfailures",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/expectedfailures.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/debug:divconsole",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/log",
        "//closure/library/style",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunitexception",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "functionmock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/functionmock.js"],
    lenient = True,
    deps = [
        "//closure/library/object",
        "//closure/library/testing:loosemock",
        "//closure/library/testing:mock",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/testing:strictmock",
    ],
)

closure_js_library(
    name = "graphics",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/graphics.js"],
    lenient = True,
    deps = [
        "//closure/library/graphics:path",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "jstdasyncwrapper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/jstdasyncwrapper.js"],
    lenient = True,
    deps = ["//closure/library/promise"],
)

closure_js_library(
    name = "jstdtestcaseadapter",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/jstdtestcaseadapter.js"],
    lenient = True,
    deps = [
        "//closure/library/async:run",
        "//closure/library/functions",
        "//closure/library/testing:jstdasyncwrapper",
        "//closure/library/testing:jsunit",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "jsunit",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/jsunit.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/testing:testcase",
        "//closure/library/testing:testrunner",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "jsunitexception",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/jsunitexception.js"],
    lenient = True,
    deps = ["//closure/library/testing:stacktrace"],
)

closure_js_library(
    name = "loosemock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/loosemock.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/structs:map",
        "//closure/library/structs:set",
        "//closure/library/testing:mock",
    ],
)

closure_js_library(
    name = "mock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mock.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/object",
        "//closure/library/promise",
        "//closure/library/promise:resolver",
        "//closure/library/testing:jsunitexception",
        "//closure/library/testing:mockinterface",
        "//closure/library/testing:mockmatchers",
    ],
)

closure_js_library(
    name = "mockclassfactory",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockclassfactory.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/object",
        "//closure/library/testing:loosemock",
        "//closure/library/testing:mockmatchers",
        "//closure/library/testing:strictmock",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "mockclock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockclock.js"],
    lenient = True,
    deps = [
        "//closure/library/async:run",
        "//closure/library/disposable",
        "//closure/library/promise",
        "//closure/library/promise:thenable",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/testing/events",
    ],
)

closure_js_library(
    name = "mockcontrol",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockcontrol.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/promise",
        "//closure/library/testing:functionmock",
        "//closure/library/testing:loosemock",
        "//closure/library/testing:strictmock",
    ],
)

closure_js_library(
    name = "mockinterface",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockinterface.js"],
    lenient = True,
    deps = ["//closure/library/promise"],
)

closure_js_library(
    name = "mockmatchers",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockmatchers.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "mockrandom",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockrandom.js"],
    lenient = True,
    deps = ["//closure/library/disposable"],
)

closure_js_library(
    name = "mockrange",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockrange.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:abstractrange",
        "//closure/library/testing:loosemock",
    ],
)

closure_js_library(
    name = "mockstorage",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockstorage.js"],
    lenient = True,
    deps = ["//closure/library/structs:map"],
)

closure_js_library(
    name = "mockuseragent",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/mockuseragent.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/labs/useragent:util",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "multitestrunner",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/multitestrunner.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/functions",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/testing:testcase",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:serverchart",
        "//closure/library/ui:tablesorter",
    ],
)

closure_js_library(
    name = "objectpropertystring",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/objectpropertystring.js"],
    lenient = True,
)

closure_js_library(
    name = "performancetable",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/performancetable.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/testing:performancetimer",
    ],
)

closure_js_library(
    name = "performancetimer",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/performancetimer.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/math",
        "//third_party/closure/library/mochikit/async:deferred",
    ],
)

closure_js_library(
    name = "propertyreplacer",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/propertyreplacer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "pseudorandom",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/pseudorandom.js"],
    lenient = True,
    deps = ["//closure/library/disposable"],
)

closure_js_library(
    name = "recordfunction",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/recordfunction.js"],
    lenient = True,
    deps = [
        "//closure/library/promise",
        "//closure/library/promise:resolver",
        "//closure/library/testing:asserts",
    ],
)

closure_js_library(
    name = "shardingtestcase",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/shardingtestcase.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/testing:testcase",
    ],
)

closure_js_library(
    name = "singleton",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/singleton.js"],
    lenient = True,
)

closure_js_library(
    name = "stacktrace",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/stacktrace.js"],
    lenient = True,
)

closure_js_library(
    name = "strictmock",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/strictmock.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/structs:set",
        "//closure/library/testing:mock",
    ],
)

closure_js_library(
    name = "testcase",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/testcase.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/promise",
        "//closure/library/promise:thenable",
        "//closure/library/testing:asserts",
        "//closure/library/testing:jsunitexception",
    ],
)

closure_js_library(
    name = "testqueue",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/testqueue.js"],
    lenient = True,
)

closure_js_library(
    name = "testrunner",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/testrunner.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/json",
        "//closure/library/testing:testcase",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "testsuite",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/testing/testsuite.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/testing:environment",
        "//closure/library/testing:testcase",
    ],
)
