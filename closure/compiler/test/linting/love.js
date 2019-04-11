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

goog.provide('Love');



/**
 * Love.
 * @param {number} a
 * @param {number} b
 * @constructor
 * @final
 */
Love = function (a, b) {

  /**
   * @private {number}
   */
  this.a_ = a;

  /**
   * Oops I forgot to mark this private, despite the underscore.
   * @type {number}
   */
  this.b_ = b;
}


/**
 * Sum.
 * @return {number}
 */
Love.prototype.result = function() {
  return this.a_ + this.b_;
};


// I'm not documented!
Love.prototype.mystery = function() {};
