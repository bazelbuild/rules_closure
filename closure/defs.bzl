# -*- mode: python; -*-
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

load("//closure/compiler:closure_js_binary.bzl", "closure_js_binary")
load("//closure/compiler:closure_js_deps.bzl", "closure_js_deps")
load("//closure/compiler:closure_js_library.bzl", "closure_js_library")
load("//closure:repositories.bzl", "closure_repositories")
load("//closure/stylesheets:closure_css_binary.bzl", "closure_css_binary")
load("//closure/stylesheets:closure_css_library.bzl", "closure_css_library")
load("//closure/testing:closure_js_test.bzl", "closure_js_test")
load("//closure/testing:phantomjs_test.bzl", "phantomjs_test")
load("//closure/templates:closure_template_java_library.bzl", "closure_template_java_library")
load("//closure/templates:closure_template_js_library.bzl", "closure_template_js_library")
load("//protobuf:closure_proto_js_library.bzl", "closure_proto_js_library")
