// Copyright 2019 The Closure Rules Authors. All rights reserved.
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

/**
 * @fileoverview A person, implementes as ES6 module.
 */

import {capitalize} from 'goog:goog.string';

/**
 * Represents a person.
 */
export class Person {
  /**
   * Constructs a new `Person`.
   *
   * @param {string} firstName
   * @param {string} lastName
   */
  constructor(firstName, lastName) {
    /** @private @const {string} */
    this.firstName_ = capitalize(firstName);

    /** @private @const {string} */
    this.lastName_ = capitalize(lastName);
  }

  /**
   * Returns the first name of the person.
   *
   * @return {string}
   */
  firstName() {
    return this.firstName_;
  }

  /**
   * Returns the last name of the person.
   *
   * @return {string}
   */
  lastName() {
    return this.lastName_;
  }
}
