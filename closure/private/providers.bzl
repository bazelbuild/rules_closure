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

SoyInfo = provider(
    doc = "Encapsulates information provided by soy_library.",
    fields = {
        "direct_headers": "A set of soy header files of the direct sources. " +
                          "If the library is a proxy library that has no " +
                          "sources, it contains the direct_headers from this " +
                          "library's direct deps.",
        "direct_sources": "A set of soy sources from the 'srcs' attribute.",
        "proto_descriptor_sets": "A set of FileDescriptorSet files of all " +
                                 "dependent proto_library rules.",
        "indirect_headers": "A set of soy header files from all dependent " +
                            "soy_library rules, but excluding direct headers.",
        "indirect_sources": "A set of soy sources of all dependent" +
                            "soy_library rules, but excluding direct sources.",
    },
)
