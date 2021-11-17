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

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Ordering;
import java.util.HashSet;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

final class JsCheckerState {

  final String label;
  final boolean legacy;
  final boolean testonly;
  final ImmutableList<String> roots;
  final ImmutableSet<String> mysterySources;

  // XXX: There are actually cooler data structures we could be using here to save space. Like maybe
  //      a trie represented as an IdentityHashMap. But it'd take too much braining for too little
  //      benefit.

  // Set of namespaces provided by this closure_js_library.
  //
  // This is a binary tree because we're going to need to output its contents in sorted order when
  // this program is done running.
  final SortedSet<String> provides = new TreeSet<>(Ordering.natural());

  // Set of namespaces provided by direct dependencies of this closure_js_library.
  //
  // The initial capacity of 9000 was chosen because nearly all closure_js_library rules will
  // directly depend on @com_google_javascript_closure_library//closure/goog which has 4788
  // provides. This sets a very large lower bound for the size of this hash table. Since HashMap
  // has a default load factor of 0.75, it would need to have a capacity of 6385 (4788/0.75+1) to
  // store those namespaces without redimensioning.
  final Set<String> provided = new HashSet<>(9000);

  // These are used to avoid flooding the user with certain types of error messages.
  final Set<String> notProvidedNamespaces = new HashSet<>();
  final Set<String> redeclaredProvides = new HashSet<>();

  JsCheckerState(
      String label,
      boolean legacy,
      boolean testonly,
      Iterable<String> roots,
      Iterable<String> mysterySources) {
    this.label = label;
    this.legacy = legacy;
    this.testonly = testonly;
    this.roots = ImmutableList.copyOf(roots);
    this.mysterySources = ImmutableSet.copyOf(mysterySources);
  }
}
