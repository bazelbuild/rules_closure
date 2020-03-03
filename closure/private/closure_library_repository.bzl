# Copyright 2020 The Closure Rules Authors. All rights reserved.
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

"""Repository rule to generate BUILD files for closure-library."""

def _closure_library_repository(repository_ctx):
    repository_ctx.download_and_extract(
        url = repository_ctx.attr.urls,
        sha256 = repository_ctx.attr.sha256,
        stripPrefix = repository_ctx.attr.strip_prefix,
    )

    generator = repository_ctx.path(repository_ctx.attr._generator)
    root_build_file = repository_ctx.path("BUILD.bazel")

    repository_ctx.report_progress("Generating BUILD files")
    result = repository_ctx.execute(["python", generator, root_build_file])
    if result.return_code != 0:
        # buildifier: disable=print
        print("\n".join([
            "",
            "Generating BUILD files for closure library failed:",
            "stdout:",
            "  " + result.stdout.replace("\n", "\n  "),
            "stderr:",
            "  " + result.stderr.replace("\n", "\n  "),
        ]))

closure_library_repository = repository_rule(
    implementation = _closure_library_repository,
    attrs = {
        "urls": attr.string_list(
            mandatory = True,
        ),
        "sha256": attr.string(
            mandatory = True,
        ),
        "strip_prefix": attr.string(
            mandatory = False,
        ),
        "_generator": attr.label(
            default = "@io_bazel_rules_closure//closure/private:closure_library_repository.py",
        ),
    },
)
