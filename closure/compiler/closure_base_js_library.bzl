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

"""Internal-only build definition for a Closure JS library containing Closure base."""

load("//closure/compiler:closure_js_library.bzl", "create_closure_js_library")
load("//closure/private:defs.bzl", "CLOSURE_WORKER_ATTR", "JS_FILE_TYPE", "UNUSABLE_TYPE_DEFINITION")

def _closure_base_js_library(ctx):
    if not ctx.files.srcs:
        fail("Must provide sources")

    return create_closure_js_library(ctx, ctx.files.srcs)

# Only usable to create a closure js library for base.js
closure_base_js_library = rule(
    implementation = _closure_base_js_library,
    attrs = {
        "srcs": attr.label_list(allow_files = JS_FILE_TYPE),
        "_ClosureWorker": CLOSURE_WORKER_ATTR,
        # Leave empty to avoid circular dependencies
        "_closure_library_base": attr.label_list(default = []),
        "_unusable_type_definition": UNUSABLE_TYPE_DEFINITION,
    },
)
