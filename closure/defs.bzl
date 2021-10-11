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

load("//closure/compiler:closure_js_aspect.bzl", _closure_js_aspect = "closure_js_aspect")
load("//closure/compiler:closure_js_binary.bzl", _closure_js_binary = "closure_js_binary")
load("//closure/compiler:closure_js_library.bzl", _closure_js_library = "closure_js_library", _create_closure_js_library = "create_closure_js_library")
load("//closure/private:defs.bzl", _CLOSURE_JS_TOOLCHAIN_ATTRS = "CLOSURE_JS_TOOLCHAIN_ATTRS")
load("//closure/private:files_equal_test.bzl", _files_equal_test = "files_equal_test")
load("//closure/protobuf:closure_js_proto_library.bzl", _closure_js_proto_library = "closure_js_proto_library")
load("//closure/protobuf:closure_proto_library.bzl", _closure_proto_library = "closure_proto_library")
load("//closure/stylesheets:closure_css_binary.bzl", _closure_css_binary = "closure_css_binary")
load("//closure/stylesheets:closure_css_library.bzl", _closure_css_library = "closure_css_library")
load("//closure/templates:closure_java_template_library.bzl", _closure_java_template_library = "closure_java_template_library")
load("//closure/templates:closure_js_template_library.bzl", _closure_js_template_library = "closure_js_template_library")
load("//closure/templates:closure_templates_plugin.bzl", _closure_templates_plugin = "closure_templates_plugin")
load("//closure/testing:closure_js_test.bzl", _closure_js_test = "closure_js_test")
load("//closure/testing:phantomjs_test.bzl", _phantomjs_test = "phantomjs_test")
load("//closure:filegroup_external.bzl", _filegroup_external = "filegroup_external")
load("//closure:webfiles/web_library.bzl", _web_library = "web_library")
load("//closure:webfiles/web_library_external.bzl", _web_library_external = "web_library_external")

closure_js_aspect = _closure_js_aspect
closure_js_binary = _closure_js_binary
closure_js_library = _closure_js_library
create_closure_js_library = _create_closure_js_library
CLOSURE_JS_TOOLCHAIN_ATTRS = _CLOSURE_JS_TOOLCHAIN_ATTRS
files_equal_test = _files_equal_test
closure_js_proto_library = _closure_js_proto_library
closure_proto_library = _closure_proto_library
closure_css_binary = _closure_css_binary
closure_css_library = _closure_css_library
closure_java_template_library = _closure_java_template_library
closure_js_template_library = _closure_js_template_library
closure_templates_plugin = _closure_templates_plugin
closure_js_test = _closure_js_test
phantomjs_test = _phantomjs_test
filegroup_external = _filegroup_external
web_library = _web_library
web_library_external = _web_library_external
