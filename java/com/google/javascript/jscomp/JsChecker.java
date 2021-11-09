/*
 * Copyright 2016 The Closure Rules Authors. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.javascript.jscomp;

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.javascript.jscomp.JsCheckerHelper.convertPathToModuleName;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;
import com.google.javascript.jscomp.CompilerOptions.IncrementalCheckMode;
import com.google.javascript.jscomp.CompilerOptions.LanguageMode;
import com.google.javascript.jscomp.parsing.Config;
import io.bazel.rules.closure.BuildInfo.ClosureJsLibrary;
import io.bazel.rules.closure.worker.CommandLineProgram;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.inject.Inject;
import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;

/**
 * Program for incrementally checking JavaScript code.
 *
 * <p>This program is invoked once for each {@code closure_js_library} rule. It validates JS files
 * for most of the really bad syntax errors, but doesn't do robust type checking because it can't
 * take the full program into consideration. This program also performs linting, which is something
 * that does not happen on {@code closure_js_binary} rules.
 *
 * <p>But most importantly, this program does strict dependency checking. It is able to verify that
 * required namespaces are provided by direct dependencies rather than transitive dependencies. It
 * does this in an incremental fashion by producing a txt file containing a sorted list of all
 * namespaces provided by the srcs listed in a {@code closure_js_library}. These files are then
 * accessed via the {@code --deps} flag on subsequent invocations for parent rules.
 */
public final class JsChecker {

  private static final String USAGE =
      String.format("Usage:\n  java %s [FLAGS]\n", JsChecker.class.getName());

  @Option(
      name = "--label",
      usage = "Name of rule being compiled.")
  private String label = "@repo//ohmygoth:some_lib";

  @Option(
      name = "--legacy",
      usage = "Used for sources defined by legacy rules.")
  private boolean legacy;

  @Option(
      name = "--src",
      usage = "JavaScript source and externs files.")
  private List<String> sources = new ArrayList<>();

  @Option(
      name = "--mystery_src",
      usage = "Transitive JS dependency whose position in the graph we're uncertain.")
  private List<String> mysterySources = new ArrayList<>();

  @Option(
      name = "--dep",
      usage = "foo-provides.txt files from deps targets.")
  private List<String> deps = new ArrayList<>();

  @Option(
      name = "--js_module_root",
      usage = "Prefixes to disregard in module namespaces, e.g. "
          + "bazel-out/local-fastbuild/genfiles. These values must be reverse sorted by the number "
          + "of path components.")
  private List<String> roots = new ArrayList<>();

  @Option(
      name = "--convention",
      usage = "Coding convention for linting.")
  private JsCheckerConvention convention = JsCheckerConvention.CLOSURE;

  @Option(
      name = "--suppress",
      usage = "Diagnostic types to not show as errors or warnings.")
  private List<String> suppress = new ArrayList<>();

  @Option(
      name = "--testonly",
      usage = "Indicates a testonly rule is being compiled.")
  private boolean testonly;

  @Option(
      name = "--output",
      usage = "Path of outputted ClosureJsLibrary.pbtxt file.")
  private String output = "";

  @Option(
      name = "--output_ijs_file",
      usage = "Path of the generated .i.js file representing the given sources.")
  private String outputIjsFile = "";

  @Option(
      name = "--output_errors",
      usage = "Name of output file for compiler errors in --nofail mode.")
  private String outputErrors = "";

  @Option(
      name = "--expect_failure",
      usage = "Invert exit code and disable printing warnings")
  private boolean expectFailure;

  @Option(
      name = "--help",
      usage = "Displays this message on stdout and exit")
  private boolean help;

  private boolean run() throws IOException {
    final JsCheckerState state = new JsCheckerState(label, legacy, testonly, roots, mysterySources);
    final Set<String> actuallySuppressed = new HashSet<>();

    // read provided files created by this program on deps
    for (String dep : deps) {
      state.provided.addAll(
          JsCheckerHelper.loadClosureJsLibraryInfo(Paths.get(dep))
              .getNamespaceList());
    }

    Map<String, String> labels = new HashMap<>();
    labels.put("", label);
    Set<String> modules = new LinkedHashSet<>();
    for (String source : sources) {
      for (String module : convertPathToModuleName(source, state.roots).asSet()) {
        modules.add(module);
        labels.put(module, label);
        state.provides.add(module);
      }
    }

    for (String source : mysterySources) {
      for (String module : convertPathToModuleName(source, state.roots).asSet()) {
        checkArgument(!module.startsWith("blaze-out/"),
            "oh no: %s", state.roots);
        modules.add(module);
        state.provided.add(module);
      }
    }

    // configure compiler
    Compiler compiler = new Compiler();
    CompilerOptions options = new CompilerOptions();
    options.setLanguage(LanguageMode.STABLE);
    options.setStrictModeInput(true);
    options.setIncrementalChecks(IncrementalCheckMode.GENERATE_IJS);
    options.setCodingConvention(convention.convention);
    options.setSkipTranspilationAndCrash(true);
    options.setContinueAfterErrors(true);
    options.setPrettyPrint(true);
    options.setPreserveTypeAnnotations(true);
    options.setPreserveDetailedSourceInfo(true);
    options.setEmitUseStrict(false);
    options.setParseJsDocDocumentation(Config.JsDocParsing.INCLUDE_DESCRIPTIONS_NO_WHITESPACE);
    JsCheckerErrorFormatter errorFormatter =
        new JsCheckerErrorFormatter(compiler, state.roots, labels);
    errorFormatter.setColorize(true);
    JsCheckerErrorManager errorManager = new JsCheckerErrorManager(errorFormatter);
    compiler.setErrorManager(errorManager);

    // configure which error messages appear
    if (!legacy) {
      for (String error
          : Iterables.concat(
              Diagnostics.JSCHECKER_ONLY_ERRORS,
              Diagnostics.JSCHECKER_EXTRA_ERRORS)) {
        options.setWarningLevel(Diagnostics.GROUPS.forName(error), CheckLevel.ERROR);
      }
    }
    final Set<DiagnosticType> suppressions = Sets.newHashSetWithExpectedSize(256);
    for (String code : suppress) {
      ImmutableSet<DiagnosticType> types = Diagnostics.getDiagnosticTypesForSuppressCode(code);
      if (types.isEmpty()) {
        System.err.println("ERROR: Bad --suppress value: " + code);
        return false;
      }
      suppressions.addAll(types);
    }

    options.addWarningsGuard(
        new WarningsGuard() {
          @Override
          public CheckLevel level(JSError error) {
            // TODO(jart): Figure out how to support this.
            if (error.getType().key
                    .equals("JSC_CONSTANT_WITHOUT_EXPLICIT_TYPE")) {
              return CheckLevel.OFF;
            }

            // Closure Rules will always ignore these checks no matter what.
            if (Diagnostics.IGNORE_ALWAYS.contains(error.getType())) {
              return CheckLevel.OFF;
            }

            // Disable warnings specific to conventions other than the one we're using.
            if (!convention.diagnostics.contains(error.getType())) {
              for (JsCheckerConvention conv : JsCheckerConvention.values()) {
                if (!conv.equals(convention)) {
                  if (conv.diagnostics.contains(error.getType())) {
                    suppressions.add(error.getType());
                    return CheckLevel.OFF;
                  }
                }
              }
            }
            // Disable warnings we've suppressed.
            Collection<String> groupNames = Diagnostics.DIAGNOSTIC_GROUPS.get(error.getType());
            if (suppressions.contains(error.getType())) {
              actuallySuppressed.add(error.getType().key);
              actuallySuppressed.addAll(groupNames);
              return CheckLevel.OFF;
            }
            // Ignore linter warnings on generated sources.
            if (groupNames.contains("lintChecks")
                && JsCheckerHelper.isGeneratedPath(error.getSourceName())) {
              return CheckLevel.OFF;
            }
            return null;
          }
        });

    // Run the compiler.
    compiler.setPassConfig(new JsCheckerPassConfig(state, options));
    compiler.disableThreads();
    compiler.compile(
        ImmutableList.<SourceFile>of(),
        getSourceFiles(Iterables.concat(sources, mysterySources)),
        options);

    // In order for suppress to be maintainable, we need to make sure the suppress codes relating to
    // linting were actually suppressed. However we can only offer this safety on the checks over
    // which JsChecker has sole dominion. Other suppress codes won't actually be suppressed until
    // they've been propagated up to the closure_js_binary rule.
    if (!suppress.contains("superfluousSuppress")) {
      Set<String> useless =
          Sets.intersection(
              Sets.difference(ImmutableSet.copyOf(suppress), actuallySuppressed),
              Diagnostics.JSCHECKER_ONLY_SUPPRESS_CODES);
      if (!useless.isEmpty()) {
        errorManager.report(CheckLevel.ERROR,
            JSError.make(Diagnostics.SUPERFLUOUS_SUPPRESS, label, Joiner.on(", ").join(useless)));
      }
    }

    // TODO: Make compiler.compile() package private so we don't have to do this.
    errorManager.stderr.clear();
    errorManager.generateReport();

    // write errors
    if (!expectFailure) {
      for (String line : errorManager.stderr) {
        System.err.println(line);
      }
    }
    if (!outputErrors.isEmpty()) {
      Files.write(Paths.get(outputErrors), errorManager.stderr, UTF_8);
    }

    // write .i.js type summary for this library
    if (!outputIjsFile.isEmpty()) {
      Files.write(Paths.get(outputIjsFile), compiler.toSource().getBytes(UTF_8));
    }

    // write file full of information about these sauces
    if (!output.isEmpty()) {
      ClosureJsLibrary.Builder info =
          ClosureJsLibrary.newBuilder()
              .setLabel(label)
              .setLegacy(legacy)
              .addAllNamespace(state.provides)
              .addAllModule(modules);
      if (!legacy) {
        for (DiagnosticType suppression : suppressions) {
          if (!Diagnostics.JSCHECKER_ONLY_SUPPRESS_CODES.contains(suppression.key)) {
            info.addSuppress(suppression.key);
          }
        }
      }
      Files.write(Paths.get(output), info.build().toString().getBytes(UTF_8));
    }

    return errorManager.getErrorCount() == 0;
  }

  private static ImmutableList<SourceFile> getSourceFiles(Iterable<String> filenames)
      throws IOException {
    ImmutableList.Builder<SourceFile> result = new ImmutableList.Builder<>();
    for (String filename : filenames) {
      if (filename.endsWith(".zip")) {
        result.addAll(SourceFile.fromZipFile(filename, UTF_8));
      } else {
        result.add(SourceFile.fromFile(filename));
      }
    }
    return result.build();
  }

  public static final class Program implements CommandLineProgram {

    @Inject
    Program() {}

    @Override
    public Integer apply(Iterable<String> args) {
      JsChecker checker = new JsChecker();
      CmdLineParser parser = new CmdLineParser(checker);
      parser.getProperties().withAtSyntax(false).withUsageWidth(80);
      try {
        parser.parseArgument(ImmutableList.copyOf(args));
      } catch (CmdLineException e) {
        System.err.println(e.getMessage());
        System.err.println(USAGE);
        parser.printUsage(System.err);
        System.err.println();
        return 1;
      }
      if (checker.help) {
        System.err.println(USAGE);
        parser.printUsage(System.out);
        System.err.println();
        return 0;
      }
      try {
        boolean success = checker.run();
        if (success && checker.expectFailure) {
          System.err.println("ERROR: Expected failure but did not fail");
        }
        return success == !checker.expectFailure ? 0 : 1;
      } catch (IOException e) {
        throw new RuntimeException(e);
      }
    }
  }
}
