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

import com.google.javascript.jscomp.NodeTraversal.AbstractShallowCallback;
import com.google.javascript.rhino.Node;

final class CheckSetTestOnly
    extends AbstractShallowCallback implements CompilerPass {

  public static final DiagnosticType INVALID_SETTESTONLY =
      DiagnosticType.error(
          "CR_INVALID_SETTESTONLY",
          "Not allowed here because closure_js_library {0} does not have testonly=1.");

  private final JsCheckerState state;
  private final AbstractCompiler compiler;

  CheckSetTestOnly(JsCheckerState state, AbstractCompiler compiler) {
    this.state = state;
    this.compiler = compiler;
  }

  @Override
  public final void process(Node externs, Node root) {
    NodeTraversal.traverse(compiler, root, this);
  }

  @Override
  public final void visit(NodeTraversal t, Node n, Node parent) {
    if (!state.testonly
        && !state.legacy // GJD failed for things like goog.testing.stacktrace
        && n.isCall()
        && n.getFirstChild().matchesQualifiedName("goog.setTestOnly")) {
      t.report(n, INVALID_SETTESTONLY, state.label);
      return;
    }
  }
}
