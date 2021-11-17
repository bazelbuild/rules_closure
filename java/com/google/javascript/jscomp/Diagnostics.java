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

import com.google.common.collect.HashMultimap;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableMultimap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Multimap;
import com.google.javascript.jscomp.lint.CheckJSDocStyle;
import com.google.javascript.jscomp.lint.CheckMissingSemicolon;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

final class Diagnostics {

  static final DiagnosticType SUPERFLUOUS_SUPPRESS =
      DiagnosticType.error(
          "CR_SUPERFLUOUS_SUPPRESS", "Build rule ({0}) contains superfluous suppress codes: {1}");

  static {
    DiagnosticGroups.registerGroup("superfluousSuppress", SUPERFLUOUS_SUPPRESS);
    DiagnosticGroups.registerGroup("setTestOnly", CheckSetTestOnly.INVALID_SETTESTONLY);
    DiagnosticGroups.registerGroup("strictDependencies",
        CheckStrictDeps.DUPLICATE_PROVIDES,
        CheckStrictDeps.REDECLARED_PROVIDES,
        CheckStrictDeps.NOT_PROVIDED);
  }

  static final DiagnosticGroups GROUPS = new DiagnosticGroups();

  /**
   * Diagnostic groups {@link JsChecker} will check and {@link JsCompiler} will ignore.
   *
   * <p>These are the simpler checks, e.g. linting, that can be examined on a per-file basis.
   */
  static final ImmutableSet<String> JSCHECKER_ONLY_ERRORS =
      ImmutableSet.of(
          "deprecatedAnnotations",
          "lintChecks",
          "nonStandardJsDocs",
          "setTestOnly",
          "strictDependencies",
          "strictModuleChecks",
          "superfluousSuppress",
          "underscore");

  /** Diagnostic groups both {@link JsChecker} and {@link JsCompiler} will check. */
  static final ImmutableSet<String> JSCHECKER_EXTRA_ERRORS =
      ImmutableSet.of(
          // Even though we're not running the typechecker, enable the checkTypes DiagnosticGroup,
          // since it contains some warnings we do want to report, such as JSDoc parse warnings.
          "checkTypes");

  /** Legal values for a {@code @suppress {foo}} JSDoc tag. */
  // Keep in sync with com/google/javascript/jscomp/parsing/ParserConfig.properties
  private static final ImmutableSet<String> LEGAL_JSDOC_SUPPRESSIONS =
      ImmutableSet.of(
          "accessControls",
          "checkDebuggerStatement",
          "checkPrototypalTypes",
          "checkRegExp",
          "checkTypes",
          "checkVars",
          "closureDepMethodUsageChecks",
          "const",
          "constantProperty",
          "deprecated",
          "duplicate",
          "es5Strict",
          "externsValidation",
          "extraProvide",
          "extraRequire",
          "globalThis",
          "invalidCasts",
          "lateProvide",
          "legacyGoogScopeRequire",
          "lintChecks",
          "messageConventions",
          "misplacedTypeAnnotation",
          "missingOverride",
          "missingPolyfill",
          "missingProperties",
          "missingProvide",
          "missingRequire",
          "missingReturn",
          "missingSourcesWarnings",
          "moduleLoad",
          "nonStandardJsDocs",
          "partialAlias",
          "polymer",
          "reportUnknownTypes",
          "strictCheckTypes",
          "strictMissingProperties",
          "strictModuleDepCheck",
          "strictPrimitiveOperators",
          "suspiciousCode",
          "transitionalSuspiciousCodeWarnings",
          "undefinedNames",
          "undefinedVars",
          "underscore",
          "unknownDefines",
          "untranspilableFeatures",
          "unusedLocalVariables",
          "unusedPrivateMembers",
          "useOfGoogProvide",
          "uselessCode",
          "visibility",
          "with");

  /** Checks to suppress if closure_js_library convention is not GOOGLE. */
  static final ImmutableSet<DiagnosticType> GOOGLE_LINTER_CHECKS =
      ImmutableSet.of(
          CheckJSDocStyle.MISSING_JSDOC,
          CheckJSDocStyle.MISSING_PARAMETER_JSDOC,
          CheckJSDocStyle.MISSING_RETURN_JSDOC,
          CheckJSDocStyle.OPTIONAL_PARAM_NOT_MARKED_OPTIONAL,
          CheckMissingSemicolon.MISSING_SEMICOLON);

  /** Checks to suppress if closure_js_library convention is not CLOSURE. */
  static final ImmutableSet<DiagnosticType> CLOSURE_LINTER_CHECKS =
      new ImmutableSet.Builder<DiagnosticType>()
          .addAll(GOOGLE_LINTER_CHECKS)
          .add(ClosureCheckModule.LET_GOOG_REQUIRE)
          .add(ClosureRewriteModule.USELESS_USE_STRICT_DIRECTIVE)
          .add(ImplicitNullabilityCheck.IMPLICITLY_NULLABLE_JSDOC)
          .add(RhinoErrorReporter.BAD_JSDOC_ANNOTATION)
          .build();

  /**
   * Errors that should be ignored entirely if encountered in synthetic code.
   *
   * <p>Code generated by compiler passes currently does a poor job conforming to these checks.
   * They've been listed here because: a) the user can't do anything about it; and b) they would be
   * very noisy otherwise.
   */
  static final ImmutableSet<DiagnosticType> IGNORE_FOR_SYNTHETIC =
      ImmutableSet.of(
          ImplicitNullabilityCheck.IMPLICITLY_NULLABLE_JSDOC,
          TypeCheck.UNKNOWN_EXPR_TYPE);

  static final ImmutableSet<DiagnosticType> IGNORE_FOR_LEGACY =
      ImmutableSet.of(
          ImplicitNullabilityCheck.IMPLICITLY_NULLABLE_JSDOC,
          TypeCheck.UNKNOWN_EXPR_TYPE);

  /** Compiler checks that Closure Rules will always ignore. */
  static final ImmutableSet<DiagnosticType> IGNORE_ALWAYS =
      ImmutableSet.of(
          // TODO(hochhaus): Make unknownDefines an error for user supplied defines.
          // https://github.com/bazelbuild/rules_closure/issues/79
          ProcessDefines.UNKNOWN_DEFINE_WARNING,
          // TODO(jart): Remove these when regression is fixed relating to jscomp being able to
          //             identify externs files that were passed via srcs.
          CheckJSDoc.INVALID_MODIFIES_ANNOTATION,
          CheckJSDoc.INVALID_NO_SIDE_EFFECT_ANNOTATION);

  static final ImmutableMap<String, DiagnosticType> DIAGNOSTIC_TYPES = initDiagnosticTypes();
  static final ImmutableMultimap<DiagnosticType, String> DIAGNOSTIC_GROUPS = initDiagnosticGroups();
  static final ImmutableSet<String> JSCHECKER_ONLY_SUPPRESS_CODES = initJscheckerSuppressCodes();
  static final ImmutableSet<DiagnosticGroup> JSCHECKER_ONLY_GROUPS = initJscheckerGroups();
  static final ImmutableMap<DiagnosticType, String> JSDOC_SUPPRESS_CODES = initJsdocSuppressCodes();

  static ImmutableSet<DiagnosticType> getDiagnosticTypesForSuppressCode(String code) {
    DiagnosticGroup group = GROUPS.forName(code);
    if (group != null) {
      return ImmutableSet.copyOf(group.getTypes());
    }
    DiagnosticType type = DIAGNOSTIC_TYPES.get(code);
    if (type == null) {
      return ImmutableSet.of();
    }
    return ImmutableSet.of(type);
  }

  private static ImmutableMap<String, DiagnosticType> initDiagnosticTypes() {
    Map<String, DiagnosticType> builder = new HashMap<>();
    for (DiagnosticGroup group : DiagnosticGroups.getRegisteredGroups().values()) {
      for (DiagnosticType type : group.getTypes()) {
        builder.put(type.key, type);
      }
    }
    return ImmutableMap.copyOf(builder);
  }

  private static ImmutableMultimap<DiagnosticType, String> initDiagnosticGroups() {
    Multimap<DiagnosticType, String> builder = HashMultimap.create();
    for (Map.Entry<String, DiagnosticGroup> group :
        DiagnosticGroups.getRegisteredGroups().entrySet()) {
      for (DiagnosticType type : group.getValue().getTypes()) {
        builder.put(type, group.getKey());
      }
    }
    return ImmutableMultimap.copyOf(builder);
  }

  private static ImmutableSet<String> initJscheckerSuppressCodes() {
    Set<String> builder = new HashSet<>();
    for (String groupName : JSCHECKER_ONLY_ERRORS) {
      builder.add(groupName);
      for (DiagnosticType type : GROUPS.forName(groupName).getTypes()) {
        builder.add(type.key);
      }
    }
    return ImmutableSet.copyOf(builder);
  }

  private static ImmutableSet<DiagnosticGroup> initJscheckerGroups() {
    ImmutableSet.Builder<DiagnosticGroup> builder = new ImmutableSet.Builder<>();
    for (String groupName : JSCHECKER_ONLY_ERRORS) {
      builder.add(GROUPS.forName(groupName));
    }
    return builder.build();
  }

  private static ImmutableMap<DiagnosticType, String> initJsdocSuppressCodes() {
    Map<DiagnosticType, String> builder = new HashMap<>();
    builder.put(StrictModeCheck.USE_OF_WITH, "with");
    for (String suppress : LEGAL_JSDOC_SUPPRESSIONS) {
      if (GROUPS.forName(suppress) == null) {
        continue;
      }
      for (DiagnosticType type : GROUPS.forName(suppress).getTypes()) {
        builder.put(type, suppress);
      }
    }
    return ImmutableMap.copyOf(builder);
  }

  private Diagnostics() {}
}
