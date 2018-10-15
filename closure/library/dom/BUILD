# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractmultirange",
        ":abstractrange",
        ":annotate",
        ":asserts",
        ":attr",
        ":browserfeature",
        ":bufferedviewportsizemonitor",
        ":classes",
        ":classlist",
        ":controlrange",
        ":dataset",
        ":dom",
        ":fontsizemonitor",
        ":forms",
        ":fullscreen",
        ":htmlelement",
        ":iframe",
        ":inputtype",
        ":iter",
        ":multirange",
        ":nodeiterator",
        ":nodeoffset",
        ":nodetype",
        ":range",
        ":rangeendpoint",
        ":safe",
        ":savedcaretrange",
        ":savedrange",
        ":selection",
        ":tagiterator",
        ":tagname",
        ":tags",
        ":textassert",
        ":textrange",
        ":textrangeiterator",
        ":uri",
        ":vendor",
        ":viewportsizemonitor",
        ":xml",
        "//closure/library/dom/animationframe:all_js",
        "//closure/library/dom/browserrange:all_js",
        "//closure/library/dom/pattern:all_js",
    ],
)

closure_js_library(
    name = "abstractmultirange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/abstractmultirange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:textrange",
    ],
)

closure_js_library(
    name = "abstractrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/abstractrange.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:savedcaretrange",
        "//closure/library/dom:tagiterator",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "annotate",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/annotate.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "asserts",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/asserts.js"],
    lenient = True,
    deps = ["//closure/library/asserts"],
)

closure_js_library(
    name = "attr",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/attr.js"],
    lenient = True,
)

closure_js_library(
    name = "browserfeature",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/browserfeature.js"],
    lenient = True,
    deps = ["//closure/library/useragent"],
)

closure_js_library(
    name = "bufferedviewportsizemonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/bufferedviewportsizemonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/async:delay",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
    ],
)

closure_js_library(
    name = "classes",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/classes.js"],
    lenient = True,
    deps = ["//closure/library/array"],
)

closure_js_library(
    name = "classlist",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/classlist.js"],
    lenient = True,
    deps = ["//closure/library/array"],
)

closure_js_library(
    name = "controlrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/controlrange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:abstractmultirange",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:savedrange",
        "//closure/library/dom:tagiterator",
        "//closure/library/dom:textrange",
        "//closure/library/iter",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "dataset",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/dataset.js"],
    lenient = True,
    deps = [
        "//closure/library/labs/useragent:browser",
        "//closure/library/string",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "dom",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/dom.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:browserfeature",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/math:coordinate",
        "//closure/library/math:size",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "fontsizemonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/fontsizemonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "forms",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/forms.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/structs:map",
        "//closure/library/window",
    ],
)

closure_js_library(
    name = "fullscreen",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/fullscreen.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "htmlelement",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/htmlelement.js"],
    lenient = True,
)

closure_js_library(
    name = "iframe",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/iframe.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/html:safestyle",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string:const",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "inputtype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/inputtype.js"],
    lenient = True,
)

closure_js_library(
    name = "iter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/iter.js"],
    lenient = True,
    deps = ["//closure/library/iter"],
)

closure_js_library(
    name = "multirange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/multirange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:abstractmultirange",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:savedrange",
        "//closure/library/dom:textrange",
        "//closure/library/iter",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "nodeiterator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/nodeiterator.js"],
    lenient = True,
    deps = ["//closure/library/dom:tagiterator"],
)

closure_js_library(
    name = "nodeoffset",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/nodeoffset.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom:tagname",
    ],
)

closure_js_library(
    name = "nodetype",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/nodetype.js"],
    lenient = True,
)

closure_js_library(
    name = "range",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/range.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:browserfeature",
        "//closure/library/dom:controlrange",
        "//closure/library/dom:multirange",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:textrange",
    ],
)

closure_js_library(
    name = "rangeendpoint",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/rangeendpoint.js"],
    lenient = True,
)

closure_js_library(
    name = "safe",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/safe.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:asserts",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/html:safescript",
        "//closure/library/html:safestyle",
        "//closure/library/html:safeurl",
        "//closure/library/html:trustedresourceurl",
        "//closure/library/string",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "savedcaretrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/savedcaretrange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:savedrange",
        "//closure/library/dom:tagname",
        "//closure/library/string",
    ],
)

closure_js_library(
    name = "savedrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/savedrange.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/log",
    ],
)

closure_js_library(
    name = "selection",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/selection.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:inputtype",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "tagiterator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/tagiterator.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "tagname",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/tagname.js"],
    lenient = True,
    deps = ["//closure/library/dom:htmlelement"],
)

closure_js_library(
    name = "tags",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/tags.js"],
    lenient = True,
    deps = ["//closure/library/object"],
)

closure_js_library(
    name = "textassert",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/textassert.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
    ],
)

closure_js_library(
    name = "textrange",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/textrange.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:savedrange",
        "//closure/library/dom:tagname",
        "//closure/library/dom:textrangeiterator",
        "//closure/library/dom/browserrange",
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "textrangeiterator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/textrangeiterator.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:abstractrange",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "uri",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/uri.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:uncheckedconversions",
        "//closure/library/string:const",
    ],
)

closure_js_library(
    name = "vendor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/vendor.js"],
    lenient = True,
    deps = [
        "//closure/library/string",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "viewportsizemonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/viewportsizemonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/math:size",
    ],
)

closure_js_library(
    name = "xml",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/dom/xml.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/useragent",
    ],
)
