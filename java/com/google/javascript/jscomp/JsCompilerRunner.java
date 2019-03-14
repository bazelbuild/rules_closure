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

import com.google.common.collect.Iterables;
import com.google.javascript.jscomp.deps.ModuleLoader;
import java.io.IOException;

final class JsCompilerRunner extends CommandLineRunner {

  private final Compiler compiler;
  private final boolean exportTestFunctions;
  private final WarningsGuard warnings;

  JsCompilerRunner(
      Iterable<String> args,
      Compiler compiler,
      boolean exportTestFunctions,
      WarningsGuard warnings) {
    super(Iterables.toArray(args, String.class));
    this.compiler = compiler;
    this.exportTestFunctions = exportTestFunctions;
    this.warnings = warnings;
  }

  int go() throws IOException {
    try {
      return doRun();
    } catch (FlagUsageException e) {
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
    options.addWarningsGuard(warnings);
    options.setModuleResolutionMode(ModuleLoader.ResolutionMode.NODE);
    return options;
  }
}
