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

var fs = require('fs');
var page = require('webpage').create();
var system = require('system');
var webserver = require('webserver');
var port = Math.floor(Math.random() * (60000 - 32768)) + 32768;

webserver.create().listen('127.0.0.1:' + port, function(request, response) {
  response.writeHead(200, {'Content-Type': 'text/html'});
  response.write(fs.read(system.args[1]));
  response.closeGracefully();
});

page.open('http://localhost:' + port, function(status) {
  if (status != 'success') {
    system.stderr.writeLine('Load Failed');
    phantom.exit(1);
    return;
  }
  page.render(system.args[2]);
  phantom.exit();
});
