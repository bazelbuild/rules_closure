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

load(
    "//closure/private:defs.bzl",
    "CLOSURE_WORKER_ATTR",
    "JS_FILE_TYPE",
    "collect_js",
    "collect_runfiles",
    "convert_path_to_es6_module_name",
    "find_js_module_roots",
    "get_jsfile_path",
    "make_jschecker_progress_message",
    "unfurl",
)

def _closure_js_aspect_impl(target, ctx):
    if hasattr(target, "closure_js_library"):
        return struct()

    # This aspect is currently a no-op in the open source world. We intend to add
    # content to it in the future. It is still provided to ensure the Skylark API
    # is well defined.
    return struct()

closure_js_aspect = aspect(
    implementation = _closure_js_aspect_impl,
    attr_aspects = ["deps", "sticky_deps", "exports"],
    attrs = {"_ClosureWorkerAspect": CLOSURE_WORKER_ATTR},
)
