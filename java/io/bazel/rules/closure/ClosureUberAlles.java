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

package io.bazel.rules.closure;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Iterables;
import com.google.javascript.jscomp.JsChecker;
import com.google.javascript.jscomp.JsCompiler;
import io.bazel.rules.closure.program.CommandLineProgram;
import java.io.IOException;
import java.util.Collection;

/** Bazel worker for all Closure Tools programs, some of which are modded. */
public final class ClosureUberAlles implements CommandLineProgram {

  private ClosureUberAlles() {}

  @Override
  public int run(Collection<String> args) throws IOException {
    String head = Iterables.getFirst(args, "");
    ImmutableList<String> tail = ImmutableList.copyOf(Iterables.skip(args, 1));
    // TODO(jart): Include Closure Templates and Stylesheets.
    switch (head) {
      case "JsChecker":
        return new JsChecker.Program().run(tail);
      case "JsCompiler":
        return new JsCompiler().run(tail);
      default:
        System.err.println(
            "\nERROR: First flag to ClosureUberAlles should be specific compiler to run, "
                + "e.g. JsChecker\n");
        return 1;
    }
  }

  public static void main(String[] args) throws IOException {
    System.exit(new BazelWorker(new ClosureUberAlles()).run(ImmutableList.copyOf(args)));
  }
}
