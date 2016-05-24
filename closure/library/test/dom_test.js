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

goog.setTestOnly();

goog.require('goog.dom');
goog.require('goog.dom.TagName');
goog.require('goog.html.SafeHtml');
goog.require('goog.testing.asserts');
goog.require('goog.testing.jsunit');
goog.require('goog.testing.testSuite');

goog.testing.testSuite({

  'setUp': function() {
    goog.dom.appendChild(
        goog.global.document.body,
        goog.dom.safeHtmlToNode(
            goog.html.SafeHtml.create(
                goog.dom.TagName.DIV,
                {'id': 'hello'},
                'Hello World!')));
  },

  'testGetElement': function() {
    assertNotNull(goog.dom.getElement('hello'));
  },

  'testGetTextContent': function() {
    assertEquals('Hello World!',
                 goog.dom.getTextContent(
                     goog.dom.getRequiredElement('hello')));
  },

  'testHtml': function() {
    assertHTMLEquals('<div id="hello">Hello World!</div>',
                     goog.dom.getRequiredElement('hello').outerHTML);
  }

});  // goog.testing.testSuite
