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

function escapeXml(str) {
  return String(str)
      .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&apos;');
}

function writeXmlOutput(testRunner) {
  const xmlOutputFile = process.env.XML_OUTPUT_FILE;
  if (!xmlOutputFile) {
    return;
  }

  const suiteName = process.env.TEST_TARGET || 'Closure Unit Test';
  const resultsJson = testRunner.getTestResultsAsJson();
  const results = resultsJson ?
      JSON.parse(resultsJson) :
      (testRunner.isSuccess() ?
           {} :
           {globalErrors: [{message: testRunner.getReport(), stacktrace: ''}]});

  let testCount = 0;
  let failureCount = 0;
  let errorCount = 0;
  const testcaseLines = [];

  for (const [name, failures] of Object.entries(results)) {
    if (name === 'globalErrors') {
      for (const err of failures) {
        testCount++;
        errorCount++;
        const msg = err.message || 'Global error';
        const body = err.stacktrace ? `${msg}\n${err.stacktrace}` : msg;
        testcaseLines.push(
            `    <testcase name="globalError" classname="${escapeXml(suiteName)}">\n` +
            `      <error message="${escapeXml(msg)}">${escapeXml(body)}</error>\n` +
            `    </testcase>`);
      }
      continue;
    }

    testCount++;
    if (failures.length > 0) {
      failureCount++;
      const failureEls = failures.map((f) => {
        const msg = f.message || 'Test failed';
        const body = f.stacktrace ? `${msg}\n${f.stacktrace}` : msg;
        return `      <failure message="${escapeXml(msg)}">${escapeXml(body)}</failure>`;
      });
      testcaseLines.push(
          `    <testcase name="${escapeXml(name)}" classname="${escapeXml(suiteName)}">\n` +
          `${failureEls.join('\n')}\n` +
          `    </testcase>`);
    } else {
      testcaseLines.push(
          `    <testcase name="${escapeXml(name)}" classname="${escapeXml(suiteName)}"/>`);
    }
  }

  const totalTime = ((testRunner.getRunTime() || 0) / 1000).toFixed(3);
  const attrs = `tests="${testCount}" failures="${failureCount}" errors="${
      errorCount}" time="${totalTime}"`;
  const xml =
      '<?xml version="1.0" encoding="UTF-8"?>\n' +
      `<testsuites ${attrs}>\n` +
      `  <testsuite name="${escapeXml(suiteName)}" ${attrs}>\n` +
      (testcaseLines.length > 0 ? testcaseLines.join('\n') + '\n' : '') +
      '  </testsuite>\n' +
      '</testsuites>\n';

  fs.mkdirSync(path.dirname(xmlOutputFile), {recursive: true});
  fs.writeFileSync(xmlOutputFile, xml, 'utf8');
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
  window.document.title = 'Closure Unit Test';
  window.CLOSURE_NO_DEPS = true;
  window.CLOSURE_UNCOMPILED_DEFINES = {};

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

  for (const scriptPath of process.argv.slice(3)) {
    const scriptContent = fs.readFileSync(scriptPath, 'utf8');
    vm.runInContext(scriptContent, window, {filename: scriptPath});
  }

  if (typeof window.onload === 'function') {
    window.onload();
  }

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
      writeXmlOutput(testRunner);
      if (testRunner.isSuccess()) {
        process.exit(0);
      } else {
        console.error(testRunner.getReport());
        process.exit(1);
      }
    }
  }, 10);
})().catch((err) => {
  console.error(err);
  process.exit(1);
});
