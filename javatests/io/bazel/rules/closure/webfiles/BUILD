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

licenses(["notice"])

load("@rules_java//java:defs.bzl", "java_test")

java_test(
    name = "WebfilesTestSuite",
    size = "small",
    srcs = glob(["*.java"]),
    deps = [
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/webfiles",
        "//java/io/bazel/rules/closure/webfiles:build_info_java_proto",
        "//java/io/bazel/rules/closure/webfiles/compiler",
        "@com_google_guava",
        "@com_google_guava_testlib",
        "@com_google_jimfs",
        "@com_google_truth",
        "@junit",
        "@org_mockito_core",
    ],
)
