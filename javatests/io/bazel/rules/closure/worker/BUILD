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

licenses(["notice"])

load("@rules_java//java:defs.bzl", "java_test")

java_test(
    name = "WorkerTestSuite",
    size = "small",
    srcs = glob(["*.java"]),
    deps = [
        "//java/io/bazel/rules/closure/worker",
        "//java/io/bazel/rules/closure/worker:worker_protocol_java_proto",
        "@com_google_code_findbugs_jsr305",
        "@com_google_dagger",
        "@com_google_guava",
        "@com_google_jimfs",
        "@com_google_protobuf//:protobuf_java",
        "@com_google_truth",
        "@junit",
        "@org_mockito_core",
    ],
)
