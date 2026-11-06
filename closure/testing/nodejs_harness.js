// Copyright 2026 The Closure Rules Authors. All rights reserved.
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
 * @fileoverview Node.js test harness for Closure JsUnit tests.
 */

'use strict';

const fs = require('fs');
const nodeModule = require('module');
const path = require('path');
const url = require('url');
const vm = require('vm');

// Redirect happy-dom's 'whatwg-mimetype' import to Node's built-in util.MIMEType.
const loaderCode = `
export async function resolve(specifier, context, nextResolve) {
  if (specifier === 'whatwg-mimetype') {
    return {
      shortCircuit: true,
      url: 'data:text/javascript,' + encodeURIComponent(
        'import {MIMEType} from "node:util";' +
        'export default {parse: (s) => { try { return new MIMEType(s); } catch { return null; } }};'
      ),
    };
  }
  return nextResolve(specifier, context);
}
`;
nodeModule.register(
    'data:text/javascript,' + encodeURIComponent(loaderCode),
    url.pathToFileURL(__filename));


function loadScripts(window, scripts) {
  for (const scriptPath of scripts) {
    const scriptContent = fs.readFileSync(scriptPath, 'utf8');
    vm.runInContext(scriptContent, window, {filename: scriptPath});
  }

  // Trigger the window onload handler, if any is present.
  if (typeof window.onload === 'function') {
    window.onload();
  }
}

function installUncaughtExceptionHandlers(window) {
  function handleUncaughtError(err) {
    const message = err && err.message ? err.message : String(err);
    if (typeof window.onerror === 'function') {
      window.onerror(message, '', 0, 0, err);
    } else {
      console.error(err);
      process.exit(1);
    }
  }

  process.on('uncaughtException', handleUncaughtError);
  process.on('unhandledRejection', handleUncaughtError);
}

  // Should be kept in sync with gen_webtest_html.
function configureClosure(window) {
  // goog.require does not need to fetch sources from the local
  // server because everything is compiled and loaded explicitly below.
  window.CLOSURE_NO_DEPS = true;
  window.CLOSURE_UNCOMPILED_DEFINES = {};
}

function pollForResults(window) {
  const pollInterval = setInterval(() => {
    const testRunner = window.G_testRunner;
    if (!testRunner) {
      console.error(
          "ERROR: G_testRunner not defined. Did you remember to goog.require('goog.testing.jsunit')?");
      clearInterval(pollInterval);
      process.exit(1);
    }
    if (testRunner.isFinished()) {
      clearInterval(pollInterval);
      if (testRunner.isSuccess()) {
        process.exit(0);
      } else {
        console.error(testRunner.getReport());
        process.exit(1);
      }
    }
  }, 10);
}

(async () => {
  const happyDomEntry = path.resolve(process.argv[2]);
  const {Window} = await import(url.pathToFileURL(happyDomEntry).href);

  const window = new Window({
    url: 'http://localhost/test.html',
    console,
    settings: {
      disableErrorCapturing: true,
    },
  });

  installUncaughtExceptionHandlers(window);
  configureClosure(window);
  loadScripts(window, process.argv.slice(3));
  pollForResults(window);
})().catch((err) => {
  console.error(err);
  process.exit(1);
});
