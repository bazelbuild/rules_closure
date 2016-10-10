# Copyright 2016 The TensorFlow Authors. All rights reserved.
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

"""Web component validation, packaging, and development web server."""

load("//closure/private:defs.bzl", "create_argfile", "difference", "long_path")

def _webfiles(ctx):
  # additional preconditions
  if not ctx.attr.path.startswith('/'):
    fail("web directory path must start with /")
  if ctx.attr.path.endswith('/'):
    fail("web directory path must not end with /")
  if '//' in ctx.attr.path:
    fail("web directory path must not have //")

  # process what came before
  paths = set()
  manifests = set(order="link")
  for dep in ctx.attr.deps:
    paths += dep.webfiles.paths
    manifests += dep.webfiles.manifests

  # process what comes now
  new_paths = []
  manifest_lines = [ctx.label]
  for src in ctx.attr.srcs:
    sname = "/" + src.label.name
    for srcfile in src.files:
      if srcfile.path.endswith(sname) or srcfile.path == src.label.name:
        name = src.label.name
      else:
        name = srcfile.basename
      path = "%s/%s" % (ctx.attr.path, name)
      if path in new_paths:
        fail("name collision in srcs: " + name)
      if path in paths:
        fail("path already defined by child rules: " + path)
      new_paths.append(path)
      manifest_lines.append(
          "%s\t%s\t%s" % (path, srcfile.short_path, srcfile.path))
  paths += new_paths
  manifest = ctx.new_file(ctx.configuration.bin_dir, "%s.tsv" % ctx.label.name)
  ctx.file_action(output=manifest, content="\n".join(manifest_lines))
  manifests += [manifest]

  # perform strict dependency checking
  dummy = ctx.new_file(ctx.configuration.bin_dir, "%s.dummy" % ctx.label.name)
  inputs = [manifest]
  direct_manifests = set([manifest])
  args = ["WebfilesValidator",
          "--dummy", dummy.path,
          "--source_manifest", manifest.path]
  inputs.extend(ctx.files.srcs)
  for dep in ctx.attr.deps:
    inputs.append(dep.webfiles.dummy)
    for f in dep.files:
      inputs.append(f)
    direct_manifests += [dep.webfiles.manifest]
    inputs.append(dep.webfiles.manifest)
    args.append("--direct_manifest")
    args.append(dep.webfiles.manifest.path)
  for man in difference(manifests, direct_manifests):
    inputs.append(man)
    args.append("--transitive_manifest")
    args.append(man.path)
  argfile = create_argfile(ctx, args)
  inputs.append(argfile)
  ctx.action(
      inputs=inputs,
      outputs=[dummy],
      executable=ctx.executable._ClosureUberAlles,
      arguments=["@@" + argfile.path],
      mnemonic="Closure",
      execution_requirements={"supports-workers": "1"},
      progress_message="Checking %d web files" % len(ctx.files.srcs))

  # define development web server that only applies to this transitive closure
  runfiles = set([manifest, dummy])
  runfiles += ctx.attr._WebfilesServer.data_runfiles.files
  args = ["#!/bin/sh\nexec " + ctx.executable._WebfilesServer.short_path]
  args.append("--label")
  args.append(ctx.label)
  for man in manifests:
    args.append("--manifest")
    args.append(man.short_path)
  args.append("\"$@\"")
  ctx.file_action(
      executable=True,
      output=ctx.outputs.executable,
      content=" \\\n  ".join(args))

  # export data to parent rules
  return struct(
      files=set(ctx.files.srcs),
      webfiles=struct(
          manifest=manifest,
          manifests=manifests,
          paths=paths,
          dummy=dummy),
      runfiles=ctx.runfiles(
          files=ctx.files.srcs + ctx.files.data,
          transitive_files=runfiles,
          collect_default=True))

webfiles = rule(
    implementation=_webfiles,
    executable=True,
    attrs={
        "path": attr.string(mandatory=True),
        "srcs": attr.label_list(allow_files=True, mandatory=True),
        "deps": attr.label_list(allow_files=False, providers=["webfiles"]),
        "data": attr.label_list(cfg="data", allow_files=True),
        "_ClosureUberAlles": attr.label(
            default=Label("//java/io/bazel/rules/closure:ClosureUberAlles"),
            executable=True,
            cfg="host"),
        "_WebfilesServer": attr.label(
            default=Label(
                "//java/io/bazel/rules/closure/webfiles:WebfilesServer"),
            executable=True,
            cfg="host"),
    })
