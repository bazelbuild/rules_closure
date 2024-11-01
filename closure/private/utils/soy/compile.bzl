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

load("//closure/private:providers.bzl", "SoyInfo")

def compile(
        actions,
        closure_toolchain,
        srcs,
        output,
        deps = [],
        proto_descriptor_sets = depset()):
    """Compiles Soy source files into an intermediate build artifact and returns
    a provider that represents the results of the compilation and can be added
    to the set of providers emitted by this rule.

    Compiling the source files that represent a single library into an
    intermediate build artifact that later compilations can use in preference to
    parsing dependencies improves overall compiler performance by making builds
    more cacheable.

    Args:
      actions: Required. Instance of `ctx.actions`.
      closure_toolchain: Required. The toolchain used to find the
          SoyHeaderCompiler binary.
      srcs: Required. A list of the Soy source files to be compiled.
      output: Required. The output intermediate build artifact.
      deps: Optional. A list of `ClosureTemplateInfo` of (direct) dependencies.
      proto_descriptor_sets:
    Returns:
      An instance of `SoyInfo`.
    """

    # TODO(yannic): Add support for dependency pruning.

    # TODO(yannic): Add support for `--cssMetadataOutput`.

    args = actions.args()

    args.add("--output", output)
    args.add_all(srcs, before_each = "--srcs")

    direct_deps = depset(
        direct = [],
        transitive = [dep.direct_headers for dep in deps],
    )
    args.add_all(direct_deps, before_each = "--depHeaders")

    indirect_deps = depset(
        direct = [],
        transitive = [dep.indirect_headers for dep in deps],
    )
    args.add_all(indirect_deps, before_each = "--indirectDepHeaders")

    proto_descriptors = depset(
        direct = [],
        transitive = [proto_descriptor_sets] + [dep.proto_descriptor_sets for dep in deps],
    )
    args.add_all(proto_descriptors, before_each = "--protoFileDescriptors")

    actions.run(
        executable = closure_toolchain.soy.header_compiler,
        inputs = depset(
            direct = srcs,
            transitive = [direct_deps, indirect_deps, proto_descriptors],
        ),
        outputs = [output],
        arguments = [args],
    )

    return SoyInfo(
        direct_headers = depset([output]),
        direct_sources = depset(srcs),
        indirect_headers = depset(
            direct = [],
            transitive = [direct_deps, indirect_deps],
        ),
        indirect_sources = depset(
            direct = [],
            transitive = [dep.indirect_sources for dep in deps] +
                         [dep.direct_sources for dep in deps],
        ),
        proto_descriptor_sets = proto_descriptor_sets,
    )
