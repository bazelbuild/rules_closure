# -*- mode: python; -*-
#
# Copyright 2016 The Closure Rules Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Downloads files based on local platform."""

def _impl(repository_ctx):
  if repository_ctx.os.name.lower().startswith('mac os'):
    url = repository_ctx.attr.macos_url
    sha256 = repository_ctx.attr.macos_sha256
  else:
    url = repository_ctx.attr.amd64_url
    sha256 = repository_ctx.attr.amd64_sha256
  basename = url[url.rindex('/') + 1:]
  repository_ctx.download(url, basename, sha256)
  repository_ctx.symlink(basename, "file/" + basename)
  repository_ctx.file("file/BUILD", "\n".join([
      ("# DO NOT EDIT: automatically generated BUILD file for " +
       "platform_http_file rule " + repository_ctx.name),
      "filegroup(",
      "    name = 'file',",
      "    srcs = ['%s']," % basename,
      "    visibility = ['//visibility:public'],",
      ")",
  ]))

platform_http_file = repository_rule(
    implementation=_impl,
    attrs={
        "amd64_url": attr.string(),
        "amd64_sha256": attr.string(),
        "macos_url": attr.string(),
        "macos_sha256": attr.string(),
    })
