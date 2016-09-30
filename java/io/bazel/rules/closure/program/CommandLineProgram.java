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

package io.bazel.rules.closure.program;

import java.io.IOException;
import java.util.Collection;

/**
 * Interface for command line programs.
 *
 * <p>This is the same thing as a main function, except not static.
 */
public interface CommandLineProgram {

  /**
   * Runs blocking program start to finish.
   *
   * <p>This function might be called multiple times throughout the life of this object. Output
   * must be sent to {@link System#out} and {@link System#err}.
   *
   * @param args command line arguments
   * @return program exit code, i.e. 0 for success, non-zero for failure
   */
  int run(Collection<String> args) throws IOException;
}
