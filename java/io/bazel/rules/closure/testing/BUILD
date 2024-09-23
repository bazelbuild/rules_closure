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
    srcs = glob(["*.java"]),
    main_class = "io.bazel.rules.closure.testing.TestRunner",
    deps = [
        "@org_seleniumhq_selenium_selenium_api",
        "@org_seleniumhq_selenium_selenium_support",
        "@org_seleniumhq_selenium_selenium_remote_driver",
        "@io_bazel_rules_webtesting//java/com/google/testing/web:web",
        "//java/io/bazel/rules/closure/webfiles/server",
        "@com_google_guava",
    ],
    testonly = 1,
)
