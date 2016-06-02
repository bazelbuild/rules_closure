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
    jvm_flags = ["-client"],
    main_class = "com.google.javascript.jscomp.JsChecker",
    visibility = ["//visibility:public"],
    deps = [
        "@args4j//jar",
        "@guava//jar",
        "@protobuf_java//jar",
        "//third_party/java/jscomp",
    ],
)
