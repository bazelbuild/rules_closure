#!/bin/bash
# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -euo pipefail

tag="$1"
# GITHUB_REPOSITORY looks like user/repository_name, let strip the user part.
repository=${GITHUB_REPOSITORY#*/}
# The prefix is used to determine the directory structure of the archive. We
# strip the 'v'prefix from the version number.
directory="${repository}-${tag#v}"
archive="${repository}-${tag}.tar.gz"

git archive --format="tar.gz" --prefix=${directory}/ -o "${archive}" ${tag}

# Replace hyphens with underscores in the repository name to match our Bazel
# module naming conventions.
bazel_module_name="${repository//-/_}"
# The stdout of this program will be used as the top of the release notes for
# this release.
cat << EOF
## Using Bazel 8 or later, add to your \`MODULE.bazel\` file:

\`\`\`starlark
bazel_dep(name = "${bazel_module_name}", version = "${tag#v}")
\`\`\`
EOF
