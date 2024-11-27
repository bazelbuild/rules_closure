/**
 * @license
 * Copyright The Closure Library Authors.
 * SPDX-License-Identifier: Apache-2.0
 */

goog.module('goog.testing.pending');

/**
 * Skips the current test, without marking it as failed.
 *
 * You can call this method from `setUp()` or similar methods to skip the test
 * entirely or call it from inside a test method to skip the rest of the test.
 */
function pending() {
  if ('jasmine' in window) {
    window['pending']();
    return;
  }
  throw new TestMarkedAsPending('Test was marked as pending');
}

class TestMarkedAsPending extends Error {}

exports = {
  pending,
  TestMarkedAsPending
};