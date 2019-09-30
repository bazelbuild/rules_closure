# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_css_library")
load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "library",
    exports = [
        "//closure/library/a11y/aria:all_js",
        "//closure/library/array:all_js",
        "//closure/library/asserts:all_js",
        "//closure/library/async:all_js",
        "//closure/library/collections:all_js",
        "//closure/library/color:all_js",
        "//closure/library/crypt:all_js",
        "//closure/library/cssom:all_js",
        "//closure/library/datasource:all_js",
        "//closure/library/date:all_js",
        "//closure/library/db:all_js",
        "//closure/library/debug:all_js",
        "//closure/library/delegate:all_js",
        "//closure/library/disposable:all_js",
        "//closure/library/dom:all_js",
        "//closure/library/editor:all_js",
        "//closure/library/events:all_js",
        "//closure/library/format:all_js",
        "//closure/library/fs:all_js",
        "//closure/library/functions:all_js",
        "//closure/library/fx:all_js",
        "//closure/library/graphics:all_js",
        "//closure/library/history:all_js",
        "//closure/library/html:all_js",
        "//closure/library/i18n:all_js",
        "//closure/library/iter:all_js",
        "//closure/library/json:all_js",
        "//closure/library/loader:all_js",
        "//closure/library/locale:all_js",
        "//closure/library/log:all_js",
        "//closure/library/math:all_js",
        "//closure/library/memoize:all_js",
        "//closure/library/messaging:all_js",
        "//closure/library/module:all_js",
        "//closure/library/net:all_js",
        "//closure/library/object:all_js",
        "//closure/library/positioning:all_js",
        "//closure/library/promise:all_js",
        "//closure/library/proto:all_js",
        "//closure/library/proto2:all_js",
        "//closure/library/pubsub:all_js",
        "//closure/library/reflect:all_js",
        "//closure/library/result:all_js",
        "//closure/library/soy:all_js",
        "//closure/library/spell:all_js",
        "//closure/library/stats:all_js",
        "//closure/library/storage:all_js",
        "//closure/library/streams:all_js",
        "//closure/library/string:all_js",
        "//closure/library/structs:all_js",
        "//closure/library/style:all_js",
        "//closure/library/testing:all_js",
        "//closure/library/timer:all_js",
        "//closure/library/tweak:all_js",
        "//closure/library/uri:all_js",
        "//closure/library/useragent:all_js",
        "//closure/library/vec:all_js",
        "//closure/library/webgl:all_js",
        "//closure/library/window:all_js",
    ],
)

closure_js_library(
    name = "testing",
    testonly = True,
    exports = [
        "//closure/library:test_module",
        "//closure/library:test_module_dep",
        "//closure/library/crypt:hashtester",
        "//closure/library/events:eventtargettester",
        "//closure/library/html:testing",
        "//closure/library/promise:testsuiteadapter",
        "//closure/library/proto2:test.pb",
        "//closure/library/storage:collectablestoragetester",
        "//closure/library/storage:storagetester",
        "//closure/library/storage/mechanism:iterablemechanismtester",
        "//closure/library/storage/mechanism:mechanismseparationtester",
        "//closure/library/storage/mechanism:mechanismsharingtester",
        "//closure/library/storage/mechanism:mechanismtestdefinition",
        "//closure/library/storage/mechanism:mechanismtester",
        "//closure/library/style:stylescrollbartester",
        "//closure/library/testing:assertionfailure",
        "//closure/library/testing:asserts",
        "//closure/library/testing:asynctestcase",
        "//closure/library/testing:benchmark",
        "//closure/library/testing:continuationtestcase",
        "//closure/library/testing:deferredtestcase",
        "//closure/library/testing:dom",
        "//closure/library/testing:expectedfailures",
        "//closure/library/testing:functionmock",
        "//closure/library/testing:graphics",
        "//closure/library/testing:jstdtestcaseadapter",
        "//closure/library/testing:jsunit",
        "//closure/library/testing:jsunitexception",
        "//closure/library/testing:loosemock",
        "//closure/library/testing:mock",
        "//closure/library/testing:mockclassfactory",
        "//closure/library/testing:mockclock",
        "//closure/library/testing:mockcontrol",
        "//closure/library/testing:mockinterface",
        "//closure/library/testing:mockmatchers",
        "//closure/library/testing:mockrandom",
        "//closure/library/testing:mockrange",
        "//closure/library/testing:mockstorage",
        "//closure/library/testing:mockuseragent",
        "//closure/library/testing:multitestrunner",
        "//closure/library/testing:objectpropertystring",
        "//closure/library/testing:performancetable",
        "//closure/library/testing:performancetimer",
        "//closure/library/testing:propertyreplacer",
        "//closure/library/testing:pseudorandom",
        "//closure/library/testing:recordfunction",
        "//closure/library/testing:shardingtestcase",
        "//closure/library/testing:singleton",
        "//closure/library/testing:stacktrace",
        "//closure/library/testing:strictmock",
        "//closure/library/testing:testcase",
        "//closure/library/testing:testqueue",
        "//closure/library/testing:testrunner",
        "//closure/library/testing:testsuite",
        "//closure/library/testing/async:mockcontrol",
        "//closure/library/testing/editor:dom",
        "//closure/library/testing/editor:fieldmock",
        "//closure/library/testing/editor:testhelper",
        "//closure/library/testing/events",
        "//closure/library/testing/events:eventobserver",
        "//closure/library/testing/events:matchers",
        "//closure/library/testing/events:onlinehandler",
        "//closure/library/testing/fs",
        "//closure/library/testing/fs:blob",
        "//closure/library/testing/fs:entry",
        "//closure/library/testing/fs:file",
        "//closure/library/testing/fs:filereader",
        "//closure/library/testing/fs:filesystem",
        "//closure/library/testing/fs:filewriter",
        "//closure/library/testing/fs:progressevent",
        "//closure/library/testing/i18n:asserts",
        "//closure/library/testing/messaging:mockmessagechannel",
        "//closure/library/testing/messaging:mockmessageevent",
        "//closure/library/testing/messaging:mockmessageport",
        "//closure/library/testing/messaging:mockportnetwork",
        "//closure/library/testing/net:mockiframeio",
        "//closure/library/testing/net:xhrio",
        "//closure/library/testing/net:xhriopool",
        "//closure/library/testing/proto2",
        "//closure/library/testing/storage:fakemechanism",
        "//closure/library/testing/style",
        "//closure/library/testing/style:layoutasserts",
        "//closure/library/tweak:testhelpers",
        "//closure/library/useragent:useragenttestutil",
    ],
)

closure_js_library(
    name = "goog",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/goog.js"],
    lenient = True,
    no_closure_library = True,
)

closure_js_library(
    name = "test_module",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/test_module.js"],
    lenient = True,
    deps = ["//closure/library:test_module_dep"],
)

closure_js_library(
    name = "test_module_dep",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:closure/goog/test_module_dep.js"],
    lenient = True,
)

filegroup(
    name = "base",
    srcs = [
        "@com_google_javascript_closure_library//:closure/goog/base.js",
        "@com_google_javascript_closure_library//:closure/goog/transitionalforwarddeclarations.js",
    ],
)

closure_js_library(
    name = "base_lib",
    srcs = [
        "@com_google_javascript_closure_library//:closure/goog/base.js",
        "@com_google_javascript_closure_library//:closure/goog/transitionalforwarddeclarations.js",
    ],
    # Prevent circular dependencies
    closure_library_base = [],
)

closure_js_library(
    name = "deps",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/deps.js"],
    lenient = True,
)

closure_js_library(
    name = "transpile",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/transpile.js"],
    lenient = True,
)

closure_css_library(
    name = "css",
    srcs = ["@com_google_javascript_closure_library//:css_files"],
)

py_binary(
    name = "regenerate",
    srcs = ["regenerate.py"],
    args = ["$(location @com_google_javascript_closure_library//:closure/goog/base.js)"],
    data = [
        "@com_google_javascript_closure_library",
        "@com_google_javascript_closure_library//:closure/goog/base.js",
    ],
    tags = [
        "local",
        "manual",
    ],
    visibility = ["//visibility:private"],
)
