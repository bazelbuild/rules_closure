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

load("@rules_java//java:defs.bzl", "java_library")

licenses(["notice"])

java_library(
    name = "jscomp",
    srcs = [
        "CheckSetTestOnly.java",
        "CheckStrictDeps.java",
        "Diagnostics.java",
        "JsChecker.java",
        "JsCheckerClosureCodingConvention.java",
        "JsCheckerConvention.java",
        "JsCheckerErrorFormatter.java",
        "JsCheckerErrorManager.java",
        "JsCheckerHelper.java",
        "JsCheckerPassConfig.java",
        "JsCheckerState.java",
        "JsCompiler.java",
        "JsCompilerRunner.java",
        "JsCompilerWarnings.java",
    ],
    visibility = [
        "//java/io/bazel/rules/closure:__pkg__",
        "//javatests/com/google/javascript/jscomp:__pkg__",
    ],
    deps = [
        "//closure/compiler",
        "//java/io/bazel/rules/closure:build_info_java_proto",
        "//java/io/bazel/rules/closure:webpath",
        "//java/io/bazel/rules/closure/worker",
        "@com_google_protobuf//:protobuf_java",
        "@google_bazel_common//third_party/java/dagger",
        "@google_bazel_common//third_party/java/guava",
        "@google_bazel_common//third_party/java/jsr330_inject",
        "@maven//:args4j_args4j",
    ],
)
