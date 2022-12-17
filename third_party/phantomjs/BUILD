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

package(default_visibility = ["//visibility:public"])

licenses(["restricted"])

sh_binary(
    name = "phantomjs",
    testonly = True,
    srcs = ["phantomjs.sh"],
    data = [
        "bin/phantomjs",
        "//third_party/expat:libexpat_k8",
        "//third_party/fontconfig:config",
        "//third_party/fontconfig:libfontconfig_k8",
        "//third_party/freetype:libfreetype_k8",
        "//third_party/openssl:files",
        "//third_party/png:libpng_k8",
    ],
)

genrule(
    name = "phantomjs_bin",
    testonly = True,
    srcs = ["@phantomjs//file"],
    outs = ["bin/phantomjs"],
    cmd = " && ".join([
        "IN=$$(pwd)/$(SRCS)",
        "OUT=$$(pwd)/$@",
        "TMP=$$(mktemp -d $${TMPDIR:-/tmp}/genrule.XXXXXXXXXX)",
        "cd $$TMP",
    ]) + select({
        ":darwin": " && unzip -q $$IN && ",
        "//conditions:default": " && tar -xjf $$IN && ",
    }) + " && ".join([
        "mv */bin/phantomjs $$OUT",
        "rm -rf $$TMP",
    ]),
    executable = True,
    visibility = ["//visibility:private"],
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:private"],
)
