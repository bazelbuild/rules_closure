// Copyright 2020 The Closure Rules Authors. All rights reserved.
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

import testSuite from 'goog:goog.testing.testSuite';



/**
 * @param {!Object<string, *>} obj
 * @param {!Array<string>} namespaces
 * @return {!Object<string, *>}
 */
function getNamespaceInternal(obj, namespaces) {
  if (namespaces.length < 1) {
    return obj;
  }

  const ns = namespaces[0];
  const newObj = /** @type {undefined|!Object<string, *>} */ (obj[ns]);
  assertTrue(undefined !== newObj);
  return getNamespaceInternal(
      /** @type {!Object<string, *>} */ (newObj), namespaces.slice(1));
}


/**
 * @return {!Object<string, *>}
 */
function getNamespace() {
  return getNamespaceInternal(window, ['io', 'bazel', 'rules', 'closure']);
}


class GoogExportedFunctionWillGoInBinaryTest {
  /** @return {void} */
  test_myNameWillBeMinified() {
    const namespace = getNamespace();
    assertTrue(undefined === namespace['myNameWillBeMinified']);
  }

  /** @return {void} */
  test_iWillGoIntoTheBinary() {
    const namespace = getNamespace();
    assertTrue("function" === typeof namespace['iWillGoIntoTheBinary']);
  }

  /** @return {void} */
  test_iWillGetPrunedByTheCompiler() {
    const namespace = getNamespace();
    assertTrue(undefined === namespace['iWillGetPrunedByTheCompiler']);
  }
}
testSuite(new GoogExportedFunctionWillGoInBinaryTest());
