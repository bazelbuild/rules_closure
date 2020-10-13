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

package io.bazel.rules.closure.worker.testing;

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.truth.Fact.simpleFact;

import com.google.auto.value.AutoValue;
import com.google.common.truth.FailureMetadata;
import com.google.common.truth.Subject;
import com.google.common.truth.Truth;
import java.util.Arrays;
import java.util.Set;

/** Result of program invocation. */
@AutoValue
public abstract class ProgramResult {

  /** Returns set of error messages emitted by program, without any formatting. */
  public abstract Set<String> errors();

  /** Returns set of warning messages emitted by program, without any formatting. */
  public abstract Set<String> warnings();

  /** Returns {@code true} if program invocation failed. */
  public abstract boolean failed();

  /** Begins a Truth assertion about a program invocation result. */
  public static ResultChain assertThat(ProgramResult result) {
    return Truth.assertAbout(SUBJECT_FACTORY).that(result);
  }

  /** Fluent interface for warning testing. */
  public interface ResultChain {

    /** Assert that program failed. */
    FailedChain failed();

    /** Assert that program succeeeded. */
    WarningsChain succeeded();
  }

  /** Fluent interface for warning testing. */
  public interface WarningsChain {

    /** Assert that no warnings were emitted either. */
    void withoutWarnings();

    /** Assert that the following exact warning strings were emmitted, in order. */
    void withWarnings(String... warnings);
  }

  /** Fluent interface for failed invocation testing. */
  public interface FailedChain {

    /** Assert that the following exact error strings were emmitted, in order. */
    WarningsChain withErrors(String... warnings);
  }

  private static final class ProgramResultSubject extends Subject
      implements ResultChain, WarningsChain, FailedChain {

    private final ProgramResult actual;

    private ProgramResultSubject(FailureMetadata failureMetadata, ProgramResult subject) {
      super(failureMetadata, subject);
      this.actual = subject;
    }

    @Override
    public FailedChain failed() {
      if (actual.failed()) {
        failWithActual(simpleFact("expected to be a failure"));
      }
      return this;
    }

    @Override
    public WarningsChain succeeded() {
      if (actual.failed() || !actual.errors().isEmpty()) {
        failWithActual(simpleFact("expected to be a successful web action invocation"));
      }
      return this;
    }

    @Override
    public WarningsChain withErrors(String... warnings) {
      checkArgument(warnings.length > 0);
      check("warnings()")
          .that(actual.warnings())
          .containsExactlyElementsIn(warnings)
          .inOrder();
      return this;
    }

    @Override
    public void withoutWarnings() {
      check("warnings()").that(actual.warnings()).isEmpty();
    }

    @Override
    public void withWarnings(String... warnings) {
      checkArgument(warnings.length > 0);
      check("warnings()")
          .that(actual.warnings())
          .containsExactlyElementsIn(warnings)
          .inOrder();
    }
  }

  private static final Subject.Factory<ProgramResultSubject, ProgramResult> SUBJECT_FACTORY =
      ProgramResultSubject::new;

  ProgramResult() {}
}
