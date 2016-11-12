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
 * @fileoverview External definition for subset of PhantomJS API.
 * @externs
 * @see http://phantomjs.org/api/
 */


/**
 * Fake namespace for PhantomJS types.
 */
const phantomjs = {};


/**
 * @record
 * @see https://github.com/ariya/phantomjs/blob/master/examples/stdin-stdout-stderr.js
 */
phantomjs.File = class {

  /**
   * @param {string} text
   * @const
   */
  write(text) {}

  /**
   * @param {string} text
   * @const
   */
  writeLine(text) {}
};


/**
 * @record
 * @see http://phantomjs.org/api/system/
 */
phantomjs.System = class {};

/**
 * @type {!Array<string>}
 * @const
 */
phantomjs.System.prototype.args;

/**
 * @type {!phantomjs.File}
 * @const
 */
phantomjs.System.prototype.stdout;

/**
 * @type {!phantomjs.File}
 * @const
 */
phantomjs.System.prototype.stderr;


/**
 * @record
 * @see http://phantomjs.org/api/fs/
 */
phantomjs.FileSystem = class {

  /**
   * @param {string} path
   * @return {boolean}
   * @const
   */
  exists(path) {}

  /**
   * @param {string} path
   * @return {string}
   * @const
   */
  read(path) {}
};


/**
 * @record
 */
phantomjs.WebPage = class {

  /**
   * @return {!phantomjs.Page}
   * @const
   */
  create() {}
};


/**
 * @record
 */
phantomjs.PageSettings = class {};

/**
 * @type {number}
 */
phantomjs.PageSettings.prototype.resourceTimeout;


/**
 * @record
 */
phantomjs.StackFrame = class {};

/**
 * @type {string}
 * @const
 */
phantomjs.StackFrame.prototype.file;

/**
 * @type {number}
 * @const
 */
phantomjs.StackFrame.prototype.line;

/**
 * @type {string}
 * @const
 */
phantomjs.StackFrame.prototype.function;


/**
 * @typedef {Array<!phantomjs.StackFrame>}
 */
phantomjs.StackTrace;


/**
 * @enum {string}
 * @const
 */
phantomjs.LoadStatus = {
  SUCCESS: 'success',
  FAIL: 'fail',
};


/**
 * @record
 */
phantomjs.Page = class {

  /**
   * @param {string} url
   * @param {function(string)=} opt_callback
   * @const
   */
  open(url, opt_callback) {}

  /**
   * @const
   */
  close() {}

  /**
   * @param {function(): T} callback
   * @return {T}
   * @template T
   * @const
   */
  evaluate(callback) {}

  /**
   * @param {string} message
   */
  onAlert(message) {}

  /**
   * @param {?} data
   */
  onCallback(data) {}

  /**
   * @param {!phantomjs.Page} data
   */
  onClosing(data) {}

  /**
   * @param {string} message
   * @return {boolean}
   */
  onConfirm(message) {}

  /**
   * @param {string} message
   * @param {?string} line
   * @param {?string} source
   */
  onConsoleMessage(message, line, source) {}

  /**
   * @param {string} message
   * @param {!phantomjs.StackTrace} trace
   */
  onError(message, trace) {}

  onInitialized() {}

  /**
   * @param {phantomjs.LoadStatus} status
   */
  onLoadFinished(status) {}

  onLoadStarted() {}
};

/**
 * @type {!phantomjs.PageSettings}
 * @const
 */
phantomjs.Page.prototype.settings;


/**
 * @record
 * @see http://phantomjs.org/api/webserver/
 */
phantomjs.Server = class {

  /**
   * @param {number|string} port
   * @param {function(!phantomjs.Server.Request,
   *                  !phantomjs.Server.Response)} callback
   * @const
   */
  listen(port, callback) {}

  /**
   * @const
   */
  close() {}
};

/**
 * @type {number}
 * @const
 */
phantomjs.Server.prototype.port;


/**
 * @record
 * @see http://phantomjs.org/api/webserver/method/listen.html
 */
phantomjs.Server.Request = class {};

/**
 * @type {string}
 * @const
 */
phantomjs.Server.Request.prototype.url;


/**
 * @record
 * @see http://phantomjs.org/api/webserver/method/listen.html
 */
phantomjs.Server.Response = class {

  /**
   * @param {string} encoding
   * @const
   */
  setEncoding(encoding) {}

  /**
   * @param {number} statusCode
   * @param {!Object<string, string>=} opt_headers
   * @const
   */
  writeHead(statusCode, opt_headers) {}

  /**
   * @param {string} data
   * @const
   */
  write(data) {}

  /**
   * @const
   */
  close() {}

  /**
   * @const
   */
  closeGracefully() {}
};


/**
 * @record
 * @see http://phantomjs.org/api/webserver/
 */
phantomjs.WebServer = class {

  /**
   * @return {!phantomjs.Server}
   * @const
   */
  create() {}
};


/**
 * @record
 * @see http://phantomjs.org/api/phantom/
 */
phantomjs.Phantom = class {

  /**
   * @param {number=} opt_status
   * @const
   */
  exit(opt_status) {}
};


/**
 * @type {!phantomjs.Phantom}
 * @const
 */
let phantom;


/**
 * @param {string} name
 * @return {*}
 */
function require(name) {}
