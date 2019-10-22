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

licenses(["notice"])  # Apache 2.0

load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_java//java:defs.bzl", "java_binary", "java_library", "java_proto_library")

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
        "@com_google_dagger",
        "@com_google_guava",
        "@javax_inject",
    ],
)

java_library(
    name = "tarjan",
    srcs = ["Tarjan.java"],
    visibility = ["//visibility:public"],
    deps = [
        "@com_google_auto_value",
        "@com_google_guava",
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
        "@com_google_code_findbugs_jsr305",
        "@com_google_guava",
        "@javax_inject",
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
