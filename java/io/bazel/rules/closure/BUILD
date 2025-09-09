# Copyright 2016 The Closure Rules Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@rules_java//java:defs.bzl", "java_binary", "java_library", "java_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")

licenses(["notice"])

java_binary(
    name = "ClosureWorker",
    srcs = ["ClosureWorker.java"],
    jvm_flags = [
        "-Xss20m",  # JSCompiler needs big stacks for recursive parsing
        "-XX:+UseParallelGC",  # Best GC when app isn't latency sensitive
    ],
    main_class = "io.bazel.rules.closure.ClosureWorker",
    visibility = ["//visibility:public"],
    deps = [
        "//java/com/google/javascript/jscomp",
        "//java/io/bazel/rules/closure/webfiles",
        "//java/io/bazel/rules/closure/webfiles/compiler",
        "//java/io/bazel/rules/closure/worker",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr330_inject",
    ],
)

java_library(
    name = "tarjan",
    srcs = ["Tarjan.java"],
    visibility = ["//visibility:public"],
    deps = [
        "@google_bazel_common//third_party/java/auto:value",
        "@google_bazel_common//third_party/java/guava",
    ],
)

java_library(
    name = "webpath",
    srcs = [
        "Webpath.java",
        "WebpathInterner.java",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr305_annotations",
        "@google_bazel_common//third_party/java/jsr330_inject",
    ],
)

proto_library(
    name = "build_info_proto",
    srcs = ["build_info.proto"],
)

java_proto_library(
    name = "build_info_java_proto",
    visibility = ["//visibility:public"],
    deps = [":build_info_proto"],
)
