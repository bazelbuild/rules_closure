// Copyright 2019 The Closure Rules Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package test;

import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.multibindings.Multibinder;
import com.google.template.soy.jssrc.restricted.JsExpr;
import com.google.template.soy.jssrc.restricted.SoyJsSrcFunction;
import com.google.template.soy.shared.restricted.SoyFunction;
import java.util.List;
import java.util.Set;

/**
 * An example module providing a custom soy function and js source implementation.
 * See {@link https://github.com/google/closure-templates/blob/master/documentation/dev/plugins.md}
 */
public class ExampleModule extends AbstractModule {
  /** {@inheritDoc} */
  @Override
  protected void configure() {
    bindFunctions(Multibinder.newSetBinder(binder(), SoyFunction.class));
  }

  private void bindFunctions(Multibinder<SoyFunction> fns) {
    fns.addBinding().to(ToLowerFunction.class);
  }

  public static class ToLowerFunction implements SoyJsSrcFunction {
    @Override
    public String getName() {
      return "toLower";
    }

    @Override
    public Set<Integer> getValidArgsSizes() {
      return ImmutableSet.of(1);
    }

    @Override
    public JsExpr computeForJsSrc(List<JsExpr> args) {
      JsExpr arg = args.get(0);
      String exprText = "(" + arg.getText() + ").toLowerCase()";
      return new JsExpr(exprText, Integer.MAX_VALUE);
    }
  }
}
