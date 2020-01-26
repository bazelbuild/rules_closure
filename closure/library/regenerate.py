#!/usr/bin/env python
# Copyright 2018 The Closure Rules Authors. All rights reserved.
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

"""Closure Library BUILD definition generator.

This script produces a build rule for each file in the Closure Library.
It also produces coarse-grained targets (e.g. //closure/library) since
the Closure Compiler can skip unused modules very quickly. Fine-grained
build targets are useful in situations without the Closure Compiler.
"""

import collections
import itertools
import os
import re
import subprocess
import sys

HEADER = '# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"\n\n'
REPO = 'com_google_javascript_closure_library'

PROVIDE_PATTERN = re.compile(r'^goog\.(?:provide|module)\([\'"]([^\'"]+)', re.M)
REQUIRE_PATTERN = re.compile(
    r'^(?:(?:const|var) .* = )?goog\.require\([\'"]([^\'"]+)', re.M)

TESTONLY_PATTERN = re.compile(r'^goog\.setTestOnly\(', re.M)
TESTONLY_PATHS_PATTERN = re.compile(r'(?:%s)' % '|'.join((
    r'^closure/goog/labs/testing/',  # forgot to use goog.setTestOnly()
    r'^closure/goog/testing/net/mockiframeio\.js$',
)))

IGNORE_PATHS_PATTERN = re.compile(r'(?:%s)' % '|'.join((
    r'_perf',
    r'_test',
    r'/demos/',
    r'/testdata/',
    r'^closure/goog/base\.js$',
    r'^closure/goog/deps\.js$',
    r'^closure/goog/transitionalforwarddeclarations\.js$',
    r'^closure/goog/transpile\.js$',
    r'^closure/goog/debug_loader_integration_tests/',
    r'^third_party/closure/goog/osapi',
)))

UNITTEST_PATTERN = re.compile('|'.join((
    r'goog\.require\(.goog\.testing\.testSuite',
    r'^function (?:setUp|tearDown)',
)), re.M)

MASTER = 'closure/library/BUILD'
MASTER_EXCLUDES = ('/ui', '/labs', 'third_party/')
MASTER_EXTRA = '''
filegroup(
    name = "base",
    srcs = [
        "@{0}//:closure/goog/base.js",
        "@{0}//:closure/goog/transitionalforwarddeclarations.js",
    ],
)
closure_js_library(
    name = "deps",
    srcs = ["@{0}//:closure/goog/deps.js"],
    lenient = True,
)
closure_js_library(
    name = "transpile",
    srcs = ["@{0}//:closure/goog/transpile.js"],
    lenient = True,
)
closure_css_library(
    name = "css",
    srcs = ["@{0}//:css_files"],
)
py_binary(
    name = "regenerate",
    srcs = ["regenerate.py"],
    args = ["$(location @{0}//:closure/goog/base.js)"],
    data = [
        "@{0}",
        "@{0}//:closure/goog/base.js",
    ],
    tags = [
        "local",
        "manual",
    ],
    visibility = ["//visibility:private"],
)
'''.format(REPO)


def mkdir(path):
  try:
    os.makedirs(path)
  except OSError as e:
    if e.errno != 17:  # File exists
      raise


def find(prefix):
  for base, _, names in os.walk(prefix):
    for name in names:
      yield os.path.join(base, name)


def normalize(path):
  return path.replace('closure/goog', 'closure/library')


def file2build(path):
  return os.path.join(os.path.dirname(normalize(path)), 'BUILD')


def file2name(path):
  return os.path.splitext(os.path.basename(path))[0]


def file2dep(path):
  path = normalize(path)
  return '//%s:%s' % (os.path.dirname(path), file2name(path))


def main(basejs, outdir):
  assert outdir.startswith('/')

  # cd @com_google_javascript_closure_library//
  os.chdir(os.path.join(os.path.dirname(basejs), '../..'))

  # files=$(find {third_party,}closure/goog | sort)
  files = sorted(itertools.chain(find('closure/goog'),
                                 find('third_party/closure/goog')))

  # Find JavaScript sources and determine their relationships.
  jslibs = []
  jstestlibs = set()  # jslibs with goog.setTestOnly()
  jsrawlibs = set()  # jslibs without goog.provide() or goog.module()
  file2requires = {}  # e.g. closure/goog/array/array.js -> goog.asserts
  provide2file = {}  # e.g. goog.asserts -> closure/goog/asserts/asserts.js
  for f in files:
    if IGNORE_PATHS_PATTERN.search(f) is not None:
      continue
    file2requires[f] = []
    if f.endswith('.js'):
      with open(f) as fh:
        data = fh.read()
        provides = [m.group(1) for m in PROVIDE_PATTERN.finditer(data)]
      if provides:
        if (TESTONLY_PATHS_PATTERN.search(f) is not None or
            TESTONLY_PATTERN.search(data) is not None):
          if UNITTEST_PATTERN.search(data) is not None:
            continue
          jstestlibs.add(f)
        for provide in provides:
          provide2file[provide] = f
        file2requires[f] = sorted(set(
            m.group(1) for m in REQUIRE_PATTERN.finditer(data)))
      else:
        jsrawlibs.add(f)
      jslibs.append(f)

  # Write a build rule for each JavaScript source file.
  builds = collections.defaultdict(list)
  for f in jslibs:
    deps = set()
    for ns in file2requires[f]:
      if ns not in provide2file:
        sys.stderr.write('%s needs %s but not provided\n' % (f, ns))
        return 1
      deps.add(provide2file[ns])
    build = file2build(f)
    name = file2name(f)
    rule = 'closure_js_library(name="%s",lenient=True,srcs=["@%s//:%s"],' % (
        name, REPO, f)
    if deps:
      rule += 'deps=[%s],' % ','.join('"%s"' % file2dep(dep) for dep in deps)
    if f in jsrawlibs:
      rule += 'no_closure_library = True,'
    if f in jstestlibs:
      rule += 'testonly = True,'
    builds[build].append(rule + ')')

  # Production source modules are grouped by folder for convenience,
  # which percolates upwards in the directory hierarchy towards
  # //closure/library which exports it all. Test modules are only
  # grouped under the //closure/library:testing label.
  alls = collections.defaultdict(set)  # group rules for :all_js
  testall = set()  # group rules for //closure/library:testing
  for f in jslibs:
    if f in jsrawlibs:
      continue
    if f in jstestlibs:
      testall.add(file2dep(f))
      continue
    alls[file2build(f)].add(':%s' % file2name(f))
    dn = os.path.dirname  # lazy kludge due to third_party dichotomy
    dirname = dn(normalize(f))
    for parent in (os.path.join(dn(dirname), 'BUILD'),
                   os.path.join(dn(dn(dirname)), 'BUILD'),
                   os.path.join(dn(dn(dn(dirname))), 'BUILD'),
                   'closure/library/BUILD'):
      if parent in builds:
        alls[parent].add('//%s:all_js' % dirname)
        break

  # Remove labels by substring for modules like goog.ui and goog.labs
  # which we don't want exported by default in the top-level BUILD file.
  alls[MASTER] = [t for t in alls[MASTER]
                  if not any(ss in t for ss in MASTER_EXCLUDES)]
  testall = [t for t in testall
             if not any(ss in t for ss in MASTER_EXCLUDES)]

  # Make ninja edits to the BUILD files we wrote earlier.
  for build in builds:
    if alls[build]:
      alljs = 'library' if build == MASTER else 'all_js'
      rule = 'closure_js_library(name="%s",exports=[%s])' % (
          alljs, ','.join('"%s"' % d for d in alls[build]))
      builds[build].insert(0, rule)
    if build == MASTER:
      builds[build].append(MASTER_EXTRA)
      builds[build].insert(1, 'closure_js_library(' +
                           'name="testing",' +
                           'testonly=True,' +
                           'exports=[%s],' % ','.join('"%s"' % d
                                                      for d in testall) +
                           ')')
      builds[build].insert(
          0, 'load("//closure:defs.bzl", "closure_css_library")\n' +
          'load("//closure:defs.bzl", "closure_js_library")')
    else:
      builds[build].insert(
          0, 'load("//closure:defs.bzl", "closure_js_library")')

    builds[build].insert(
        0, 'load("@rules_python//python:defs.bzl", "py_binary")')

    builds[build].insert(0, 'licenses(["notice"])')
    builds[build].insert(
        0, 'package(default_visibility = ["//visibility:public"])')

  # Now actually write the BUILD files to disk.
  for build in sorted(builds.keys()):
    path = os.path.join(outdir, build)
    mkdir(os.path.dirname(path))
    with open(path, 'w') as fh:
      fh.write(HEADER)
      fh.write('\n\n'.join(builds[build]))
      fh.write('\n')

  # Fix the formatting of those BUILD files.
  os.chdir(outdir)
  return subprocess.call(['buildifier'] + sorted(builds.keys()))


if __name__ == '__main__':
  sys.exit(main(*sys.argv[1:]))
