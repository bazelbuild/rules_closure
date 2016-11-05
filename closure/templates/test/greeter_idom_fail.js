// Copyright 2016 The Closure Rules Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

goog.module('io.bazel.rules.closure.GreeterIdomFail');

const greeter = goog.require('io.bazel.rules.closure.soy.greeter.incrementaldom');
const idom = goog.require('incrementaldom');

idom.patchInner(
    /** @type {!Element} */ (goog.global.document.body),
    greeter.greet,
    // This code will fail to compile because the `greet` template in
    // greeter_idom.soy requires a `name` parameter which is not specified in
    // the object below.
    {});
