# Copyright 2022 The Closure Rules Authors. All rights reserved.
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
load("@rules_java//java:defs.bzl", "java_binary")

package(
    default_testonly = True,
    default_visibility = ["//visibility:public"],
)

licenses(["notice"])

java_binary(
    name = "webdriver_test_bin",
    testonly = 1,
    srcs = glob(["*.java"]),
    main_class = "io.bazel.rules.closure.testing.TestRunner",
    deps = [
        "//java/io/bazel/rules/closure/webfiles/server",
        "@google_bazel_common//third_party/java/guava",
        "@maven//:org_seleniumhq_selenium_selenium_api",
        "@maven//:org_seleniumhq_selenium_selenium_remote_driver",
        "@maven//:org_seleniumhq_selenium_selenium_support",
        "@io_rules_web_testing_java//java/com/google/testing/web",
    ],
)
