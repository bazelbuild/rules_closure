// Copyright 2018 The Closure Rules Authors. All rights reserved.
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

goog.module('io.bazel.rules.closure.protobuf.Foo');

const PbFoo = goog.require('proto.io.bazel.rules.closure.protobuf.Foo');



exports = class {
  /**
   * Creates a new Foo.
   *
   * @param {string} field Value to set for "field".
   */
  constructor(field) {
    /**
     * @private
     * @const {!PbFoo}
     */
    this.message_ = new PbFoo();
    this.message_.setFoo(field);
  }


  /**
   * Return value of "field".
   *
   * @return {string}
   */
  field() {
    return this.message_.getFoo();
  }
};
