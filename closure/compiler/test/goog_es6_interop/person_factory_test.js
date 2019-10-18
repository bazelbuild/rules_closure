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

// This is not expected to work for namespaces declared by `goog.provide`.
// https://github.com/google/closure-compiler/wiki/Migrating-from-goog.modules-to-ES6-modules
goog.module('rulesClosure.googEs6Interop.PersonFactoryTest');

const testSuite = goog.require('goog.testing.testSuite');
const {createPerson} = goog.require('rulesClosure.googEs6Interop.personFactory');



class PersonFactoryTest {
  /** @return {void} */
  testPersonFactory() {
    const person = createPerson('rules CLOSURE');
    assertNotNull(person);
    assertEquals('Rules', person.firstName());
    assertEquals('Closure', person.lastName());
  }
}
testSuite(new PersonFactoryTest());
