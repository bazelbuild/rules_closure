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

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Multimap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Graph cycle detector. */
public final class Tarjan {

  /**
   * Returns set of all strongly connected components in a directed graph defined by {@code edges}.
   *
   * <p>A "strongly connected component" is a subset of vertices within a graph, where every vertex
   * is reachable from every other vertex. It's a cluster of cycles basically.
   *
   * <h3>Implementation Notes</h3>
   *
   * <p>This method implements a modified version of <a href="https://goo.gl/HicWRD">Tarjan's
   * strongly connected components algorithm</a> which is O(|V| + |E|).
   *
   * @param <V> vertex type, which should have a fast {@code hashCode()} method
   * @return strongly connected components topologically ordered or empty set if graph is acyclic
   */
  public static <V> ImmutableSet<ImmutableSet<V>> findStronglyConnectedComponents(
      Multimap<V, V> edges) {
    return new Finder<>(edges).getComponents();
  }

  private static final class Vertex<V> {
    final V vertex;
    final int index;
    int lowlink;
    boolean onStack;
    boolean selfReferential;

    Vertex(V vertex, int index) {
      this.vertex = vertex;
      this.index = index;
      this.lowlink = index;
    }
  }

  private static final class Finder<V> {
    private final ImmutableSet.Builder<ImmutableSet<V>> result = new ImmutableSet.Builder<>();
    private final Multimap<V, V> edges;
    private final Map<V, Vertex<V>> vertices;
    private final List<Vertex<V>> stack;
    private int index;

    Finder(Multimap<V, V> edges) {
      this.edges = edges;
      this.stack = new ArrayList<>(edges.size());
      this.vertices = new HashMap<>(edges.size() * 2);
    }

    ImmutableSet<ImmutableSet<V>> getComponents() {
      for (V vertex : edges.keySet()) {
        Vertex<V> v = vertices.get(vertex);
        if (v == null) {
          connectStrongly(vertex);
        }
      }
      return result.build();
    }

    private Vertex<V> connectStrongly(V vertex) {
      // Set the depth index for v to the smallest unused index
      Vertex<V> v = new Vertex<>(vertex, index++);
      vertices.put(vertex, v);
      stack.add(v);
      v.onStack = true;

      // Consider successors of v.
      for (V vertex2 : edges.get(v.vertex)) {
        Vertex<V> w = vertices.get(vertex2);
        if (w == null) {
          // Successor w has not yet been visited; recurse on it.
          w = connectStrongly(vertex2);
          v.lowlink = Math.min(v.lowlink, w.lowlink);
        } else if (w.onStack) {
          // Successor w is in stack and hence in the current SCC.
          v.lowlink = Math.min(v.lowlink, w.index);
        }
        if (w.equals(v)) {
          w.selfReferential = true;
        }
      }

      // If v is a root node, pop the stack and generate an SCC
      if (v.lowlink == v.index) {
        if (!v.selfReferential && v.equals(stack.get(stack.size() - 1))) {
          stack.remove(stack.size() - 1);
          v.onStack = false;
        } else {
          ImmutableSet.Builder<V> scc = new ImmutableSet.Builder<>();
          Vertex<V> w;
          do {
            w = stack.remove(stack.size() - 1);
            w.onStack = false;
            scc.add(w.vertex);
          } while (!w.equals(v));
          result.add(scc.build());
        }
      }

      return v;
    }
  }
}
