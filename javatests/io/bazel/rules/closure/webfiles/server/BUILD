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
    name = "ServerTestSuite",
    size = "small",
    srcs = glob(["*.java"]),
    test_class = "io.bazel.rules.closure.webfiles.server.ServerTestSuite",
    deps = [
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/http",
        "//java/io/bazel/rules/closure/webfiles:build_info_java_proto",
        "//java/io/bazel/rules/closure/webfiles/server",
        "//java/io/bazel/rules/closure/webfiles/server:build_info_java_proto",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/guava:testlib",
        "@google_bazel_common//third_party/java/jsr305_annotations",
        "@google_bazel_common//third_party/java/junit",
        "@google_bazel_common//third_party/java/mockito",
        "@google_bazel_common//third_party/java/truth",
        "@maven//:com_google_jimfs_jimfs",
    ],
)
