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

"""Web component validation, packaging, and development web server."""

load(
    "//closure/private:defs.bzl",
    "create_argfile",
    "difference",
    "long_path",
    "unfurl",
)

def _web_library(ctx):
    if not ctx.attr.srcs:
        if ctx.attr.deps:
            fail("deps can not be set when srcs is not")
        if not ctx.attr.exports:
            fail("exports must be set if srcs is not")
    if ctx.attr.path:
        if not ctx.attr.path.startswith("/"):
            fail("webpath must start with /")
        if ctx.attr.path != "/" and ctx.attr.path.endswith("/"):
            fail("webpath must not end with / unless it is /")
        if "//" in ctx.attr.path:
            fail("webpath must not have //")
    elif ctx.attr.srcs:
        fail("path must be set when srcs is set")
    if "*" in ctx.attr.suppress and len(ctx.attr.suppress) != 1:
        fail("when \"*\" is suppressed no other items should be present")

    # process what came before
    deps = unfurl(ctx.attr.deps, provider = "webfiles")
    webpaths = []
    manifests = depset(order = "postorder")
    for dep in deps:
        webpaths.append(dep.webfiles.webpaths)
        manifests += dep.webfiles.manifests

    # process what comes now
    new_webpaths = []
    manifest_srcs = []
    path = ctx.attr.path
    strip = _get_strip(ctx)
    for src in ctx.files.srcs:
        suffix = _get_path_relative_to_package(src)
        if strip:
            if not suffix.startswith(strip):
                fail("Relative src path not start with '%s': %s" % (strip, suffix))
            suffix = suffix[len(strip):]
        webpath = "%s/%s" % ("" if path == "/" else path, suffix)
        if webpath in new_webpaths:
            _fail(ctx, "multiple srcs within %s define the webpath %s " % (
                ctx.label,
                webpath,
            ))
        if webpath in webpaths:
            _fail(ctx, "webpath %s was defined by %s when already defined by deps" % (
                webpath,
                ctx.label,
            ))
        new_webpaths.append(webpath)
        manifest_srcs.append(struct(
            path = src.path,
            longpath = long_path(ctx, src),
            webpath = webpath,
        ))
    webpaths += [depset(new_webpaths)]
    manifest = ctx.actions.declare_file("%s.pbtxt" % ctx.label.name)
    ctx.actions.write(
        output = manifest,
        content = struct(
            label = str(ctx.label),
            src = manifest_srcs,
        ).to_proto(),
    )
    manifests += [manifest]

    # perform strict dependency checking
    inputs = [manifest]
    direct_manifests = depset([manifest])
    args = [
        "WebfilesValidator",
        "--dummy",
        ctx.outputs.dummy.path,
        "--target",
        manifest.path,
    ]
    for category in ctx.attr.suppress:
        args.append("--suppress")
        args.append(category)
    inputs.extend(ctx.files.srcs)
    for dep in deps:
        inputs.append(dep.webfiles.dummy)
        for f in dep.files.to_list():
            inputs.append(f)
        direct_manifests += [dep.webfiles.manifest]
        inputs.append(dep.webfiles.manifest)
        args.append("--direct_dep")
        args.append(dep.webfiles.manifest.path)
    for man in difference(manifests, direct_manifests):
        inputs.append(man)
        args.append("--transitive_dep")
        args.append(man.path)
    argfile = create_argfile(ctx.actions, ctx.label.name, args)
    inputs.append(argfile)
    ctx.actions.run(
        inputs = inputs,
        outputs = [ctx.outputs.dummy],
        executable = ctx.executable._ClosureWorker,
        arguments = ["@@" + argfile.path],
        mnemonic = "Closure",
        execution_requirements = {"supports-workers": "1"},
        progress_message = "Checking webfiles in %s" % ctx.label,
    )

    # define development web server that only applies to this transitive closure
    params = struct(
        label = str(ctx.label),
        bind = "[::]:6006",
        manifest = [long_path(ctx, man) for man in manifests.to_list()],
        external_asset = [
            struct(webpath = k, path = v)
            for k, v in ctx.attr.external_assets.items()
        ],
    )
    params_file = ctx.actions.declare_file("%s_server_params.pbtxt" % ctx.label.name)
    ctx.actions.write(output = params_file, content = params.to_proto())
    ctx.actions.write(
        is_executable = True,
        output = ctx.outputs.executable,
        content = "#!/bin/sh\nexec %s %s \"$@\"" % (
            ctx.executable._WebfilesServer.short_path,
            long_path(ctx, params_file),
        ),
    )

    # export data to parent rules
    transitive_runfiles = depset()
    transitive_runfiles += ctx.attr._WebfilesServer.data_runfiles.files
    for dep in deps:
        transitive_runfiles += dep.data_runfiles.files
    return struct(
        files = depset([ctx.outputs.executable, ctx.outputs.dummy]),
        exports = unfurl(ctx.attr.exports),
        webfiles = struct(
            manifest = manifest,
            manifests = manifests,
            webpaths = depset(transitive = webpaths),
            dummy = ctx.outputs.dummy,
        ),
        runfiles = ctx.runfiles(
            files = ctx.files.srcs + ctx.files.data + [
                manifest,
                params_file,
                ctx.outputs.executable,
                ctx.outputs.dummy,
            ],
            transitive_files = transitive_runfiles,
        ),
    )

def _fail(ctx, message):
    if ctx.attr.suppress == ["*"]:
        print(message)
    else:
        fail(message)

def _get_path_relative_to_package(artifact):
    """Returns file path relative to the package that declared it."""
    path = artifact.path
    for prefix in (
        artifact.root.path,
        artifact.owner.workspace_root if artifact.owner else "",
        artifact.owner.package if artifact.owner else "",
    ):
        if prefix:
            prefix = prefix + "/"
            if not path.startswith(prefix):
                fail("Path %s doesn't start with %s" % (path, prefix))
            path = path[len(prefix):]
    return path

def _get_strip(ctx):
    strip = ctx.attr.strip_prefix
    if strip:
        if strip.startswith("/"):
            _fail(ctx, "strip_prefix should not end with /")
            strip = strip[1:]
        if strip.endswith("/"):
            _fail(ctx, "strip_prefix should not end with /")
        else:
            strip += "/"
    return strip

web_library = rule(
    implementation = _web_library,
    executable = True,
    attrs = {
        "path": attr.string(),
        "srcs": attr.label_list(allow_files = True),
        "deps": attr.label_list(providers = ["webfiles"]),
        "exports": attr.label_list(),
        "data": attr.label_list(allow_files = True),
        "suppress": attr.string_list(),
        "strip_prefix": attr.string(),
        "external_assets": attr.string_dict(default = {"/_/runfiles": "."}),
        "_ClosureWorker": attr.label(
            default = Label("//java/io/bazel/rules/closure:ClosureWorker"),
            executable = True,
            cfg = "host",
        ),
        "_WebfilesServer": attr.label(
            default = Label(
                "//java/io/bazel/rules/closure/webfiles/server:WebfilesServer",
            ),
            executable = True,
            cfg = "host",
        ),
    },
    outputs = {
        "dummy": "%{name}.ignoreme",
    },
)
