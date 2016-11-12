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

import com.google.common.collect.ImmutableSet;

/** Coding styles that affect how the compiler and linter works. */
enum JsCheckerConvention {
  NONE(CodingConventions.getDefault(), ImmutableSet.<DiagnosticType>of()),
  GOOGLE(new GoogleCodingConvention(), Diagnostics.GOOGLE_LINTER_CHECKS),
  CLOSURE(new JsCheckerClosureCodingConvention(), Diagnostics.CLOSURE_LINTER_CHECKS),
  JQUERY(new JqueryCodingConvention(), ImmutableSet.<DiagnosticType>of());

  final CodingConvention convention;
  final ImmutableSet<DiagnosticType> diagnostics;

  private JsCheckerConvention(
      CodingConvention convention,
      ImmutableSet<DiagnosticType> diagnostics) {
    this.convention = convention;
    this.diagnostics = diagnostics;
  }
}
