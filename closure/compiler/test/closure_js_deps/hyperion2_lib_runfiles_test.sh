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

# when we add a closure_js_library() to our runfiles data=[...] we get:

# direct sources
[[ -e closure/compiler/test/closure_js_deps/hyperion2.js ]]

# transitive sources
[[ -e closure/compiler/test/closure_js_deps/hyperion.js ]]
[[ -e external/closure_library/closure/goog/base.js ]]

# direct data
[[ -e closure/compiler/test/closure_js_deps/data2.txt ]]

# transitive data
[[ -e closure/compiler/test/closure_js_deps/data1.txt ]]

# none of those internal-only files we generate
[[ ! -e closure/compiler/test/closure_js_deps/hyperion_lib-provided.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion_lib-stderr.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_lib-provided.txt ]]
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_lib-stderr.txt ]]

# and none of the stuff from the js binary we didn't reference
[[ ! -e closure/compiler/test/closure_js_deps/hyperion2_bin.js ]]
[[ ! -e closure/compiler/test/closure_js_deps/data3.txt ]]
