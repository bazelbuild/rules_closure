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

"""Utilities for compiling Closure Templates to Java.
"""

load("@rules_java//java:defs.bzl", "java_library")

_SOY_COMPILER_BIN = "@com_google_template_soy//:SoyParseInfoGenerator"
_SOY_LIBRARY = "@com_google_template_soy//:com_google_template_soy"

# Generates a java_library with the SoyFileInfo and SoyTemplateInfo
# for all templates.
#
# For each Soy input called abc_def.soy, a Java class AbcDefSoyInfo will be
# generated.  For a template in that file called foo.barBaz, you can reference
# its info as AbcDefSoyInfo.BAR_BAZ.
#
# srcs: an explicit file list of soy files to scan.
# java_package: the package for the Java files that are generated. If not
#     given, defaults to the package from which this function was invoked.
# deps: Soy files that these templates depend on, in order for
#     templates to include the parameters of templates they call.
# filegroup_name: will create a filegroup suitable for use as a
#     dependency by another soy_java_wrappers rule
# extra_srcs: any build rule that provides Soy files that should be used
#     as additional sources. For these, an extra_outs must be provided for each
#     Java file expected. Useful for generating Java wrappers for Soy files not
#     in the Java tree.
# extra_outs: extra output files from the dependencies that are requested;
#     useful if for generating wrappers for files that are not in the Java tree
# allow_external_calls: Whether to allow external soy calls (i.e. calls to
#     undefined templates). This parameter is passed to SoyParseInfoGenerator and
#     it defaults to true.
# soycompilerbin: Optional Soy to ParseInfo compiler target.
def closure_java_template_library(
        name,
        java_package = None,
        srcs = [],
        deps = [],
        filegroup_name = None,
        extra_srcs = [],
        extra_outs = [],
        allow_external_calls = 1,
        soycompilerbin = str(Label(_SOY_COMPILER_BIN)),
        **kwargs):
    # Strip off the .soy suffix from the file name and camel-case it, preserving
    # the case of directory names, if any.
    outs = [
        (_soy__dirname(fn) + _soy__camel(_soy__filename(fn)[:-4]) +
         "SoyInfo.java")
        for fn in srcs
    ]
    java_package = java_package or _soy__GetJavaPackageForCurrentDirectory()

    # TODO(gboyer): Stop generating the info for all the dependencies.
    # First, generate the actual AbcSoyInfo.java files.
    _gen_soy_java_wrappers(
        name = name + "_files",
        java_package = java_package,
        srcs = srcs + extra_srcs,
        deps = deps,
        outs = outs + extra_outs,
        allow_external_calls = allow_external_calls,
        soycompilerbin = soycompilerbin,
        **kwargs
    )

    # Now, wrap them in a Java library, and expose the Soy files as resources.
    java_srcs = outs + extra_outs
    java_library(
        name = name,
        srcs = java_srcs or None,
        exports = [str(Label(_SOY_LIBRARY))],
        deps = [
            "@com_google_guava",
            "@javax_annotation_jsr250_api",
            str(Label(_SOY_LIBRARY)),
        ] if java_srcs else None,  # b/13630760
        resources = srcs + extra_srcs,
        **kwargs
    )

    if filegroup_name != None:
        # Create a filegroup with all the dependencies.
        native.filegroup(
            name = filegroup_name,
            srcs = srcs + extra_srcs + deps,
            **kwargs
        )

# Generates SoyFileInfo and SoyTemplateInfo sources for Soy templates.
#
# - name: the name of a genrule which will contain Java sources
# - java_package: name of the java package, e.g. com.google.foo.template
# - srcs: all Soy file sources
# - deps: Soy files to parse but not to generate outputs for
# - outs: desired output files. for abc_def.soy, expect AbcDefSoyInfo.java
# - allow_external_calls: Whether to allow external calls, defaults to true.
# - soycompilerbin Optional Soy to ParseInfo compiler target.
def _gen_soy_java_wrappers(
        name,
        java_package,
        srcs,
        deps,
        outs,
        allow_external_calls = 1,
        soycompilerbin = str(Label(_SOY_COMPILER_BIN)),
        compatible_with = None,
        **kwargs):
    additional_flags = ""
    srcs_flag_file_name = name + "__srcs"
    deps_flag_file_name = name + "__deps"
    _soy__gen_file_list_arg_as_file(
        out_name = srcs_flag_file_name,
        targets = srcs,
        flag = "--srcs",
        compatible_with = compatible_with,
    )
    _soy__gen_file_list_arg_as_file(
        out_name = deps_flag_file_name,
        targets = deps,
        flag = "--deps",
        compatible_with = compatible_with,
    )
    native.genrule(
        name = name,
        tools = [soycompilerbin],
        srcs = [srcs_flag_file_name, deps_flag_file_name] + srcs + deps,
        message = "Generating SOY v2 Java files",
        outs = outs,
        cmd = "$(location %s)" % soycompilerbin +
              " --outputDirectory=$(@D)" +
              " --javaPackage=" + java_package +
              " --javaClassNameSource=filename" +
              " --allowExternalCalls=" + str(allow_external_calls) +
              additional_flags +
              # Include the sources and deps files as command line flags.
              " $$(cat $(location " + srcs_flag_file_name + "))" +
              " $$(cat $(location " + deps_flag_file_name + "))",
        compatible_with = compatible_with,
        **kwargs
    )

# The output file for abc_def.soy is AbcDefSoyInfo.java. Handle camelcasing
# for both underscores and digits: css3foo_bar is Css3FooBarSoyInfo.java.
def _soy__camel(str):
    last = "_"
    result = ""
    for index in range(len(str)):
        ch = str[index]
        if ch != "_":
            if (last >= "a" and last <= "z") or (last >= "A" and last <= "Z"):
                result += ch
            else:
                result += ch.upper()
        last = ch
    return result

def _soy__dirname(file):
    return file[:file.rfind("/") + 1]

def _soy__filename(file):
    return file[file.rfind("/") + 1:]

def _soy__gen_file_list_arg_as_file(
        out_name,
        targets,
        flag,
        compatible_with = None):
    native.genrule(
        name = out_name + "_gen",
        srcs = targets,
        outs = [out_name],
        cmd = (("if [ -n \"$(SRCS)\" ] ; " +
                "then echo -n '%s='$$(echo \"$(SRCS)\" | sed -e 's/ /,/g') > $@ ; " +
                "fi ; " +
                "touch $@") % flag),  # touch the file, in case empty
        compatible_with = compatible_with,
        visibility = ["//visibility:private"],
    )

def _soy__GetJavaPackageForCurrentDirectory():
    """Returns the java package corresponding to the current directory."""
    directory = native.package_name()
    for prefix in ("java/", "javatests/"):
        if directory.startswith(prefix):
            return ".".join(directory[len(prefix):].split("/"))
        i = directory.find("/" + prefix)
        if i != -1:
            return ".".join(directory[i + len(prefix) + 1:].split("/"))
    fail("Unable to infer java package from directory: " + directory)
