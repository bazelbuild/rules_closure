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
load("@rules_java//java:defs.bzl", "java_library", "java_proto_library")

java_library(
    name = "worker",
    srcs = glob(["*.java"]),
    visibility = ["//:__subpackages__"],
    # Our goal with this depnedency list is to keep it lightweight. It only
    # depends on Guava, Protobuf, and a few tiny annotation runtime libraries.
    #
    # TODO(jart): Investigate removing Dagger dependency and push DI heavy
    #             functionality into sub-package that makes Dagger optional.
    deps = [
        ":worker_protocol_java_proto",
        "@com_google_auto_value",
        "@com_google_code_findbugs_jsr305",
        "@com_google_dagger",
        "@com_google_guava",
        "@com_google_protobuf//:protobuf_java",
    ],
)

proto_library(
    name = "worker_protocol_proto",
    srcs = ["worker_protocol.proto"],
)

java_proto_library(
    name = "worker_protocol_java_proto",
    visibility = ["//javatests/io/bazel/rules/closure/worker:__pkg__"],
    deps = [":worker_protocol_proto"],
)
