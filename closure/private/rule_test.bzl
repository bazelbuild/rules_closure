# Copyright 2016 The Bazel Authors. All rights reserved.
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

"""Rule for testing the struct returned by a rule."""

def _strip_prefix(prefix, string):
    if not string.startswith(prefix):
        fail("%s does not start with %s" % (string, prefix))
    return string[len(prefix):len(string)]

def _success_target(ctx, msg):
    exe = ctx.outputs.executable
    dat = ctx.new_file(ctx.configuration.genfiles_dir, exe, ".dat")
    ctx.actions.write(
        output = dat,
        content = msg,
    )
    ctx.actions.write(
        output = exe,
        content = "cat " + dat.path + " ; echo",
        is_executable = True,
    )
    return struct(runfiles = ctx.runfiles([exe, dat]))

def _impl(ctx):
    rule_ = ctx.attr.rule
    rule_name = str(rule_.label)
    exe = ctx.outputs.executable
    if ctx.attr.generates:
        prefix = rule_.label.package + "/"
        generates = sorted(ctx.attr.generates)
        generated = sorted([
            _strip_prefix(prefix, f.short_path)
            for f in rule_.files
        ])
        if generates != generated:
            fail("rule %s generates %s not %s" %
                 (rule_name, repr(generated), repr(generates)))
    provides = ctx.attr.provides
    if provides:
        files = []
        commands = []
        for k in provides.keys():
            if _hasattr(rule_, k):
                v = repr(_getattr(rule_, k))
            else:
                fail(("rule %s doesn't provide attribute %s. " +
                      "Its list of attributes is: %s") %
                     (rule_name, k, dir(rule_)))
            file_ = ctx.new_file(ctx.configuration.genfiles_dir, exe, "." + k)
            files += [file_]
            regexp = provides[k]
            commands += [
                "if ! grep %s %s ; then echo 'bad %s:' ; cat %s ; echo ; exit 1 ; fi" %
                (repr(regexp), file_.short_path, k, file_.short_path),
            ]
            ctx.actions.write(output = file_, content = v)
        script = "\n".join(commands + ["true"])
        ctx.actions.write(output = exe, content = script, is_executable = True)
        return struct(runfiles = ctx.runfiles([exe] + files))
    else:
        return _success_target(ctx, "success")

def _hasattr(obj, name):
    for label in name.split("."):
        if not hasattr(obj, label):
            return False
        obj = getattr(obj, label)
    return True

def _getattr(obj, name):
    for label in name.split("."):
        if not hasattr(obj, label):
            return False
        obj = getattr(obj, label)
    return obj

_rule_test = rule(
    attrs = {
        "rule": attr.label(mandatory = True),
        "generates": attr.string_list(),
        "provides": attr.string_dict(),
    },
    executable = True,
    implementation = _impl,
    test = True,
)

def rule_test(size = "small", **kwargs):
    _rule_test(size = size, **kwargs)
