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

package(default_testonly = True)

licenses(["notice"])

load("//closure/private:file_test.bzl", "file_test")
load("//closure:defs.bzl", "closure_js_binary", "closure_js_library")

# Property renaming reports are rarely used. But they can be used to minify
# JSON messages. However it's recommended that you use protobuf instead.

closure_js_library(
    name = "property_lib",
    srcs = ["property.js"],
)

closure_js_binary(
    name = "property_bin",
    property_renaming_report = "property_bin_renaming_report.txt",
    deps = [":property_lib"],
)

file_test(
    name = "propertyWithoutQuotes_getsRenamed",
    regexp = r'console.log({\w:"world"});',
    file = "property_bin.js",
)

file_test(
    name = "propertyRenamingReportDef_createsAdditionalOutputFile",
    regexp = "hello:\\w",
    file = "property_bin_renaming_report.txt",
)
