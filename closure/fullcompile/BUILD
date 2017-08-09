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

load(
    "//closure:defs.bzl",
    "closure_js_binary",
    "closure_js_library",
    "closure_js_test",
)

REQUIRE_ALL_COMMAND = "#/bin/bash\necho -e '/** @fileoverview Foo\n * @suppress {extraRequire}\n */' >$@; { for s in $(SRCS); do grep ^goog.provide\( $${s} || true; done; } | sed 's/goog.provide/goog.require/' | grep -v SvgPan | grep -v portchannel_worker | grep -v portnetwork_worker | sort >>$@"

genrule(
    name = "library_require",
    srcs = ["@closure_library//:js_library_files"],
    outs = ["library_require.js"],
    cmd = REQUIRE_ALL_COMMAND,
    visibility = ["//visibility:private"],
)

closure_js_library(
    name = "library_require_lib",
    srcs = ["library_require.js"],
    deps = ["//closure/library"],
)

closure_js_binary(
    name = "library_require_oti",
    deps = [":library_require_lib"],
)

closure_js_binary(
    name = "library_require_nti",
    defs = ["--new_type_inf"],
    deps = [":library_require_lib"],
)

genrule(
    name = "testing_require",
    srcs = ["@closure_library//:js_testing_files"],
    outs = ["js_require_test.js"],
    cmd = REQUIRE_ALL_COMMAND,
    visibility = ["//visibility:private"],
)

# closure_js_test(
#     name = "testing_require_test",
#     srcs = ["js_require_test.js"],
#     deps = ["//closure/library:testing"],
# )

genrule(
    name = "jspb_require",
    srcs = ["@protobuf_js//:proto_js_library_files"],
    outs = ["jspb_require.js"],
    cmd = REQUIRE_ALL_COMMAND,
    visibility = ["//visibility:private"],
)

closure_js_library(
    name = "jspb_require_lib",
    srcs = ["jspb_require.js"],
    deps = ["//closure/protobuf:jspb"],
)

closure_js_binary(
    name = "jspb_require_oti",
    deps = [":jspb_require_lib"],
)

closure_js_binary(
    name = "jspb_require_nti",
    defs = ["--new_type_inf"],
    deps = [":jspb_require_lib"],
)

genrule(
    name = "soy_jssrc_require",
    srcs = [
        "@soy_jssrc//:jspbconversions.js",
        "@soy_jssrc//:soydata_converters.js",
        "@soy_jssrc//:soyutils_usegoog.js",
    ],
    outs = ["soy_jssrc_require.js"],
    cmd = REQUIRE_ALL_COMMAND,
    visibility = ["//visibility:private"],
)

closure_js_library(
    name = "soy_jssrc_require_lib",
    srcs = ["soy_jssrc_require.js"],
    deps = ["//closure/templates:soy_jssrc"],
)

closure_js_binary(
    name = "soy_jssrc_require_oti",
    deps = [":soy_jssrc_require_lib"],
)

closure_js_binary(
    name = "soy_jssrc_require_nti",
    defs = ["--new_type_inf"],
    deps = [":soy_jssrc_require_lib"],
)
