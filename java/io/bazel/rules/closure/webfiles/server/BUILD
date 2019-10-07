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
load("//closure:defs.bzl", "closure_java_template_library")

java_library(
    name = "server",
    srcs = glob(["*.java"]),
    visibility = ["//:__subpackages__"],
    deps = [
        ":build_info_java_proto",
        ":listing",
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/http",
        "//java/io/bazel/rules/closure/http/filter",
        "//java/io/bazel/rules/closure/webfiles:build_info_java_proto",
        "@com_google_code_findbugs_jsr305",
        "@com_google_dagger",
        "@com_google_guava",
        "@com_google_protobuf//:protobuf_java",
        "@com_google_template_soy",
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

closure_java_template_library(
    name = "listing",
    srcs = ["listing.soy"],
)
