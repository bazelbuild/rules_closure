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

package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")

closure_js_library(
    name = "jspb",
    srcs = ["@protobuf_js//:proto_js_library_files"],
    suppress = [
        "JSC_EXTRA_REQUIRE_WARNING",
        "JSC_IMPLICITLY_NULLABLE_JSDOC",
        "JSC_NTI_ADDING_PROPERTY_TO_NON_OBJECT",
        "JSC_NTI_CANNOT_MAKE_TYPEVAR_NON_NULL",
        "JSC_NTI_ILLEGAL_PROPERTY_ACCESS",
        "JSC_NTI_INEXISTENT_PROPERTY",
        "JSC_NTI_INVALID_ARGUMENT_TYPE",
        "JSC_NTI_INVALID_OPERAND_TYPE",
        "JSC_NTI_MISTYPED_ASSIGN_RHS",
        "JSC_NTI_NULLABLE_DEREFERENCE",
        "JSC_NTI_POSSIBLY_INEXISTENT_PROPERTY",
        "JSC_NTI_PROPERTY_ACCESS_ON_NONOBJECT",
        "JSC_NTI_RETURN_NONDECLARED_TYPE",
        "JSC_NTI_UNION_IS_UNINHABITABLE",
        "JSC_NTI_UNKNOWN_EXPR_TYPE",
        "JSC_NTI_WRONG_ARGUMENT_COUNT",
        "JSC_NULLABLE_RETURN_WITH_NAME",
        "JSC_OPTIONAL_PARAM_NOT_MARKED_OPTIONAL",
        "JSC_UNKNOWN_EXPR_TYPE",
    ],
    deps = ["//closure/library"],
)
