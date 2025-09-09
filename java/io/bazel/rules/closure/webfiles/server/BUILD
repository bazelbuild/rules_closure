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

java_library(
    name = "server",
    srcs = glob(["*.java"]),
    visibility = ["//:__subpackages__"],
    deps = [
        ":build_info_java_proto",
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/http",
        "//java/io/bazel/rules/closure/http/filter",
        "//java/io/bazel/rules/closure/webfiles:build_info_java_proto",
        "@com_google_protobuf//:protobuf_java",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr305_annotations",
        "@google_bazel_common//third_party/java/jsr330_inject",
    ],
)

java_binary(
    name = "WebfilesServer",
    main_class = "io.bazel.rules.closure.webfiles.server.WebfilesServer",
    visibility = ["//visibility:public"],
    runtime_deps = [":server"],
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
