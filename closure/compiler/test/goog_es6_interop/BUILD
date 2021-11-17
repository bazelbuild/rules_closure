# Copyright 2019 The Closure Rules Authors. All rights reserved.
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


load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")

closure_js_library(
    name = "person",
    srcs = [
        "person.js",
    ],
    deps = [
        "@com_google_javascript_closure_library//closure/goog/string",
    ],
)

closure_js_library(
    name = "person_factory",
    srcs = [
        "person_factory.js",
    ],
    # TODO(yannic): Remove this suppression when
    #     `bazelbuild/rules_closure#436` is fixed.
    suppress = ["moduleLoad"],
    deps = [
        ":person",
        "@com_google_javascript_closure_library//closure/goog/asserts",
    ],
)

closure_js_test(
    name = "person_factory_test",
    srcs = [
        "person_factory_test.js",
    ],
    entry_points = [
        "goog:rulesClosure.googEs6Interop.PersonFactoryTest",
    ],
    deps = [
        ":person_factory",
        "@com_google_javascript_closure_library//closure/goog/testing:testsuite",
    ],
)
