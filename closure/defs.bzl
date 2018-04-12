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

load("//closure/compiler:closure_js_aspect.bzl", "closure_js_aspect")
load("//closure/compiler:closure_js_binary.bzl", "closure_js_binary")
load("//closure/compiler:closure_js_deps.bzl", "closure_js_deps")
load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure/private:files_equal_test.bzl", "files_equal_test")
load("//closure/protobuf:closure_js_proto_library.bzl", "closure_js_proto_library")
load("//closure/protobuf:closure_proto_library.bzl", "closure_proto_library")
load("//closure/stylesheets:closure_css_binary.bzl", "closure_css_binary")
load("//closure/stylesheets:closure_css_library.bzl", "closure_css_library")
load("//closure/templates:closure_java_template_library.bzl", "closure_java_template_library")
load("//closure/templates:closure_js_template_library.bzl", "closure_js_template_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")
load("//closure/testing:phantomjs_test.bzl", "phantomjs_test")
load("//closure:filegroup_external.bzl", "filegroup_external")
load("//closure:repositories.bzl", "closure_repositories")
load("//closure:webfiles/web_library.bzl", "web_library")
load("//closure:webfiles/web_library_external.bzl", "web_library_external")
