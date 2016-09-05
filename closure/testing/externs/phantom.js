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
 * @fileoverview PhantomJS API definitions. We're only defining the parts of
 *     the API we plan on using. This file is necessary in order to have 100%
 *     strict type safety in {@code testrunner.js}.
 * @externs
 * @see http://phantomjs.org/api/
 */


/**
 * Fake namespace for PhantomJS types.
 */
var phantomjs = {};



/**
 * @constructor
 * @final
 * @see https://github.com/ariya/phantomjs/blob/master/examples/stdin-stdout-stderr.js
 */
phantomjs.File = function() {};


/**
 * @param {string} text
 * @const
 */
phantomjs.File.prototype.write = function(text) {};


/**
 * @param {string} text
 * @const
 */
phantomjs.File.prototype.writeLine = function(text) {};



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/system/
 */
phantomjs.System = function() {};


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
 * @constructor
 * @final
 * @see http://phantomjs.org/api/fs/
 */
phantomjs.FileSystem = function() {};


/**
 * @param {string} path
 * @return {boolean}
 */
phantomjs.FileSystem.prototype.exists = function(path) {};


/**
 * @param {string} path
 * @return {string}
 */
phantomjs.FileSystem.prototype.read = function(path) {};



/**
 * @constructor
 * @final
 */
phantomjs.WebPage = function() {};


/**
 * @return {!phantomjs.Page}
 */
phantomjs.WebPage.prototype.create = function() {};



/**
 * @constructor
 * @final
 */
phantomjs.PageSettings = function() {};


/**
 * @type {number}
 */
phantomjs.PageSettings.prototype.resourceTimeout;



/**
 * @constructor
 * @final
 */
phantomjs.Page = function() {};


/**
 * @param {string} url
 * @param {function(string)=} opt_callback
 */
phantomjs.Page.prototype.open = function(url, opt_callback) {};


phantomjs.Page.prototype.close = function() {};


/**
 * @param {function(): T} callback
 * @return {T}
 * @template T
 */
phantomjs.Page.prototype.evaluate = function(callback) {};


/**
 * @type {!phantomjs.PageSettings}
 * @const
 */
phantomjs.Page.prototype.settings;



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/webserver/
 */
phantomjs.Server = function() {};


/**
 * @type {number}
 */
phantomjs.Server.prototype.port;


/**
 * @param {(number|string)} port
 * @param {function(!phantomjs.Server.Request,
 *                  !phantomjs.Server.Response)} callback
 */
phantomjs.Server.prototype.listen = function(port, callback) {};



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/webserver/method/listen.html
 */
phantomjs.Server.Request = function() {};


/**
 * @type {string}
 * @const
 */
phantomjs.Server.Request.prototype.url;



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/webserver/method/listen.html
 */
phantomjs.Server.Response = function() {};


/**
 * @param {string} encoding
 */
phantomjs.Server.Response.prototype.setEncoding = function(encoding) {};


/**
 * @param {number} statusCode
 * @param {!Object<string, string>=} opt_headers
 */
phantomjs.Server.Response.prototype.writeHead =
    function(statusCode, opt_headers) {};


/**
 * @param {string} data
 */
phantomjs.Server.Response.prototype.write = function(data) {};


phantomjs.Server.Response.prototype.close = function() {};


phantomjs.Server.Response.prototype.closeGracefully = function() {};



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/webserver/
 */
phantomjs.WebServer = function() {};


/**
 * @return {!phantomjs.Server}
 */
phantomjs.WebServer.prototype.create = function() {};



/**
 * @constructor
 * @final
 * @see http://phantomjs.org/api/phantom/
 */
phantomjs.Phantom = function() {};


/**
 * @param {number=} opt_status
 */
phantomjs.Phantom.prototype.exit = function(opt_status) {};


/**
 * @type {!phantomjs.Phantom}
 * @const
 */
var phantom;


/**
 * @param {string} name
 * @return {?}
 */
function require(name) {}
