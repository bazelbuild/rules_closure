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

goog.provide('io.bazel.rules.closure.protobuf.Example');

goog.require('proto.io.bazel.rules.closure.protobuf.Message');



/**
 * Example page.
 * @param {string} field Value to set for "field".
 * @constructor
 * @final
 */
io.bazel.rules.closure.protobuf.Example = function(field) {

  /**
   * Message
   * @private {!proto.io.bazel.rules.closure.protobuf.Message}
   * @const
   */
  this.message_ = new proto.io.bazel.rules.closure.protobuf.Message();
  this.message_.setFoo(field);
};


/**
 * Return value of "field".
 * @return {string}
 */
io.bazel.rules.closure.protobuf.Example.prototype.field = function() {
  return this.message_.getFoo();
};
