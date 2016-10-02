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

set -ex

# when we add a closure_js_binary() to our runfiles data=[...] we get:

# the compiled binary and source map
[[ -e closure/compiler/test/closure_js_deps/hyperion2_bin.js ]]
[[ -e closure/compiler/test/closure_js_deps/hyperion2_bin.js.map ]]

# the raw sources which are referenced by the .js.map
[[ -e external/closure_library/closure/goog/base.js ]]
[[ -e closure/compiler/test/closure_js_deps/hyperion.js ]]
[[ -e closure/compiler/test/closure_js_deps/hyperion2.js ]]

# none of the internal-only files we generate (same as closure_js_library)
[[ ! -e closure/compiler/test/closure_js_deps/hyperion_lib-provided.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion_lib-stderr.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_lib-provided.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_lib-stderr.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_bin-provided.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_bin-stderr.txt ]]

# but we still get the full transitive closure of data=[...] stuff
[[ -e closure/compiler/test/closure_js_deps/data1.txt ]]
[[ -e closure/compiler/test/closure_js_deps/data2.txt ]]
[[ -e closure/compiler/test/closure_js_deps/data3.txt ]]
