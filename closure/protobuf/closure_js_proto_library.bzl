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

"""Utilities for building JavaScript Protocol Buffers.
"""

load("//closure/compiler:closure_js_library.bzl", "closure_js_library")

def _collect_includes(srcs):
    includes = ["."]
    for src in srcs:
        include = ""
        if src.startswith("@"):
            include = Label(src).workspace_root
        if include and not include in includes:
            includes += [include]
    return includes

def closure_js_proto_library(
        name,
        srcs,
        suppress = [],
        add_require_for_enums = 0,
        testonly = None,
        binary = 1,
        import_style = None,
        protocbin = Label("@com_google_protobuf//:protoc"),
        **kwargs):
    cmd = ["$(location %s)" % protocbin]
    js_out_options = ["library=%s" % name]
    if add_require_for_enums:
        js_out_options += ["add_require_for_enums"]
    if testonly:
        js_out_options += ["testonly"]
    if binary:
        js_out_options += ["binary"]
    if import_style:
        js_out_options += ["import_style=%s" % import_style]

    cmd += ["-I%s" % i for i in _collect_includes(srcs)]
    cmd += ["--js_out=%s:$(@D)" % ",".join(js_out_options)]
    cmd += ["--descriptor_set_out=$(@D)/%s.descriptor" % name]
    cmd += ["$(locations " + src + ")" for src in srcs]

    native.genrule(
        name = name + "_gen",
        srcs = srcs,
        testonly = testonly,
        visibility = ["//visibility:private"],
        message = "Generating JavaScript Protocol Buffer file",
        outs = [name + ".js", name + ".descriptor"],
        tools = [protocbin],
        cmd = " ".join(cmd),
    )

    closure_js_library(
        name = name,
        srcs = [name + ".js"],
        testonly = testonly,
        deps = [
            str(Label("@com_google_javascript_closure_library//closure/goog/array")),
            str(Label("//closure/protobuf:jspb")),
        ],
        internal_descriptors = [name + ".descriptor"],
        suppress = suppress + [
            "missingProperties",
            "unusedLocalVariables",
        ],
        lenient = True,
        **kwargs
    )
