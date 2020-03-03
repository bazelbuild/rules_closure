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

"""Repository rule to generate BUILD files for closure-library.

This script produces a build rule for each file in the Closure Library.
"""

import io
import os
import sys

_ROOT_BUILD_TEMPLATE = u"""

# Export all `.js` files for now.
exports_files(glob(["**/*.js"]))

filegroup(
    name = "css_files",
    srcs = glob(["closure/goog/css/**/*.css"]),
    visibility = ["//visibility:public"],
)

py_library(
    name = "build_source",
    srcs = ["closure/bin/build/source.py"],
    visibility = ["//visibility:public"],
)

py_library(
    name = "build_treescan",
    srcs = ["closure/bin/build/treescan.py"],
    visibility = ["//visibility:public"],
)

py_binary(
    name = "depswriter",
    srcs = ["closure/bin/build/depswriter.py"],
    main = "closure/bin/build/depswriter.py",
    deps = [
        ":build_source",
        ":build_treescan",
    ],
    visibility = ["//visibility:public"],
)
"""


def main(argv):
  if len(argv) != 1:
    print("Usage: closure_library_repository.py <path/to/root/BUILD.bazel>")
    return 1

  root_build_file = argv[0]
  if os.path.exists(root_build_file):
    print('This version of closure-library already has BUILD files.')
    return 0

  with io.open(root_build_file, 'w') as f:
    f.write(_ROOT_BUILD_TEMPLATE.strip())

  return 0


if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
