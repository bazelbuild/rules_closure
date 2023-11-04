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

# ProTip: You can uncomment these lines to debug loading:
#         export LD_DEBUG="files"
#         export FC_DEBUG="1024"

if [[ -d "$0.runfiles" ]]; then
  RUNFILES="$0.runfiles/"
else
  RUNFILES="${PWD}/"
fi

export LD_LIBRARY_PATH="${RUNFILES}/third_party/fontconfig/k8:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${RUNFILES}/third_party/freetype/k8:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${RUNFILES}/third_party/expat/k8:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${RUNFILES}/third_party/png/k8:${LD_LIBRARY_PATH}"

export OPENSSL_CONF=/etc/ssl/

export FONTCONFIG_PATH="${RUNFILES}/third_party/fontconfig"
export XDG_DATA_HOME="${RUNFILES}"
export XDG_CACHE_HOME="$(mktemp -d "${TMPDIR:-/tmp}/fontcache.XXXXXXXXXX")"
export OPENSSL_CONF="${RUNFILES}/third_party/openssl/openssl.cnf"

"${RUNFILES}/third_party/phantomjs/bin/phantomjs" "$@"
rc="$?"
rm -rf "${XDG_CACHE_HOME}"
exit "${rc}"
