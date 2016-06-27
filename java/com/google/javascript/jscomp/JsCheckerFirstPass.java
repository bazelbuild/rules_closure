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

import static com.google.javascript.jscomp.JsCheckerHelper.convertPathToModuleName;

import com.google.javascript.jscomp.NodeTraversal.AbstractShallowCallback;
import com.google.javascript.rhino.Node;

final class JsCheckerFirstPass extends AbstractShallowCallback implements HotSwapCompilerPass {

  public static final DiagnosticType INVALID_SETTESTONLY =
      DiagnosticType.error(
          "CR_INVALID_SETTESTONLY",
          "Not allowed here because closure_js_library {0} does not have testonly=1.");

  public static final DiagnosticType DUPLICATE_PROVIDES =
      DiagnosticType.error(
          "CR_DUPLICATE_PROVIDES", "Namespace provided multiple times by srcs of {0}.");

  public static final DiagnosticType REDECLARED_PROVIDES =
      DiagnosticType.error("CR_REDECLARED_PROVIDES", "Namespace already provided by deps of {0}.");

  private final JsCheckerState state;
  private final AbstractCompiler compiler;

  JsCheckerFirstPass(JsCheckerState state, AbstractCompiler compiler) {
    this.state = state;
    this.compiler = compiler;
  }

  @Override
  public final void process(Node externs, Node root) {
    NodeTraversal.traverseEs6(compiler, root, this);
  }

  @Override
  public final void hotSwapScript(Node scriptRoot, Node originalRoot) {
    NodeTraversal.traverseEs6(compiler, scriptRoot, this);
  }

  @Override
  public final void visit(NodeTraversal t, Node n, Node parent) {
    switch (n.getType()) {
      case CALL:
        visitFunctionCall(t, n);
        break;
      default:
        break;
    }
  }

  private void visitFunctionCall(NodeTraversal t, Node n) {
    Node callee = n.getFirstChild();
    if (!state.testonly && callee.matchesQualifiedName("goog.setTestOnly")) {
      t.report(n, INVALID_SETTESTONLY, state.label);
      return;
    }
    Node parameter = n.getLastChild();
    if (parameter.isString()
        && (callee.matchesQualifiedName("goog.provide")
            || callee.matchesQualifiedName("goog.module"))) {
      String namespace = JsCheckerHelper.normalizeClosureNamespace(parameter.getString());
      if (!state.provides.add(namespace)) {
        t.report(parameter, DUPLICATE_PROVIDES, state.label);
      }
      if (state.provided.contains(namespace)
          && state.redeclaredProvides.add(namespace)) {
        t.report(parameter, REDECLARED_PROVIDES, state.label);
      }
      state.provides.removeAll(convertPathToModuleName(t.getSourceName(), state.roots).asSet());
    }
  }
}
