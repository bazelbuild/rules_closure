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

import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.Iterables;
import io.bazel.rules.closure.program.CommandLineProgram;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/** Closure Rules runner for Closure Compiler. */
public final class JsCompiler implements CommandLineProgram {

  private static final byte[] EMPTY_BYTE_ARRAY = new byte[0];

  private static final class Runner extends CommandLineRunner {

    private final Compiler compiler;
    private final boolean exportTestFunctions;

    Runner(Iterable<String> args, Compiler compiler, boolean exportTestFunctions) {
      super(Iterables.toArray(args, String.class));
      this.compiler = compiler;
      this.exportTestFunctions = exportTestFunctions;
    }

    int go() throws IOException {
      try {
        return doRun();
      } catch (AbstractCommandLineRunner.FlagUsageException e) {
        System.err.println(e.getMessage());
        System.exit(1);
        return 1;
      }
    }

    @Override
    protected Compiler createCompiler() {
      return compiler;
    }

    @Override
    protected CompilerOptions createOptions() {
      CompilerOptions options = super.createOptions();
      options.setExportTestFunctions(exportTestFunctions);
      return options;
    }
  }

  @Override
  public int run(Collection<String> args) throws IOException {
    // Our flags, which we won't pass along to the compiler.
    Path outputErrors = null;
    boolean expectFailure = false;
    boolean expectWarnings = false;
    boolean exportTestFunctions = false;

    // Compiler flags we want to read.
    Path jsOutputFile = null;
    Path createSourceMap = null;

    // Parse flags in an ad-hoc manner.
    List<String> passThroughArgs = new ArrayList<>(args.size());
    for (String arg : args) {
      if (arg.startsWith("--output_errors=")) {
        outputErrors = Paths.get(arg.substring(16));
      } else if (arg.equals("--expect_failure")) {
        expectFailure = true;
      } else if (arg.equals("--expect_warnings")) {
        expectWarnings = true;
      } else if (arg.equals("--export_test_functions")) {
        exportTestFunctions = true;
      } else {
        if (arg.startsWith("--js_output_file=")) {
          jsOutputFile = Paths.get(arg.substring(17));
        } else if (arg.startsWith("--create_source_map=")) {
          createSourceMap = Paths.get(arg.substring(20));
        }
        passThroughArgs.add(arg);
      }
    }

    // Run the compiler, capturing error messages.
    boolean failed = false;
    Compiler compiler = new Compiler();
    LightweightMessageFormatter errorFormatter = new LightweightMessageFormatter(compiler);
    errorFormatter.setColorize(true);
    JsCheckerErrorManager errorManager = new JsCheckerErrorManager(errorFormatter);
    compiler.setErrorManager(errorManager);
    Runner runner = new Runner(passThroughArgs, compiler, exportTestFunctions);
    if (runner.shouldRunCompiler()) {
      failed |= runner.go() != 0;
    }
    failed |= runner.hasErrors();

    // Output error messages based on diagnostic settings.
    if (!expectFailure && !expectWarnings) {
      for (String line : errorManager.stderr) {
        System.err.println(line);
      }
      System.err.flush();
    }
    if (outputErrors != null) {
      Files.write(outputErrors, errorManager.stderr, UTF_8);
    }
    if (failed && expectFailure) {
      // If we don't return nonzero, Bazel expects us to create every output file.
      if (jsOutputFile != null) {
        Files.write(jsOutputFile, EMPTY_BYTE_ARRAY);
      }
      if (createSourceMap != null) {
        Files.write(createSourceMap, EMPTY_BYTE_ARRAY);
      }
    }
    if (!failed && expectFailure) {
      System.err.println("ERROR: Expected failure but didn't fail.");
    }
    return failed == expectFailure ? 0 : 1;
  }
}
