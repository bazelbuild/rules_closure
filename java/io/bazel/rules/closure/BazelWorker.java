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

import static com.google.common.base.Preconditions.checkNotNull;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.Iterables;
import com.google.devtools.build.lib.worker.WorkerProtocol.WorkRequest;
import com.google.devtools.build.lib.worker.WorkerProtocol.WorkResponse;
import io.bazel.rules.closure.program.CommandLineProgram;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Collection;

/**
 * Bazel worker runner.
 *
 * <p>This class adapts a traditional command line program so it can be spawned by Bazel as a
 * persistent worker process that handles multiple invocations per JVM. It will also be backwards
 * compatible with being run as a normal single-invocation command.
 */
final class BazelWorker implements CommandLineProgram {

  private final CommandLineProgram delegate;

  BazelWorker(CommandLineProgram delegate) {
    this.delegate = checkNotNull(delegate, "delegate");
  }

  @Override
  public int run(Collection<String> args) throws IOException {
    if (args.contains("--persistent_worker")) {
      return runAsPersistentWorker();
    } else {
      return delegate.run(loadArguments(args));
    }
  }

  private int runAsPersistentWorker() {
    // The goal here is to make sure nothing gets printed aside from the response proto.
    try {
      PrintStream originalStdOut = System.out;
      PrintStream originalStdErr = System.err;
      ByteArrayOutputStream buffer = new ByteArrayOutputStream();
      try (PrintStream ps = new PrintStream(buffer)) {
        System.setOut(ps);
        System.setErr(ps);
        while (true) {
          WorkRequest request = WorkRequest.parseDelimitedFrom(System.in);
          if (request == null) {
            return 0;
          }
          int exitCode = 0;
          try {
            exitCode = delegate.run(request.getArgumentsList());
          } catch (Exception e) {
            e.printStackTrace(ps);
            exitCode = 1;
          }
          WorkResponse.newBuilder()
              .setOutput(buffer.toString())
              .setExitCode(exitCode)
              .build()
              .writeDelimitedTo(originalStdOut);
          originalStdOut.flush();
          buffer.reset();
          System.gc();  // be a good little worker process and consume less memory when idle
        }
      } finally {
        System.setOut(originalStdOut);
        System.setErr(originalStdErr);
      }
    } catch (IOException ignored) {
      return 1;
    }
  }

  private static Collection<String> loadArguments(Collection<String> args) throws IOException {
    String lastArg = Iterables.getLast(args, "");
    // When we pass the arguments list to ctx.action() the last argument is a @file.txt containing
    // the actual list of arguments. If it's not there, then this program was probably run the
    // normal way off the command line.
    if (lastArg.startsWith("@")) {
      return Files.readAllLines(Paths.get(lastArg.substring(1)), UTF_8);
    }
    return args;
  }
}
