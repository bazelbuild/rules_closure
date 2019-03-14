// Copyright 2017 The Closure Rules Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package io.bazel.rules.closure.worker;

import static com.google.common.base.Strings.nullToEmpty;

/** Bazel error prefixes. */
public final class Prefixes {

  private static final boolean WANT_COLOR =
      System.getenv("NO_COLOR") == null && nullToEmpty(System.getenv("TERM")).contains("xterm");

  private static final String RESET = WANT_COLOR ? "\u001b[0m" : "";
  private static final String BOLD = WANT_COLOR ? "\u001b[1m" : "";
  private static final String RED = WANT_COLOR ? "\u001b[31m" : "";
  private static final String BLUE = WANT_COLOR ? "\u001b[34m" : "";
  private static final String MAGENTA = WANT_COLOR ? "\u001b[35m" : "";

  /** Error message prefix with ANSI colors. */
  public static final String ERROR = String.format("%s%sERROR:%s ", BOLD, RED, RESET);

  /** Warning message prefix with ANSI colors. */
  public static final String WARNING = String.format("%sWARNING:%s ", MAGENTA, RESET);

  /** Note message prefix with ANSI colors. */
  public static final String NOTE = String.format("%s%sNOTE:%s ", BOLD, BLUE, RESET);

  private Prefixes() {}
}
