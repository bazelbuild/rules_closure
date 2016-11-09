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

load("//closure/templates:closure_java_template_library.bzl", "closure_java_template_library")

licenses(["notice"])  # Apache 2.0

java_library(
    name = "webfiles",
    srcs = ["WebfilesValidator.java"],
    visibility = [
        "//java/io/bazel/rules/closure:__pkg__",
        "//javatests/io/bazel/rules/closure/webfiles:__pkg__",
    ],
    deps = [
        "//java/io/bazel/rules/closure:tarjan",
        "//java/io/bazel/rules/closure/program",
        "@guava//jar",
    ],
)

java_binary(
    name = "WebfilesServer",
    testonly = 1,
    srcs = [
        "MimeTypes.java",
        "NetworkUtils.java",
        "WebfilesServer.java",
    ],
    resources = ["invisible_college.ansi"],
    visibility = ["//visibility:public"],
    deps = [
        ":listing",
        "//third_party/java/jetty/v6_1_22",
        "//third_party/java/soy",
        "@guava//jar",
        "@jsr305//jar",
        "@servlet_api//jar",
    ],
)

closure_java_template_library(
    name = "listing",
    testonly = 1,
    srcs = ["listing.soy"],
)
