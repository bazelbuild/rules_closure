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
 * @fileoverview A factory function for `Person`, implemented as ES6 module
 * declaring a goog module id so it can be `goog.require`d.
 */

goog.declareModuleId('rulesClosure.googEs6Interop.personFactory');

import {Person} from '/closure/compiler/test/goog_es6_interop/person.js';
import {assert} from 'goog:goog.asserts';

/**
 * Creates a new `Person`.
 *
 * @param {string} name
 * @return {!Person}
 */
export const createPerson = (name) => {
  const pieces = name.split(' ');
  assert(2 === pieces.length);
  return new Person(pieces[0], pieces[1]);
};
