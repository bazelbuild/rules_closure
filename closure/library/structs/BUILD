# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":avltree",
        ":circularbuffer",
        ":collection",
        ":heap",
        ":inversionmap",
        ":linkedmap",
        ":map",
        ":node",
        ":pool",
        ":prioritypool",
        ":priorityqueue",
        ":quadtree",
        ":queue",
        ":set",
        ":simplepool",
        ":stringset",
        ":structs",
        ":treenode",
        ":trie",
    ],
)

closure_js_library(
    name = "avltree",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/avltree.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/structs:collection",
    ],
)

closure_js_library(
    name = "circularbuffer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/circularbuffer.js"],
    lenient = True,
)

closure_js_library(
    name = "collection",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/collection.js"],
    lenient = True,
)

closure_js_library(
    name = "heap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/heap.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/object",
        "//closure/library/structs:node",
    ],
)

closure_js_library(
    name = "inversionmap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/inversionmap.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
    ],
)

closure_js_library(
    name = "linkedmap",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/linkedmap.js"],
    lenient = True,
    deps = ["//closure/library/structs:map"],
)

closure_js_library(
    name = "map",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/map.js"],
    lenient = True,
    deps = ["//closure/library/iter"],
)

closure_js_library(
    name = "node",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/node.js"],
    lenient = True,
)

closure_js_library(
    name = "pool",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/pool.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/structs:queue",
        "//closure/library/structs:set",
    ],
)

closure_js_library(
    name = "prioritypool",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/prioritypool.js"],
    lenient = True,
    deps = [
        "//closure/library/structs:pool",
        "//closure/library/structs:priorityqueue",
    ],
)

closure_js_library(
    name = "priorityqueue",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/priorityqueue.js"],
    lenient = True,
    deps = ["//closure/library/structs:heap"],
)

closure_js_library(
    name = "quadtree",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/quadtree.js"],
    lenient = True,
    deps = ["//closure/library/math:coordinate"],
)

closure_js_library(
    name = "queue",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/queue.js"],
    lenient = True,
    deps = ["//closure/library/array"],
)

closure_js_library(
    name = "set",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/set.js"],
    lenient = True,
    deps = [
        "//closure/library/structs",
        "//closure/library/structs:collection",
        "//closure/library/structs:map",
    ],
)

closure_js_library(
    name = "simplepool",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/simplepool.js"],
    lenient = True,
    deps = ["//closure/library/disposable"],
)

closure_js_library(
    name = "stringset",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/stringset.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/iter",
    ],
)

closure_js_library(
    name = "structs",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/structs.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/object",
    ],
)

closure_js_library(
    name = "treenode",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/treenode.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/structs:node",
    ],
)

closure_js_library(
    name = "trie",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/structs/trie.js"],
    lenient = True,
    deps = [
        "//closure/library/object",
        "//closure/library/structs",
    ],
)
