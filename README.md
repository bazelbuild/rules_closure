# Closure Rules for Bazel (αlpha) ![Travis build status](https://travis-ci.org/bazelbuild/rules_closure.svg?branch=master) [![Bazel CI build status](https://badge.buildkite.com/7569410e2a2661076591897283051b6d137f35102167253fed.svg)](https://buildkite.com/bazel/closure-compiler-rules-closure-postsubmit)

JavaScript | Templating | Stylesheets | Miscellaneous
--- | --- | --- | ---
[closure_js_library] | [closure_js_template_library] | [closure_css_library] | [closure_js_proto_library]
[closure_js_binary] | [closure_java_template_library] | [closure_css_binary] | [phantomjs_test]
[closure_js_test] | [closure_py_template_library] | | [closure_proto_library] \(Experimental\)
| | | | [closure_grpc_web_library] \(Experimental\)

## Overview

Closure Rules provides a polished JavaScript build system for [Bazel] that
emphasizes type safety, strictness, testability, and optimization. These rules
are built with the [Closure Tools], which are what Google used to create
websites like Google.com and Gmail. The goal of this project is to take the
frontend development methodology that Google actually uses internally, and make
it easily available to outside developers.

Closure Rules is an *abstract* build system. This is what sets it apart from
Grunt, Gulp, Webpacker, Brunch, Broccoli, etc. These projects all provide a
concrete framework for explaining *how* to build your project. Closure Rules
instead provides a framework for declaring *what* your project is. Closure Rules
is then able to use this abstract definition to infer an optimal build strategy.

Closure Rules is also an *austere* build system. The Closure Compiler doesn't
play games. It enforces a type system that can be stricter than Java. From a
stylistic perspective, Closure is [verbose] like Java; there's no cryptic
symbols or implicit behavior; the code says exactly what it's doing.  This sets
Closure apart from traditional JavaScript development, where terseness was
favored over readability, because minifiers weren't very good. Furthermore, the
Closure Library and Templates help you follow security best practices which will
keep your users safe.

### What's Included

Closure Rules bundles the following tools and makes them "just work."

- [Bazel]: The build system Google uses to manage a repository with petabytes of
  code.
- [Closure Compiler]: Type-safe, null-safe, optimizing JavaScript compiler that
  transpiles [ECMASCRIPT6] to minified ES3 JavaScript that can run in any
  browser.
- [Closure Library]: Google's core JavaScript libraries.
- [Closure Templates]: Type-safe HTML templating system that compiles to both
  JavaScript and Java. This is one of the most secure templating systems
  available. It's where Google has put the most thought into preventing things
  like XSS attacks. It also supports i18n and l10n.
- [Closure Stylesheets]: CSS compiler supporting class name minification,
  variables, functions, conditionals, mixins, and bidirectional layout.
- [PhantomJS]: Headless web browser used for automating JavaScript unit tests in
  a command line environment.
- [Protocol Buffers]: Google's language-neutral, platform-neutral, extensible
  mechanism for serializing structured data. This is used instead of untyped
  JSON.

### Mailing Lists

- [closure-rules-announce](https://groups.google.com/forum/#!forum/closure-rules-announce)
- [closure-rules-discuss](https://groups.google.com/forum/#!forum/closure-rules-discuss)

### Caveat Emptor

Closure Rules is production ready, but its design is not yet finalized. Breaking
changes will be introduced. However they will be well-documented in the release
notes.

## Setup

First you must [install Bazel]. Then you add the following to your `WORKSPACE`
file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_closure",
    sha256 = "7d206c2383811f378a5ef03f4aacbcf5f47fd8650f6abbc3fa89f3a27dd8b176",
    strip_prefix = "rules_closure-0.10.0",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_closure/archive/0.10.0.tar.gz",
        "https://github.com/bazelbuild/rules_closure/archive/0.10.0.tar.gz",
    ],
)

load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies()
rules_closure_toolchains()
```

You are not required to install the Closure Tools, PhantomJS, or anything else
for that matter; they will be fetched automatically by Bazel.

### Overriding Dependency Versions

When you call `rules_closure_dependencies()` in your `WORKSPACE` file, it causes a
few dozen external dependencies to be added to your project, e.g. Guava, Guice,
JSR305, etc. You might need to customize this behavior.

To override the version of any dependency, modify your `WORKSPACE` file to pass
`omit_<dependency_name>=True` to `rules_closure_dependencies()`. Next define your
custom dependency version. A full list of dependencies is available from
[repositories.bzl]. For example, to override the version of Guava:

```starlark
load("@io_bazel_rules_closure//closure:repositories.bzl", "rules_closure_dependencies", "rules_closure_toolchains")
rules_closure_dependencies(
    omit_com_google_guava=True,
)
rules_closure_toolchains()

load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
java_import_external(
    name = "com_google_guava",
    licenses = ["notice"],  # Apache 2.0
    jar_urls = [
        "https://mirror.bazel.build/repo1.maven.org/maven2/com/google/guava/guava/24.1-jre/guava-24.1-jre.jar",
        "https://repo1.maven.org/maven2/com/google/guava/guava/24.1-jre/guava-24.1-jre.jar",
    ],
    jar_sha256 = "31bfe27bdf9cba00cb4f3691136d3bc7847dfc87bfe772ca7a9eb68ff31d79f5",
    exports = [
        "@com_google_code_findbugs_jsr305",
        "@com_google_errorprone_error_prone_annotations",
    ],
)
```

## Examples

Please see the test directories within this project for concrete examples of usage:

- [//closure/testing/test](https://github.com/bazelbuild/rules_closure/tree/master/closure/testing/test)
- [//closure/compiler/test](https://github.com/bazelbuild/rules_closure/tree/master/closure/compiler/test)
- [//closure/templates/test](https://github.com/bazelbuild/rules_closure/tree/master/closure/templates/test)
- [//closure/stylesheets/test](https://github.com/bazelbuild/rules_closure/tree/master/closure/stylesheets/test)
- [//closure/protobuf/test](https://github.com/bazelbuild/rules_closure/tree/master/closure/protobuf/test)


# Reference


## closure\_js\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")
closure_js_library(name, srcs, data, deps, exports, suppress, convention,
                   no_closure_library)
```

Defines a set of JavaScript sources.

The purpose of this rule is to define an abstract graph of JavaScript sources.
It must be used in conjunction with [closure_js_binary] to output a minified
file.

This rule will perform syntax checking and linting on your files. This can be
tuned with the `suppress` attribute. To learn more about what the linter wants,
read the [Google JavaScript Style Guide].

Strict dependency checking is performed on the sources listed in each library
target. See the documentation of the `deps` attribute for further information.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will always be empty and `data` will contain all
  transitive JS sources and data.

### Arguments

- **name:** ([Name]; required) A unique name for this rule. The standard
  convention is that this be the same name as the Bazel package with `srcs =
  glob(['*.js'])`. If it contains a subset of the `.js` srcs in the package,
  then convention states that the `_lib` suffix should be used.

- **srcs:** (List of [labels]; optional) The list of `.js` source files that
  represent this library. This can include files marked as `@externs` or
  `@nocompile`. This attribute is required unless the `exports` attribute is
  being defined.

- **data:** (List of [labels]; optional) Runfiles directly referenced by JS
  sources in this rule. For example, if the JS generated injected an img tag
  into the page with a hard coded image named foo.png, then you might want to
  list that image here, so it ends up in the webserver runfiles.

- **deps:** (List of [labels]; optional) Direct [dependency] list. These can
  point to [closure_js_library], [closure_js_template_library],
  [closure_css_library] and [closure_js_proto_library] rules.

- **exports:** (List of [labels]; optional) Listing dependencies here will cause
  them to become *direct* dependencies in parent rules. This functions similarly
  to [java_library.exports]. This can be used to create aliases for rules in
  another package. It can also be also be used to export private targets within
  the package. Another use is to roll up a bunch of fine-grained libraries into
  a single big one.

- **suppress** (List of String; optional; default is `[]`) List of codes the
  linter should ignore. Warning and error messages that are allowed to be
  suppressed, will display the codes for disabling it. For example, if the
  linter says:

  ```
  foo.js:123: WARNING lintChecks JSC_MUST_BE_PRIVATE - Property bar_ must be marked @private
  ```

  Then the diagnostic code `"JSC_MUST_BE_PRIVATE"` can be used in the `suppress`
  list. It is also possible to use the group code `"lintChecks"` to disable all
  diagnostic codes associated with linting.

  If a code is used that isn't necessary, an error is raised. Therefore the use
  of fine-grained suppression codes is maintainable.

- **convention** (String; optional; default is `"CLOSURE"`) Specifies the coding
  convention which affects how the linter operates. This can be the following
  values:

  - `NONE`: Don't take any special practices into consideration.
  - `CLOSURE`: Take [Closure coding conventions] into consideration when
    linting. See the [Google JavaScript Style Guide] for more information.
  - `GOOGLE`: Take [Google coding conventions] into consideration when
    linting. See the [Google JavaScript Style Guide] for more information.

- **no_closure_library** (Boolean; optional; default is `False`) Do not link
  Closure Library [base.js]. If this flag is used, an error will be raised if
  any `deps` do not also specify this flag.

  All [closure_js_library] rules with nonempty `srcs` have an implicit
  dependency on `@closure_library//:closure/goog/base.js`. This is a lightweight
  file that boostraps very important functions, e.g. `goog.provide`. Linking
  this file by default is important because:

  1. It is logically impossible to say `goog.require('goog')`.
  2. The Closure Compiler will sometimes generate synthetic code that calls
     these functions. For example, the [ProcessEs6Modules] compiler pass turns
     ES6 module directives into `goog.provide` / `goog.require` statements.

  The only tradeoff is that when compiling in `WHITESPACE_ONLY` mode, this code
  will show up in the resulting binary. Therefore this flag provides the option
  to remove it.


## closure\_js\_binary

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_binary")
closure_js_binary(name, deps, css, debug, language, entry_points,
                  dependency_mode, compilation_level, formatting,
                  output_wrapper, property_renaming_report, defs)
```

Turns JavaScript libraries into a minified optimized blob of code.

This rule must be used in conjunction with [closure_js_library].

#### Implicit Output Targets

- *name*.js: A minified JavaScript file containing all transitive sources.

- *name*.js.map: Sourcemap file mapping compiled sources to their raw
  sources. This file can be loaded into browsers such as Chrome and Firefox to
  view a stacktrace when an error is thrown by compiled sources.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the .js and .js.map output files and `data` will
  contain those files in addition to all transitive JS sources and data.

- [closure_js_library]: `srcs` will be the .js output file, `language` will be
  the output language, `deps` will be empty, `data` will contain all transitive
  data, and `no_closure_library` will be `True`.

### Arguments

- **name:** ([Name]; required) A unique name for this rule. Convention states
  that such rules be named `foo_bin` or `foo_dbg` if `debug = True`.

- **deps:** (List of [labels]; required) Direct dependency list. This attribute
  has the same meaning as it does in [closure_js_library].  These can point to
  [closure_js_library] and [closure_js_template_library] rules.

- **css:** (Label; optional) CSS class renaming target, which must point to a
  [closure_css_binary] rule. This causes the CSS name mapping file generated by
  the CSS compiler to be included in the compiled JavaScript.  This tells
  Closure Compiler how to minify CSS class names.

  This attribute is required if any of JavaScript or template sources depend on
  a [closure_css_library]. This rule will check that all the referenced CSS
  libraries are present in the CSS binary.

- **debug:** (Boolean; optional; default is `False`) Enables debug mode. Many
  types of properties and variable names will be renamed to include `$`
  characters, to help you spot bugs when using `ADVANCED` compilation
  mode. Assert statements will not be stripped. Dependency directives will be
  removed.

- **language:** (String; optional; default is `"ECMASCRIPT3"`) Output language
  variant to which library sources are transpiled. The default is ES3 because it
  works in all browsers. The input language is calculated automatically based on
  the `language` attribute of [closure_js_library] dependencies.

- **entry_points:** (List of String; optional; default is `[]`) List of
  unreferenced namespaces that should *not* be pruned by the compiler. This
  should only be necessary when you want to invoke them from a `<script>` tag on
  your HTML page. See [Exports and Entry Points] to learn how this works with
  the `@export` feature. For further context, see the Closure Compiler
  documentation on [managing dependencies].

- **dependency_mode:** (String; optional; default is `"LOOSE"`) In rare
  circumstances you may want to set this flag to `"STRICT"`. See the
  [Exports and Entry Points] unit tests and the Closure Compiler's
  [managing dependencies] documentation for more information.

- **compilation_level:** (String; optional; default is `"ADVANCED"`) Specifies
  how minified you want your JavaScript binary to be. Valid options are:

  - `ADVANCED`: Enables maximal minification and type checking. This is
    *strongly* recommended for production binaries. **Warning:** Properties that
    are accessed with dot notation will be renamed. Use quoted notation if this
    presents problems for you, e.g. `foo['bar']`, `{'bar': ...}`.

  - `SIMPLE`: Tells the Closure Compiler to function more like a traditional
    JavaScript minifier. Type checking becomes disabled. Local variable names
    will be minified, but object properties and global names will
    not. Namespaces will be managed. Code that will never execute will be
    removed. Local functions and variables can be inlined, but globals can not.

  - `WHITESPACE_ONLY`: Tells the Closure Compiler to strip whitespace and
    comments. Transpilation between languages will still work. Type checking
    becomes disabled. No symbols will be renamed. Nothing will be inlined.
    Dependency statements will not be removed. **ProTip:** If you're using the
    Closure Library, you'll need to look into the `CLOSURE_NO_DEPS` and
    `goog.ENABLE_DEBUG_LOADER` options in order to execute the compiled output.)

- **formatting:** (String; optional) Specifies what is passed to the
  `--formatting` flag of the Closure Compiler. The following options are valid:

  - `PRETTY_PRINT`
  - `PRINT_INPUT_DELIMITER`
  - `SINGLE_QUOTES`

- **output_wrapper:** (String; optional) Interpolate output into this string at
  the place denoted by the marker token `%output%`. Use the marker token
  `%output|jsstring%` to do JS string escaping on the output. The default
  behavior is to generate code that pollutes the global namespace. Many users
  will want to set this to `"(function(){%output%}).call(this);"` instead. See
  the [Closure Compiler FAQ][output-wrapper-faq] for more details.

- **property_renaming_report:** (File; optional) Output file for property
  renaming report. It will contain lines in the form of `old:new`. This feature
  has some fringe use cases, such as minifying JSON messages. However it's
  recommended that you use protobuf instead.

- **defs:** (List of strings; optional) Specifies additional flags to be passed
  to the Closure Compiler, e.g. `"--hide_warnings_for=some/path/"`. To see what
  flags are available, run:
  `bazel run @io_bazel_rules_closure//third_party/java/jscomp:main -- --help`

### Support for AngularJS

When compiling AngularJS applications, you need to pass custom flags to the
Closure Compiler. This can be accomplished by adding the following to your
[closure_js_binary] rule:

```starlark
closure_js_binary(
    # ...
    defs = [
        "--angular_pass",
        "--export_local_property_definitions",
    ],
)
```

## closure\_js\_test

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_test")
closure_js_test(name, srcs, data, deps, css, html, language, suppress,
                compilation_level, entry_points, defs)
```

Runs JavaScript unit tests inside a headless web browser.

This is a build macro that composes [closure_js_library], [closure_js_binary],
and [phantomjs_test].

A test is defined as any function in the global namespace that begins with
`test`, `setUp`, or `tearDown`. You are not required to `@export` these
functions. If you don't have a global namespace, because you're using
`goog.module` or `goog.scope`, then you must register your test functions with
`goog.testing.testSuite`.

Each test file should require `goog.testing.jsunit` and `goog.testing.asserts`
because they run the tests and provide useful [testing functions][asserts] such
as `assertEquals()`.

Any JavaScript file related to testing is strongly recommended to contain a
`goog.setTestOnly()` statement in the file. However this is not required,
because some projects might not want to directly reference Closure Library
functions.

#### No Network Access

Your test will run within a hermetically sealed environment. You are not allowed
to send HTTP requests to any external servers. It is expected that you'll use
Closure Library mocks for things like XHR. However a local HTTP server is
started up on a random port that allows to request runfiles under the
`/filez/WORKSPACE_NAME/` path.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the outputted executable, `data` will contain
  all transitive sources, data, and other runfiles.

### Arguments

- **name:** ([Name]; required) A unique name for this rule.

- **srcs:** (List of [labels]; required) List of `_test.js` source files that
  register test functions.

- **deps:** (List of [labels]; optional) Direct dependency list passed along to
  [closure_js_library].

- **data:** (List of [labels]; optional) Passed to [closure_js_library].

- **css:** Passed to [closure_js_binary].

- **html:** Passed to [phantomjs_test].

- **language:** Passed to [closure_js_binary].

- **compilation_level:** Passed to [closure_js_binary]. Setting this to
  `"WHITESPACE_ONLY"` will cause tests to run significantly faster (at the
  expense of type checking.)

- **suppress:** Passed to [closure_js_library].

- **entry_points:** If a dict, the source file is looked up for the value to pass to [closure_js_binary].  Otherwise, passed directly to [closure_js_binary].

- **defs:** Passed to [closure_js_binary].


## phantomjs\_test

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "phantomjs_test")
phantomjs_test(name, data, deps, html, harness, runner)
```

Runs PhantomJS (QtWebKit) for unit testing purposes.

This is a low level rule. Please use the [closure_js_test] macro if possible.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the outputted executable, `data` will contain
  all transitive sources, data, and other runfiles.

### Arguments

- **name:** ([Name]; required) Unique name for this rule.

- **data:** (List of [labels]; optional) Additional runfiles for the local HTTP
  server to serve, under the `/filez/` + repository path. This attribute should
  not be necessary, because the transitive runfile data is already collected
  from dependencies.

- **deps:** (List of [labels]; required) Labels of Skylark rules exporting
  `transitive_js_srcs`. Each source will be inserted into the webpage in its own
  `<script>` tag based on a depth-first preordering.

- **html:** (Label; optional; default is
  `"@io_bazel_rules_closure//closure/testing:empty.html"`) HTML file containing
  DOM structure of virtual web page *before* `<script>` tags are automatically
  inserted. Do not include a doctype in this file.

- **harness:** (Label; required; default is
  `"@io_bazel_rules_closure//closure/testing:phantomjs_harness"`) JS binary or
  library exporting a single source file, to be used as the PhantomJS outer
  script.

- **runner:** (Label; optional; default is
  `"@io_bazel_rules_closure//closure/testing:phantomjs_jsunit_runner"`) Same as
  `deps` but guaranteed to be loaded inside the virtual web page last. This
  should run whatever tests got loaded by `deps` and then invoke `callPhantom`
  to report the result to the `harness`.


## closure\_js\_template\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_template_library")
closure_js_template_library(name, srcs, data, deps, globals, plugin_modules,
                            should_generate_js_doc,
                            should_generate_soy_msg_defs,
                            bidi_global_dir,
                            soy_msgs_are_external,
                            defs)
```

Compiles Closure templates to JavaScript source files.

This rule is necessary in order to render Closure templates from within
JavaScript code.

This rule pulls in a transitive dependency on the Closure Library.

The documentation on using Closure Templates can be found
[here][Closure Templates].

For additional help on using some of these attributes, please see the output of
the following:

    bazel run @com_google_template_soy//:SoyToJsSrcCompiler -- --help

#### Implicit Output Targets

- *src*.js: A separate JavaScript source file is generated for each file listed
  under `srcs`. The filename will be the same as the template with a `.js`
  suffix. For example `foo.soy` would become `foo.soy.js`.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the generated JS output files and `data` will
  contain all transitive JS sources and data.

- [closure_js_library]: `srcs` will be the generated JS output files, `data`
  will contain the transitive data, `deps` will contain necessary libraries, and
  `no_closure_library` will be `False`.

### Arguments

- **name:** ([Name]; required) A unique name for this rule.

- **srcs:** (List of [labels]; required) A list of `.soy` source files that
  represent this library.

- **data:** (List of [labels]; optional) Runfiles directly referenced by Soy
  sources in this rule. For example, if the template has an `<img src=foo.png>`
  tag, then the data attribute of its rule should be set to `["foo.png"]` so the
  image is available in the web server runfiles.

- **deps:** (List of [labels]; optional) List of [closure_js_library],
  [closure_js_template_library] and [closure_js_proto_library] targets which
  define symbols referenced by the template.

- **globals:** (List of [labels]; optional) List of text files containing symbol
  definitions that are only considered at compile-time. For example, this file
  might look as follows:

      com.foo.bar.Debug.PRODUCTION = 0
      com.foo.bar.Debug.DEBUG = 1
      com.foo.bar.Debug.RAW = 2

- **plugin_modules:** (List of [labels]; optional; default is `[]`) Passed along
  verbatim to the SoyToJsSrcCompiler above.

- **should_generate_js_doc:** (Boolean; optional; default is `True`) Passed
  along verbatim to the SoyToJsSrcCompiler above.

- **should_generate_soy_msg_defs:** (Boolean; optional; default is `False`)
  Passed along verbatim to the SoyToJsSrcCompiler above.

- **bidi_global_dir:** (Integer; optional; default is `1`)
  Passed along verbatim to the SoyToJsSrcCompiler above.
  Valid values are 1 (LTR) or -1 (RTL).

- **soy_msgs_are_external:** (Boolean; optional; default is `False`) Passed
  along verbatim to the SoyToJsSrcCompiler above.

- **defs:** (List of strings; optional) Passed along verbatim to the
  SoyToJsSrcCompiler above.

## closure\_java\_template\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_java_template_library")
closure_java_template_library(name, srcs, data, deps, java_package)
```

Compiles Closure templates to Java source files.

This rule is necessary in order to serve Closure templates from a Java backend.

Unlike [closure_js_template_library], globals are not specified by this rule.
They get added at runtime by your Java code when serving templates.

This rule pulls in a transitive dependency on Guava, Guice, and ICU4J.

The documentation on using Closure Templates can be found
[here][Closure Templates].

For additional help on using some of these attributes, please see the output of
the following:

    bazel run @com_google_template_soy//:SoyParseInfoGenerator -- --help

#### Implicit Output Targets

- SrcSoyInfo.java: A separate Java source file is generated for each file
  listed under `srcs`. The filename will be the same as the template, converted
  to upper camel case, with a `SoyInfo.java` suffix. For example `foo_bar.soy`
  would become `FooBarSoyInfo.java`.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the compiled jar file and `data` will contain all
  transitive data.

- [java_library]: `srcs` will be the generated Java source files, and `data`
  will contain the transitive data.

### Arguments

- **name:** ([Name]; required) A unique name for this rule.

- **srcs:** (List of [labels]; required) A list of `.soy` source files that
  represent this library.

- **data:** (List of [labels]; optional) Runfiles directly referenced by Soy
  sources in this rule. For example, if the template has an `<img src=foo.png>`
  tag, then the data attribute of its rule should be set to `["foo.png"]` so the
  image is available in the web server runfiles.

- **deps:** (List of [labels]; optional) Soy files to parse but not to generate
  outputs for.

- **java_package:** (List of [labels]; required) The package for the Java files
  that are generated, e.g. `"com.foo.soy"`.


## closure\_py\_template\_library

TODO


## closure\_css\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_css_library")
closure_css_library(name, srcs, data, deps)
```

Defines a set of CSS stylesheets.

This rule does not compile your stylesheets; it is used in conjunction with
[closure_css_binary] which produces the minified CSS file.

This rule should be referenced by any [closure_js_library] rule whose sources
contain a `goog.getCssName('foo')` call if `foo` is a CSS class name defined by
this rule. The same concept applies to [closure_js_template_library] rules that
contain `{css('foo')}` expressions.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the generated JS output files and `data` will
  contain all transitive CSS/GSS sources and data.

- [closure_js_library]: `srcs` is empty, `data` is the transitive CSS sources
  and data, and `no_closure_library` is `True`. However the
  closure\_css\_library rule does pass special information along when used as a
  dep in closure\_js\_library. See its documentation to learn more.

### Arguments

- **name:** ([Name]; required) A unique name for this rule. Convention states
  that this end with `_lib`.

- **srcs:** (List of [labels]; required) A list of `.gss` or `.css` source files
  that represent this library.

  The order of stylsheets is `srcs` is undefined. If a CSS file overrides
  definitions in another CSS file, then each file must be specified in separate
  [closure_css_library] targets. That way Bazel can order your CSS definitions
  based on the depth-first preordering of dependent rules.

  It is strongly recommended you use `@provide` and `@require` statements in
  your stylesheets so the CSS compiler can assert that the ordering is accurate.

- **data:** (List of [labels]; optional) Runfiles directly referenced by CSS
  sources in this rule. For example, if the CSS has a `url(foo.png)` then the
  data attribute of its rule should be set to `["foo.png"]` so the image is
  available in the web server runfiles.

- **deps:** (List of [labels]; optional) List of other [closure_css_library]
  targets on which the CSS files in `srcs` depend.

- **orientation:** (String; optional; default is `"LTR"`) Defines the text
  direction for which this CSS was designed. This value can be:

  - `LTR`: Outputs a sheet suitable for left to right display.
  - `RTL`: Outputs a sheet suitable for right to left display.

  An error will be raised if any `deps` do not have the same orientation. CSS
  libraries with different orientations can be linked together by creating an
  intermediary [closure_css_binary] that flips its orientation.


## closure\_css\_binary

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_css_binary")
closure_css_binary(name, deps, renaming, debug, defs)
```

Turns stylesheets defined by [closure_css_library] rules into a single minified
CSS file.

Closure-specific syntax such as variables, functions, conditionals, and mixins
will be evaluated and turned into normal CSS. The documentation on using these
features can be found [here][Closure Stylesheets].

Unlike most CSS minifiers, this will minify class names by default. So this rule
can be referenced by the `css` flag of [closure_js_binary], in order to let the
Closure Compiler know how to substitute the minified class names. See the
`renaming` documentation below for more information.

#### Implicit Output Targets

- *name*.css: A minified CSS file defining the transitive closure of dependent
  stylesheets compiled in a depth-first preordering.

- *name*.css.map: [CSS sourcemap file][css-sourcemap]. This tells browsers like
  Chrome and Firefox where your CSS definitions are located in their original
  source files.

- *name*.css.js: JavaScript file containing a `goog.setCssNameMapping()`
  statement which tells the Closure Compiler and Library how to minify CSS class
  names. The use of this file is largely handled transparently by the build
  system. The user should only need to worry about this file when rendering Soy
  templates from Java code, because its contents will need to be parsed into a
  map using a regular expression, which is then passed to the Soy Tofu Java
  runtime.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be the generated .css, .css.map, and .css.js output
  files. `data` will contain all transitive CSS/GSS sources and data.

- [closure_css_library]: `srcs` is the output .css file, `data` is the
  transitive CSS sources and data, and `orientation` is the output orientation.

### Arguments

- **name:** ([Name]; required) A unique name for this rule. Convention states
  that such rules be named `foo_bin` or `foo_dbg` if `debug = True`.

- **deps:** (List of [labels]; required) List of [closure_css_library] rules to
  compile. All dependencies must have their `orientation` attribute set to the
  same value.

- **renaming:** (Boolean; optional; default is `True`) Enables CSS class name
  minification. This is one of the most powerful features of the Closure Tools.
  By default, this will turn class names like `.foo-bar` into things like
  `.a-b`. If `debug = True` then it will be renamed `.foo_-bar_`.

  In order for this to work, you must update your JavaScript code to use the
  `goog.getCssName("foo-bar")` when referencing class names. JavaScript
  library targets that reference CSS classes must add the appropriate CSS
  library to its `deps` attribute. The `css` attribute of the
  [closure_js_binary] also needs to be updated to point to this CSS binary
  target, so the build system can verify (at compile time) that your CSS and
  JS binaries are both being compiled in a harmonious way.

  You'll also need update your templates to say `{css('foo-bar')}` in place of
  class names. The [closure_js_template_library] must also depend on the
  appropriate CSS library.

- **debug:** (Boolean; optional; default is `False`) Enables debug mode, which
  causes the compiled stylesheet to be pretty printed. If `renaming = True` then
  class names will be renamed, but still readable to humans.

- **orientation:** (String; optional; default is `"NOCHANGE"`) Specify this
  option to perform automatic right to left conversion of the input. You can
  choose between:

  - `NOCHANGE`: Uses same orientation as was specified in dependent libraries.
  - `LTR`: Outputs a sheet suitable for left to right display.
  - `RTL`: Outputs a sheet suitable for right to left display.

  The input orientation is calculated from the `orientation` flag of all
  [closure_css_library] targets listed in `deps`. If the input orientation is
  different than the requested output orientation, then 'left' and 'right'
  values in direction sensitive style rules are flipped. If the input already
  has the desired orientation, this option effectively does nothing except for
  defining `GSS_LTR` and `GSS_RTL`, respectively.

- **vendor:** (String; optional; default is `None`) Creates
  browser-vendor-specific output by stripping all proprietary browser-vendor
  properties from the output except for those associated with this vendor. Valid
  values are:

  - `WEBKIT`
  - `MOZILLA`
  - `MICROSOFT`
  - `OPERA`
  - `KONQUEROR`

  The default behavior is to not strip any browser-vendor properties.

- **defs:** (List of strings; optional) Specifies additional flags to be passed
  to the Closure Stylesheets compiler. To see what flags are available, run:
  `bazel run @com_google_closure_stylesheets//:ClosureCommandLineCompiler -- --help`


## closure\_js\_proto\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_proto_library")
closure_js_proto_library(name, srcs, add_require_for_enums, binary,
                         import_style)
```

Defines a set of Protocol Buffer files.

#### Documentation

- [Protocol Buffers] GitHub project
- [Protobuf JavaScript][protobuf-js]
- [Generator Options][protobuf-generator]

#### Implicit Output Targets

- *name*.js: A generated protocol buffer JavaScript library.

- *name*.descriptor: A protoc FileDescriptorsSet representation of the .proto
  files.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [filegroup]: `srcs` will be empty and `data` will contain all transitive JS
  sources and data.

- [closure_js_library]: `srcs` will be the generated JS output files, `data`
  will contain the transitive data, and `deps` will contain necessary libraries.

### Arguments

- **name:** ([Name]; required) A unique name for this rule. Convention states
  that such rules be named `foo_proto`.

- **srcs:** (List of [labels]; required) A list of `.proto` source files that
  represent this library.

- **add_require_for_enums:** (Boolean; optional; default is `False`) Add a
  `goog.require()` call for each enum type used. If false, a forward
  declaration with `goog.forwardDeclare` is produced instead.

- **binary:** (Boolean; optional; default is `True`) Enable binary-format
  support.

- **import_style:** (String; optional; default is `IMPORT_CLOSURE`) Specifies
  the type of imports that should be used. Valid values are:

  - `IMPORT_CLOSURE`    // goog.require()
  - `IMPORT_COMMONJS`   // require()
  - `IMPORT_BROWSER`    // no import statements
  - `IMPORT_ES6`        // import { member } from ''


## closure\_proto\_library

```starlark
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_proto_library")
closure_proto_library(name, deps)
```

`closure_proto_library` generates JS code from `.proto` files.

`deps` must point to [proto_library] rules.

#### Rule Polymorphism

This rule can be referenced as though it were the following:

- [closure_js_library]: `srcs` will be the generated JS files,
  and `deps` will contain necessary libraries.

- **name:** ([Name]; required) A unique name for this rule. Convention states
  that such rules be named `*_closure_proto`.

- **deps:** (List of [labels]; required) The list of [proto_library] rules
  to generate JS code for.

[Bazel]: http://bazel.build/
[Closure Compiler]: https://developers.google.com/closure/compiler/
[Closure Library]: https://developers.google.com/closure/library/
[Closure Stylesheets]: https://github.com/google/closure-stylesheets
[Closure Templates]: https://developers.google.com/closure/templates/
[Closure Tools]: https://developers.google.com/closure/
[Closure coding conventions]: https://github.com/google/closure-compiler/blob/master/src/com/google/javascript/jscomp/ClosureCodingConvention.java
[ECMASCRIPT6]: http://es6-features.org/
[Exports and Entry Points]: https://github.com/bazelbuild/rules_closure/blob/master/closure/compiler/test/exports_and_entry_points/BUILD
[Google JavaScript Style Guide]: https://google.github.io/styleguide/jsguide.html
[Google coding conventions]: https://github.com/google/closure-compiler/blob/master/src/com/google/javascript/jscomp/GoogleCodingConvention.java
[Name]: https://docs.bazel.build/versions/master/build-ref.html#name
[PhantomJS]: http://phantomjs.org/
[ProcessEs6Modules]: https://github.com/google/closure-compiler/blob/1281ed9ded137eaf578bb65a588850bf13f38aa4/src/com/google/javascript/jscomp/ProcessEs6Modules.java
[Protocol Buffers]: https://github.com/google/protobuf
[acyclic]: https://en.wikipedia.org/wiki/Directed_acyclic_graph
[asserts]: https://github.com/google/closure-library/blob/master/closure/goog/testing/asserts.js#L1308
[base.js]: https://github.com/google/closure-library/blob/master/closure/goog/base.js
[install Bazel]: https://docs.bazel.build/versions/master/install.html
[blockers]: https://github.com/bazelbuild/rules_closure/labels/launch%20blocker
[closure_css_binary]: #closure_css_binary
[closure_css_library]: #closure_css_library
[closure_grpc_web_library]: https://github.com/grpc/grpc-web/blob/9b7b2d5411c486aa646ba2491cfd894d5352775b/bazel/closure_grpc_web_library.bzl#L149
[closure_java_template_library]: #closure_java_template_library
[closure_js_binary]: #closure_js_binary
[closure_js_library]: #closure_js_library
[closure_js_proto_library]: #closure_js_proto_library
[closure_js_template_library]: #closure_js_template_library
[closure_js_test]: #closure_js_test
[closure_proto_library]: #closure_proto_library
[closure_py_template_library]: #closure_py_template_library
[coffeescript]: http://coffeescript.org/
[compiler-issue]: https://github.com/google/closure-compiler/issues/new
[css-sourcemap]: https://developer.chrome.com/devtools/docs/css-preprocessors
[dependency]: https://docs.bazel.build/versions/master/build-ref.html#dependencies
[filegroup]: https://docs.bazel.build/versions/master/be/general.html#filegroup
[idom-example]: https://github.com/bazelbuild/rules_closure/blob/80d493d5ffc3099372929a8cd4a301da72e1b43f/closure/templates/test/greeter_idom.js
[java_library.exports]: https://docs.bazel.build/versions/master/be/java.html#java_library.exports
[java_library]: https://docs.bazel.build/versions/master/be/java.html#java_library
[jquery]: http://jquery.com/
[labels]: https://docs.bazel.build/versions/master/build-ref.html#labels
[managing dependencies]: https://github.com/google/closure-compiler/wiki/Managing-Dependencies
[output-wrapper-faq]: https://github.com/google/closure-compiler/wiki/FAQ#when-using-advanced-optimizations-closure-compiler-adds-new-variables-to-the-global-scope-how-do-i-make-sure-my-variables-dont-collide-with-other-scripts-on-the-page
[phantomjs-bug]: https://github.com/ariya/phantomjs/issues/14028
[phantomjs_test]: #phantomjs_test
[proto_library]: https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library
[protobuf-generator]: https://github.com/google/protobuf/blob/master/src/google/protobuf/compiler/js/js_generator.h
[protobuf-js]: https://github.com/google/protobuf/tree/master/js
[repositories.bzl]: https://github.com/bazelbuild/rules_closure/tree/master/closure/repositories.bzl
[verbose]: https://github.com/google/closure-library/blob/master/closure/goog/html/safehtml.js
