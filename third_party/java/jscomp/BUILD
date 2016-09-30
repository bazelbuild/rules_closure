package(default_visibility = ["//visibility:public"])

licenses([
    "notice",  # Apache License 2.0 (Closure Compiler)
    "reciprocal",  # Mozilla Public License Version 1.1 (Rhino AST)
])

java_library(
    name = "jscomp",
    visibility = ["//visibility:public"],
    exports = ["@closure_compiler//jar"],
    runtime_deps = [
        "@gson//jar",
        "@guava//jar",
        "@jsr305//jar",
        "@protobuf_java//jar",
    ],
)

java_binary(
    name = "main",
    main_class = "com.google.javascript.jscomp.CommandLineRunner",
    runtime_deps = [
        ":jscomp",
        "@args4j//jar",
    ],
)
