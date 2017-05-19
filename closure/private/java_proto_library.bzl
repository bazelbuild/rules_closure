# Copyright 2016 The Closure Rules Authors. All rights reserved.
# Copyright 2014 The Bazel Authors. All rights reserved.
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


def _impl(ctx):
  out = ctx.outputs.srcjar
  includes = ["-I."]
  if ctx.attr.src.label.workspace_root:
    includes += ["-I%s" % ctx.attr.src.label.workspace_root]
  ctx.action(
      command=' '.join([
          "JAR='%s'" % ctx.executable._jar.path,
          "OUTPUT='%s'" % out.path,
          "PROTO_COMPILER='%s'" % ctx.executable._proto_compiler.path,
          "SOURCE='%s'" % ctx.file.src.path,
          "INCLUDES='%s'" % ' '.join(includes),
          ctx.executable._gensrcjar.path,
      ]),
      inputs=([ctx.file.src] + ctx.files._gensrcjar + ctx.files._jar +
              ctx.files._jdk + ctx.files._proto_compiler),
      outputs=[out],
      mnemonic="GenProtoSrcJar",
      use_default_shell_env=True)
  return struct(runfiles=ctx.runfiles(collect_default=True))

_gensrcjar = rule(
    implementation=_impl,
    attrs = {
        "src": attr.label(
            allow_files = FileType([".proto"]),
            single_file = True),
        "_gensrcjar": attr.label(
            default = Label(str(Label("//closure/private:gensrcjar"))),
            executable = True,
            cfg = "host"),
        "_proto_compiler": attr.label(
            default = Label("//third_party/protobuf:protoc_bin"),
            allow_files = True,
            executable = True,
            single_file = True,
            cfg = "host"),
        "_jar": attr.label(
            default = Label("@local_jdk//:jar"),
            allow_files = True,
            executable = True,
            single_file = True,
            cfg = "host"),
        "_jdk": attr.label(
            default = Label("@local_jdk//:jdk-default"),
            allow_files = True),
    },
    outputs = {"srcjar": "lib%{name}.srcjar"})

def java_proto_library(name, src, testonly=None, visibility=None, **kwargs):
  _gensrcjar(
      name = name + "_srcjar",
      src = src,
      testonly = testonly,
      visibility = visibility,
  )
  native.java_library(
      name = name,
      srcs = [":%s_srcjar" % name],
      deps = ["@com_google_protobuf_java"],
      javacopts = ["-Xlint:-rawtypes"],
      testonly = testonly,
      visibility = visibility,
      **kwargs
  )
