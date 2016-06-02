load("//closure/private:java_proto_library.bzl", "java_proto_library")

java_binary(
    name = "jschecker",
    srcs = [
        "JsChecker.java",
        "JsCheckerClosureCodingConvention.java",
        "JsCheckerErrorFormatter.java",
        "JsCheckerErrorManager.java",
        "JsCheckerFirstPass.java",
        "JsCheckerHelper.java",
        "JsCheckerPassConfig.java",
        "JsCheckerSecondPass.java",
        "JsCheckerState.java",
    ],
    main_class = "com.google.javascript.jscomp.JsChecker",
    visibility = ["//visibility:public"],
    deps = [
        "@args4j//jar",
        "@guava//jar",
        "@protobuf_java//jar",
        ":worker_protocol_proto",
        "//third_party/java/jscomp",
    ],
)

java_proto_library(
    name = "worker_protocol_proto",
    src = "worker_protocol.proto",
)
