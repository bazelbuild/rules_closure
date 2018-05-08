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

/**
 * @fileoverview PhantomJS headless browser container harness. This program
 *     runs inside PhantomJS but not inside the browser itself. It starts an
 *     HTTP server that serves runfiles. It loads the generated test runner
 *     HTML file inside an ethereal browser. Once the page is loaded, this
 *     program communicates with the page to collect log data and monitor
 *     whether or not the tests succeeded.
 */

'use strict';

var webpage = /** @type {!phantomjs.WebPage} */ (require('webpage'));
var fs = /** @type {!phantomjs.FileSystem} */ (require('fs'));
var webserver = /** @type {!phantomjs.WebServer} */ (require('webserver'));
var system = /** @type {!phantomjs.System} */ (require('system'));


/**
 * Location of virtual test page.
 * @const
 */
var VIRTUAL_PAGE = '/index.html';


/**
 * Path under which runfiles are served.
 * @const
 */
var RUNFILES_PREFIX = '/filez/';


/**
 * Full URL of virtual page.
 * @type {string}
 */
var url;


/**
 * HTML for virtual test page, hosted under {@code index.html}.
 * @type {string}
 */
var virtualPageHtml;


/**
 * PhantomJS page object.
 * @type {!phantomjs.Page}
 */
var page;


/**
 * Local web server for serving runfiles.
 * @type {!phantomjs.Server}
 */
var server;


/**
 * Number of suspiciously failed runs.
 */
var flakes = 0;


/**
 * Guesses Content-Type header for `path`
 * @param {string} path
 * @return {string}
 */
function guessContentType(path) {
  switch (path.substr(path.lastIndexOf('.') + 1)) {
    case 'js':
      return 'application/javascript;charset=utf-8';
    case 'html':
      return 'text/html;charset=utf-8';
    case 'css':
      return 'text/css;charset=utf-8';
    case 'txt':
      return 'text/plain;charset=utf-8';
    case 'xml':
      return 'application/xml;charset=utf-8';
    case 'gif':
      return 'image/gif';
    case 'png':
      return 'image/png';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    default:
      return 'application/octet-stream';
  }
}


/**
 * Handles request from web browser.
 * @param {!phantomjs.Server.Request} request
 * @param {!phantomjs.Server.Response} response
 */
function onRequest(request, response) {
  var path = request.url;
  system.stderr.writeLine('Serving ' + path);
  if (path == VIRTUAL_PAGE) {
    response.writeHead(200, {
      'Cache': 'no-cache',
      'Content-Type': 'text/html;charset=utf-8'
    });
    response.write(virtualPageHtml);
    response.closeGracefully();
  } else if (path.indexOf(RUNFILES_PREFIX) == 0) {
    path = '../' + path.substr(RUNFILES_PREFIX.length);
    if (!fs.exists(path)) {
      send404(request, response);
      return;
    }
    var contentType = guessContentType(path);
    var mode = undefined;
    if (contentType.indexOf('charset') != -1) {
      response.setEncoding('binary');
      mode = 'b';
    }
    response.writeHead(200, {
      'Cache': 'no-cache',
      'Content-Type': contentType
    });
    response.write(fs.read(path, mode));
    response.closeGracefully();
  } else {
    send404(request, response);
  }
}


/**
 * Sends a 404 Not Found response.
 * @param {!phantomjs.Server.Request} request
 * @param {!phantomjs.Server.Response} response
 */
function send404(request, response) {
  system.stderr.writeLine('NOT FOUND ' + request.url);
  response.writeHead(404, {
    'Cache': 'no-cache',
    'Content-Type': 'text/plain;charset=utf-8'
  });
  response.write('Not Found');
  response.closeGracefully();
}


/**
 * Callback when log entries are emitted inside the browser.
 * @param {string} message
 * @param {?string} line
 * @param {?string} source
 */
function onConsoleMessage(message, line, source) {
  message = message.replace(/\r?\n/, '\n-> ');
  if (line && source) {
    system.stderr.writeLine('-> ' + source + ':' + line + '] ' + message);
  } else {
    system.stderr.writeLine('-> ' + message);
  }
}


/**
 * Callback when headless web page is loaded.
 * @param {string} status
 */
function onLoadFinished(status) {
  if (status != 'success') {
    system.stderr.writeLine('Load Failed: ' + status);
    retry();
  }
}


/**
 * Callback when webpage shows an alert dialog.
 * @param {string} message
 */
function onAlert(message) {
  system.stderr.writeLine('Alert: ' + message);
}


/**
 * Callback when headless web page throws an error.
 * @param {string} message
 * @param {!phantomjs.StackTrace} trace
 */
function onError(message, trace) {
  system.stderr.writeLine(message);
  trace.forEach(function(t) {
    var msg = '> ';
    if (t.function != '') {
      msg += t.function + ' at ';
    }
    msg += t.file + ':' + t.line;
    system.stderr.writeLine(msg);
  });
  page.close();
  phantom.exit(1);
}


/**
 * Callback when JavaScript inside page sends us a message.
 * @param {boolean} succeeded
 */
function onCallback(succeeded) {
  page.close();
  if (succeeded) {
    phantom.exit();
  } else {
    phantom.exit(1);
  }
}


/**
 * Tries again if there was a suspicious failure.
 */
function retry() {
  page.close();
  server.close();
  if (++flakes == 3) {
    system.stderr.writeLine('too many flakes; giving up');
    phantom.exit(1);
  }
  main();
}


/**
 * Attempts to run the test.
 */
function main() {
  // construct the web page
  var body = fs.read(system.args[1]);
  if (body.match(/^<!/)) {
    system.stderr.writeLine('ERROR: Test html file must not have a doctype');
    phantom.exit(1);
  }
  var html = ['<!doctype html>', body];
  html.push('<script>\n' +
      '  // goog.require does not need to fetch sources from the local\n' +
      '  // server because everything is being loaded explicitly below\n' +
      '  var CLOSURE_NO_DEPS = true;\n' +
      '  var CLOSURE_UNCOMPILED_DEFINES = {\n' +
      // TODO(hochhaus): Set goog.ENABLE_DEBUG_LOADER=false
      // https://github.com/google/closure-compiler/issues/1815
      // '    "goog.ENABLE_DEBUG_LOADER": false\n' +
      '  };\n' +
      '</script>\n');
  for (var i = 2; i < system.args.length; i++) {
    var js = system.args[i];
    html.push('<script src="' + RUNFILES_PREFIX + js + '"></script>\n');
  }
  virtualPageHtml = html.join('');

  // start a local webserver
  var port = Math.floor(Math.random() * (60000 - 32768)) + 32768;
  server = webserver.create();
  server.listen('127.0.0.1:' + port, onRequest);
  url = 'http://localhost:' + port + VIRTUAL_PAGE;
  system.stderr.writeLine('Listening ' + url);

  // run the web page
  page = webpage.create();
  page.onAlert = onAlert;
  page.onCallback = onCallback;
  page.onConsoleMessage = onConsoleMessage;
  page.onError = onError;
  page.onLoadFinished = onLoadFinished;
  // XXX: If PhantomJS croaks, fail sooner rather than later.
  //      https://github.com/ariya/phantomjs/issues/10652
  page.settings.resourceTimeout = 2000;
  page.open(url);
}


main();
