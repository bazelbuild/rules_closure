# Copyright 2017 The Closure Rules Authors. All rights reserved.
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

load("@rules_java//java:defs.bzl", "java_test")

licenses(["notice"])

java_test(
    name = "WorkerTestSuite",
    size = "small",
    srcs = glob(["*.java"]),
    test_class = "io.bazel.rules.closure.worker.WorkerTestSuite",
    deps = [
        "//java/io/bazel/rules/closure/worker",
        "//java/io/bazel/rules/closure/worker:worker_protocol_java_proto",
        "@com_google_protobuf//:protobuf_java",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr305_annotations",
        "@google_bazel_common//third_party/java/junit",
        "@google_bazel_common//third_party/java/mockito",
        "@google_bazel_common//third_party/java/truth",
        "@maven//:com_google_jimfs_jimfs",
    ],
)
