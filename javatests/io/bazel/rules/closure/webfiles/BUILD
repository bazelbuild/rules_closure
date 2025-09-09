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

load("@rules_java//java:defs.bzl", "java_test")

licenses(["notice"])

# This is to work around error
# https://stackoverflow.com/questions/67782975/how-to-fix-the-module-java-base-does-not-opens-java-io-to-unnamed-module
# Adding add_opens = ["java.base/java.io"] will introduce https://github.com/mockito/mockito/issues/1467
java_library(
    name = "mockito",
    testonly = True,
    exports = ["@google_bazel_common//third_party/java/mockito"],
    runtime_deps = [
        "@google_bazel_common//third_party/java/byte_buddy",
        "@google_bazel_common//third_party/java/byte_buddy_agent",
        "@google_bazel_common//third_party/java/hamcrest",
        "@google_bazel_common//third_party/java/objenesis",
    ],
)

java_test(
    name = "WebfilesTestSuite",
    size = "small",
    srcs = glob(["*.java"]),
    test_class = "io.bazel.rules.closure.webfiles.WebfilesTestSuite",
    deps = [
        ":mockito",
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/webfiles",
        "//java/io/bazel/rules/closure/webfiles:build_info_java_proto",
        "//java/io/bazel/rules/closure/webfiles/compiler",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/guava:testlib",
        "@google_bazel_common//third_party/java/junit",
        "@google_bazel_common//third_party/java/truth",
        "@maven//:com_google_jimfs_jimfs",
    ],
)
