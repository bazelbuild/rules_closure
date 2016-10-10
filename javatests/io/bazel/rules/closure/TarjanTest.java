// Copyright 2016 The Closure Rules Authors. All Rights Reserved.
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

package io.bazel.rules.closure;

import static com.google.common.truth.Truth.assertThat;

import com.google.common.collect.ImmutableMultimap;
import com.google.common.collect.ImmutableSet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Unit tests for {@link Tarjan}. */
@RunWith(JUnit4.class)
public class TarjanTest {

  @Test
  public void testEmpty_hasNoCycles() {
    assertThat(Tarjan.findStronglyConnectedComponents(ImmutableMultimap.of())).isEmpty();
  }

  @Test
  public void testDagWithOneEdge_hasNoCycles() {
    assertThat(Tarjan.findStronglyConnectedComponents(ImmutableMultimap.of("A", "B"))).isEmpty();
  }

  @Test
  public void testSelfReferential_returnsVertex() {
    assertThat(Tarjan.findStronglyConnectedComponents(ImmutableMultimap.of("A", "A")))
        .containsExactly(ImmutableSet.of("A"));
  }

  @Test
  public void testTwoVerticesInCycle_returnsSingleSubsetWithBothVertices() {
    assertThat(
            Tarjan.findStronglyConnectedComponents(
                ImmutableMultimap.of(
                    "A", "B",
                    "B", "A")))
        .containsExactly(ImmutableSet.of("A", "B"));
  }

  @Test
  public void testDisjointCycles_returnsDisjointSets() {
    assertThat(
            Tarjan.findStronglyConnectedComponents(
                ImmutableMultimap.of(
                    "C", "D",
                    "D", "C",
                    "A", "B",
                    "B", "A")))
        .containsExactly(ImmutableSet.of("A", "B"), ImmutableSet.of("C", "D"));
  }

  @Test
  public void testWikipediaExample() {
    assertThat(
            Tarjan.findStronglyConnectedComponents(
                new ImmutableMultimap.Builder<String, String>()
                    .put("F", "B")
                    .put("G", "C")
                    .put("H", "D")
                    .put("E", "B")
                    .put("F", "E")
                    .put("F", "G")
                    .put("G", "F")
                    .put("H", "G")
                    .put("H", "H")
                    .put("B", "A")
                    .put("C", "B")
                    .put("D", "C")
                    .put("C", "D")
                    .put("A", "E")
                    .build()))
        .containsExactly(
            ImmutableSet.of("B", "E", "A"),
            ImmutableSet.of("D", "C"),
            ImmutableSet.of("G", "F"),
            ImmutableSet.of("H"))
        .inOrder();
  }
}
