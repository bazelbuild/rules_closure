#!/bin/bash
#
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

# clang-format's intended use case is to automatically reformat source files
# without need for human intervention. Therefore the primary means of source
# code formatting should be performed automatically from the editor. This
# script checks returns success if no reformatting is required. However, if
# reformatting is required an error is returned. In this case, the source file
# is _not_ reformatted. Instead, the user must invoke clang-format (possibly
# via their editor) in order for the source input file to be formatted.

set -e
set -u

$1 -style=Google -output-replacements-xml "${@:3}" | \
    { grep "<replacement " || true; } > $2;

if [[ -s "$2" ]]; then
  echo "Source files do not follow Google coding conventions."
  echo "It is recomended that you configure your editor to ensure that all"
  echo "files are formatted correctly at save. For details, see:"
  echo "https://github.com/bazelbuild/rules_closure#source-code-formatting"
  echo "Malformed files: ${@:3}";
  exit 1;
fi
