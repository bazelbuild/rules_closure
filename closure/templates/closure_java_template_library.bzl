# -*- mode:python; -*-
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

"""Utilities for compiling Closure Templates to Java.
"""


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
    soycompilerbin = str(Label('//closure/templates:SoyParseInfoGenerator')),
    **kwargs):

  # Strip off the .soy suffix from the file name and camel-case it, preserving
  # the case of directory names, if any.
  outs = [(_soy__dirname(fn) + _soy__camel(_soy__filename(fn)[:-4])
           + 'SoyInfo.java')
          for fn in srcs]
  java_package = java_package or _soy__GetJavaPackageForCurrentDirectory()

  # TODO(gboyer): Stop generating the info for all the dependencies.
  # First, generate the actual AbcSoyInfo.java files.
  _gen_soy_java_wrappers(
      name = name + '_files',
      java_package = java_package,
      srcs = srcs + extra_srcs,
      deps = deps,
      outs = outs + extra_outs,
      allow_external_calls = allow_external_calls,
      soycompilerbin = soycompilerbin,
      **kwargs)

  # Now, wrap them in a Java library, and expose the Soy files as resources.
  java_srcs = outs + extra_outs
  native.java_library(
      name = name,
      srcs = java_srcs or None,
      exports = [str(Label('//closure/templates'))],
      deps = [
          '@guava//jar',
          str(Label('//closure/templates')),
      ] if java_srcs else None,  # b/13630760
      resources = srcs + extra_srcs,
      **kwargs)

  if filegroup_name != None:
    # Create a filegroup with all the dependencies.
    native.filegroup(
        name = filegroup_name,
        srcs = srcs + extra_srcs + deps,
        **kwargs)


# Generates SoyFileInfo and SoyTemplateInfo sources for Soy templates.
#
# - name: the name of a genrule which will contain Java sources
# - java_package: name of the java package, e.g. com.google.foo.template
# - srcs: all Soy file sources
# - deps: Soy files to parse but not to generate outputs for
# - outs: desired output files. for abc_def.soy, expect AbcDefSoyInfo.java
# - allow_external_calls: Whether to allow external calls, defaults to true.
# - soycompilerbin Optional Soy to ParseInfo compiler target.
def _gen_soy_java_wrappers(name, java_package, srcs, deps, outs,
    allow_external_calls = 1,
    soycompilerbin = str(Label('//closure/templates:SoyParseInfoGenerator')),
    **kwargs):
  additional_flags = ''
  srcs_flag_file_name = name + '__srcs'
  deps_flag_file_name = name + '__deps'
  _soy__gen_file_list_arg_as_file(
    out_name = srcs_flag_file_name,
    targets = srcs,
    flag = '--srcs',
  )
  _soy__gen_file_list_arg_as_file(
    out_name = deps_flag_file_name,
    targets = deps,
    flag = '--deps',
  )
  native.genrule(
    name = name,
    tools = [soycompilerbin],
    srcs = [srcs_flag_file_name, deps_flag_file_name] + srcs + deps,
    message = "Generating SOY v2 Java files",
    outs = outs,
    cmd = '$(location %s)' % soycompilerbin +
        ' --outputDirectory=$(@D)' +
        ' --javaPackage=' + java_package +
        ' --javaClassNameSource=filename' +
        ' --allowExternalCalls=' + str(allow_external_calls) +
        additional_flags +
        # Include the sources and deps files as command line flags.
        ' $$(cat $(location ' + srcs_flag_file_name + '))' +
        ' $$(cat $(location ' + deps_flag_file_name + '))',
    **kwargs)


# The output file for abc_def.soy is AbcDefSoyInfo.java. Handle camelcasing
# for both underscores and digits: css3foo_bar is Css3FooBarSoyInfo.java.
def _soy__camel(str):
  last = '_'
  result = ''
  for ch in str:
    if ch != '_':
      if (last >= 'a' and last <= 'z') or (last >= 'A' and last <= 'Z'):
        result += ch
      else:
        result += ch.upper()
    last = ch
  return result


def _soy__dirname(file):
  return file[:file.rfind('/')+1]


def _soy__filename(file):
  return file[file.rfind('/')+1:]


def _soy__gen_file_list_arg_as_file(out_name, targets, flag):
  native.genrule(
    name = out_name + '_gen',
    srcs = targets,
    outs = [out_name],
    cmd = (("if [ -n \"$(SRCS)\" ] ; " +
           "then echo -n '%s='$$(echo \"$(SRCS)\" | sed -e 's/ /,/g') > $@ ; " +
           "fi ; " +
           "touch $@") % flag),  # touch the file, in case empty
    visibility = ['//visibility:private'])


def _soy__GetJavaPackageForCurrentDirectory():
  """Returns the java package corresponding to the current directory."""
  directory = PACKAGE_NAME
  idx = directory.find('/com/google')
  if idx == -1:
    fail(
        None,
        'Unable to infer java package from directory [%s]' % (directory))
  return '.'.join(directory[idx + 1:].split('/'))
