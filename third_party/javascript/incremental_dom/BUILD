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

licenses(["notice"])  # Apache License Version 2.0

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "incremental_dom",
    srcs = ["incremental-dom-closure.js"],
    suppress = [
        "JSC_IMPLICITLY_NULLABLE_JSDOC",
        "JSC_NTI_COULD_NOT_INFER_CONST_TYPE",
        "JSC_NTI_INEXISTENT_PROPERTY",
        "JSC_NTI_INVALID_ARGUMENT_TYPE",
        "JSC_NTI_UNKNOWN_EXPR_TYPE",
        "JSC_STRICT_INEXISTENT_PROPERTY",
        "JSC_TYPE_MISMATCH",
        "JSC_UNKNOWN_EXPR_TYPE",
    ],
    visibility = ["//visibility:public"],
)

genrule(
    name = "extract",
    srcs = ["@com_google_javascript_incremental_dom//file"],
    outs = ["incremental-dom-closure.js"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "SCRIPT=$$(pwd)/$(location :build)",
        "cd $$TMP",
        "$$SCRIPT $$IN $$OUT",
        "rm -rf $$TMP",
    ]),
    tools = [":build"],
)

sh_binary(
    name = "build",
    srcs = ["build.sh"],
)
