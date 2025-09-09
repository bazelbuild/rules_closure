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

load("@rules_java//java:defs.bzl", "java_library")

licenses(["notice"])

java_library(
    name = "testing",
    testonly = 1,
    srcs = glob(["*.java"]),
    visibility = ["//:__subpackages__"],
    deps = [
        "//java/io/bazel/rules/closure/worker",
        "@google_bazel_common//third_party/java/auto:value",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr330_inject",
        "@google_bazel_common//third_party/java/truth",
    ],
)
