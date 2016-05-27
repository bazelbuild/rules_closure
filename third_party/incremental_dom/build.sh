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

# Upstream Incremental DOM is written using ES6 modules. A gulp file is also
# included which uses Rollup to generate a goog.module() style closure-library
# compatible file:
#
#   https://github.com/google/incremental-dom/blob/master/gulpfile.js
#
# To avoid the runtime dependencies on gulp/node/rollup/etc this script
# converts upstream Incremental DOM ES6 sources into a goog.module() version.
# Therefore, the upstream gulpfile.js need not be used. This script must be
# kept up to date with the "js-closure" target when updating incremental_dom.

set -e
set -u

tar xfz $1 --strip 1;

echo "goog.module('incrementaldom');" > $2;

cat src/util.js \
    src/node_data.js \
    src/symbols.js \
    src/attributes.js \
    src/nodes.js \
    src/notifications.js \
    src/context.js \
    src/assertions.js \
    src/core.js \
    src/virtual_elements.js | \
    tr '\n' '\r' | \
    sed 's/export [^;]*;//g' | \
    sed 's/import [^;]*;//g' | \
    sed "s/process.env.NODE_ENV/'undefined'/g" | \
    sed 's/const elementOpen /const coreElementOpen /' | \
    sed 's/const elementClose /const coreElementClose /' | \
    sed 's/const text /const coreText /' | \
    tr '\r' '\n' >> $2;

cat index.js | \
    sed 's/export { \([^ ]*\) } from [^;]*;/  \1/' | \
    grep "^  " | \
    sed 's/,$//' | \
    sed 's/^  \([^ ]*\) as \([^ ]*\)$/exports\.\2 = \1;/' | \
    sed 's/^  \([^ ]*\)$/exports\.\1 = \1;/' >> $2;
