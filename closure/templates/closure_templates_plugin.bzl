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

SoyPluginInfo = provider(
    doc = "provides the module and java_library implementing this plugin",
)

def _impl(ctx):
    return [SoyPluginInfo(
        generator = struct(
            module = ctx.attr.module,
            runtime = java_common.merge([dep[JavaInfo] for dep in ctx.attr.deps]),
        ),
    )]

closure_templates_plugin = rule(
    implementation = _impl,
    doc = "a closure templates plugin providing user-defined functions",
    attrs = {
        "module": attr.string(
            doc = "fully-qualified class name of extension module",
            mandatory = True,
        ),
        "deps": attr.label_list(
            doc = "java_library rules providing the specified class name",
            providers = [JavaInfo],
            mandatory = True,
        ),
    },
    provides = [SoyPluginInfo],
)
