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

goog.module('io.bazel.rules.closure.GreeterIdomProto');

const idom = goog.require('incrementaldom');
const greeter = goog.require('io.bazel.rules.closure.soy.greeter.incrementaldom');
const Person = goog.require('proto.io.bazel.rules.closure.soy.Person');



exports = class GreeterIdomProto {
  /**
   * Greeter page.
   * @param {string} name Name of person to greet.
   */
  constructor(name) {
    /**
     * Name of person to greet.
     * @private {string}
     * @const
     */
    this.name_ = name;
  }

  /**
   * Renders HTML greeting as document body.
   */
  greet() {
    var person = new Person();
    person.setName(this.name_);
    idom.patchInner(/** @type {!Element} */ (goog.global.document.body),
                    greeter.greet, {person: person});
  }
};
