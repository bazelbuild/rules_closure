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

load("//closure:defs.bzl", "closure_js_library")
load("//closure:defs.bzl", "closure_css_library")

closure_js_library(
    name = "library",
    srcs = ["@com_google_javascript_closure_library//:js_library_files"],
    suppress = [
        "CR_INVALID_SETTESTONLY",
        "JSC_ARRAY_PASSED_TO_GOOG_OBJECT",
        "JSC_CONSTANT_WITHOUT_EXPLICIT_TYPE",
        "JSC_DEPRECATED_CLASS_REASON",
        "JSC_DEPRECATED_PROP",
        "JSC_DEPRECATED_PROP_REASON",
        "JSC_DUPLICATE_ENUM_VALUE",
        "JSC_EXTRA_REQUIRE_WARNING",
        "JSC_ILLEGAL_PROTOTYPE_MEMBER",
        "JSC_IMPLICITLY_NULLABLE_JSDOC",
        "JSC_INCOMPATIBLE_STRICT_COMPARISON",
        "JSC_INVALID_SUPPRESS",
        "JSC_JSDOC_REFERENCE_TO_SHORT_IMPORT_BY_LONG_NAME_INCLUDING_SHORT_NAME",
        "JSC_MISSING_JSDOC",
        "JSC_MISSING_RETURN_JSDOC",
        "JSC_MISSING_SEMICOLON",
        "JSC_MUST_BE_PRIVATE",
        "JSC_NTI_ADDING_PROPERTY_TO_NON_OBJECT",
        "JSC_NTI_CIRCULAR_TYPEDEF_ENUM",
        "JSC_NTI_CONST_PROPERTY_REASSIGNED",
        "JSC_NTI_COULD_NOT_INFER_CONST_TYPE",
        "JSC_NTI_ENUM_IS_UNION",
        "JSC_NTI_FAILED_TO_UNIFY",
        "JSC_NTI_FORIN_EXPECTS_OBJECT",
        "JSC_NTI_GOOG_BIND_EXPECTS_FUNCTION",
        "JSC_NTI_ILLEGAL_PROPERTY_ACCESS",
        "JSC_NTI_INEXISTENT_PROPERTY",
        "JSC_NTI_INVALID_ARGUMENT_TYPE",
        "JSC_NTI_INVALID_CAST",
        "JSC_NTI_INVALID_OPERAND_TYPE",
        "JSC_NTI_INVALID_PROP_OVERRIDE",
        "JSC_NTI_MISTYPED_ASSIGN_RHS",
        "JSC_NTI_NOT_UNIQUE_INSTANTIATION",
        "JSC_NTI_NULLABLE_DEREFERENCE",
        "JSC_NTI_POSSIBLY_INEXISTENT_PROPERTY",
        "JSC_NTI_PROPERTY_ACCESS_ON_NONOBJECT",
        "JSC_NTI_REDECLARED_PROPERTY",
        "JSC_NTI_RETURN_NONDECLARED_TYPE",
        "JSC_NTI_UNKNOWN_EXPR_TYPE",
        "JSC_NTI_USED_GLOBAL_THIS",
        "JSC_NTI_WRONG_ARGUMENT_COUNT",
        "JSC_NULLABLE_RETURN_WITH_NAME",
        "JSC_PROVIDES_NOT_SORTED",
        "JSC_UNKNOWN_EXPR_TYPE",
        "JSC_UNUSED_PRIVATE_PROPERTY",
        "CR_INVALID_SETTESTONLY",
    ],
)

closure_js_library(
    name = "testing",
    testonly = True,
    srcs = ["@com_google_javascript_closure_library//:js_testing_files"],
    suppress = [
        "JSC_DEPRECATED_CLASS_REASON",
        "JSC_DEPRECATED_PROP_REASON",
        "JSC_EXTRA_REQUIRE_WARNING",
        "JSC_IMPLICITLY_NULLABLE_JSDOC",
        "JSC_INVALID_SUPPRESS",
        "JSC_MISSING_JSDOC",
        "JSC_MISSING_RETURN_JSDOC",
        "JSC_MISSING_SEMICOLON",
        "JSC_MUST_BE_PRIVATE",
        "JSC_NULLABLE_RETURN_WITH_NAME",
        "JSC_POSSIBLE_INEXISTENT_PROPERTY",
        "JSC_PRIMITIVE_OBJECT",
        "JSC_REQUIRES_NOT_SORTED",
        "JSC_UNDEFINED_VARIABLE",
        "JSC_UNKNOWN_EXPR_TYPE",
        "JSC_UNUSED_PRIVATE_PROPERTY",
    ],
    deps = [":library"],
)

closure_css_library(
    name = "css",
    srcs = [
        "@com_google_javascript_closure_library//:css_files",
    ],
)
