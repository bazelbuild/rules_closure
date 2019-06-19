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

package io.bazel.rules.closure;

import static org.junit.Assume.assumeTrue;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Iterators;
import com.google.common.collect.Lists;
import com.google.common.collect.Ordering;
import com.google.common.collect.testing.Helpers;
import com.google.common.jimfs.Configuration;
import com.google.common.jimfs.Jimfs;
import com.google.common.testing.EqualsTester;
import com.google.common.testing.NullPointerTester;
import com.google.common.truth.BooleanSubject;
import com.google.common.truth.IterableSubject;
import com.google.common.truth.Subject;
import com.google.common.truth.Truth;
import java.nio.file.FileSystem;
import java.nio.file.Path;
import java.util.List;
import org.junit.After;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Unit tests for {@link Webpath}. */
@RunWith(JUnit4.class)
public class WebpathTest {

  @Rule public final ExpectedException thrown = ExpectedException.none();

  public final FileSystem unix = Jimfs.newFileSystem(Configuration.unix());

  @After
  public void after() throws Exception {
    unix.close();
  }

  private static Webpath wp(String path) {
    return Webpath.get(path);
  }

  private Path xp(String path) {
    return unix.getPath(path);
  }

  // Workaround fact that Path interface matches multiple assertThat() method overloads.
  private static Subject assertThat(Object subject) {
    return Truth.assertThat(subject);
  }

  private static BooleanSubject assertThat(boolean subject) {
    return Truth.assertThat(subject);
  }

  private static <T> IterableSubject assertThat(ImmutableList<T> subject) {
    return Truth.assertThat(subject);
  }

  @Test
  public void testNormalize_relativeDot_remainsDot() {
    assertThat(xp(".").normalize()).isEqualTo(xp("."));
    assertThat(wp(".").normalize()).isEqualTo(wp("."));
  }

  @Test
  public void testNormalize_relativeDot_eliminatesItselfForSomeStrangeReason() {
    assertThat(xp("./.").normalize()).isEqualTo(xp(""));
    assertThat(wp("./.").normalize()).isEqualTo(wp(""));
  }

  @Test
  public void testNormalize_root_remainsRoot() {
    assertThat(xp("/").normalize()).isEqualTo(xp("/"));
    assertThat(wp("/").normalize()).isEqualTo(wp("/"));
  }

  @Test
  public void testNormalize_rootDot_becomesRoot() {
    assertThat(xp("/.").normalize()).isEqualTo(xp("/"));
    assertThat(wp("/.").normalize()).isEqualTo(wp("/"));
  }

  @Test
  public void testNormalize_parentOfRoot_isRoot() {
    assertThat(xp("/..").normalize()).isEqualTo(xp("/"));
    assertThat(wp("/..").normalize()).isEqualTo(wp("/"));
    assertThat(xp("/../..").normalize()).isEqualTo(xp("/"));
    assertThat(wp("/../..").normalize()).isEqualTo(wp("/"));
    assertThat(xp("/hi/../..").normalize()).isEqualTo(xp("/"));
    assertThat(wp("/hi/../..").normalize()).isEqualTo(wp("/"));
  }

  @Test
  public void testNormalize_relativeDoubleDot_remainsDoubleDot() {
    assertThat(xp("..").normalize()).isEqualTo(xp(".."));
    assertThat(wp("..").normalize()).isEqualTo(wp(".."));
    assertThat(xp("../..").normalize()).isEqualTo(xp("../.."));
    assertThat(wp("../..").normalize()).isEqualTo(wp("../.."));
    assertThat(xp(".././..").normalize()).isEqualTo(xp("../.."));
    assertThat(wp(".././..").normalize()).isEqualTo(wp("../.."));
    assertThat(xp("hi/../..").normalize()).isEqualTo(xp(".."));
    assertThat(wp("hi/../..").normalize()).isEqualTo(wp(".."));
    assertThat(xp("../").normalize()).isEqualTo(xp("../"));
    assertThat(wp("../").normalize()).isEqualTo(wp("../"));
  }

  @Test
  public void testNormalize_doubleDot_trumpsSingleDot() {
    assertThat(xp("././..").normalize()).isEqualTo(xp(".."));
    assertThat(wp("././..").normalize()).isEqualTo(wp(".."));
  }

  @Test
  public void testNormalize_midPath_isConsistentWithUnix() {
    assertThat(xp("/a/b/../c").normalize()).isEqualTo(xp("/a/c"));
    assertThat(wp("/a/b/../c").normalize()).isEqualTo(wp("/a/c"));
    assertThat(xp("/a/b/./c").normalize()).isEqualTo(xp("/a/b/c"));
    assertThat(wp("/a/b/./c").normalize()).isEqualTo(wp("/a/b/c"));
    assertThat(xp("a/b/../c").normalize()).isEqualTo(xp("a/c"));
    assertThat(wp("a/b/../c").normalize()).isEqualTo(wp("a/c"));
    assertThat(xp("a/b/./c").normalize()).isEqualTo(xp("a/b/c"));
    assertThat(wp("a/b/./c").normalize()).isEqualTo(wp("a/b/c"));
    assertThat(xp("/a/b/../../c").normalize()).isEqualTo(xp("/c"));
    assertThat(wp("/a/b/../../c").normalize()).isEqualTo(wp("/c"));
    assertThat(xp("/a/b/./.././.././c").normalize()).isEqualTo(xp("/c"));
    assertThat(wp("/a/b/./.././.././c").normalize()).isEqualTo(wp("/c"));
  }

  @Test
  public void testNormalize_parentDir_preservesTrailingSlashOnGuaranteedDirectories() {
    assertThat(xp("hi/there/..").normalize()).isEqualTo(xp("hi/"));
    assertThat(wp("hi/there/..").normalize()).isEqualTo(wp("hi/"));
    assertThat(xp("hi/there/../").normalize()).isEqualTo(xp("hi/"));
    assertThat(wp("hi/there/../").normalize()).isEqualTo(wp("hi/"));
  }

  @Test
  public void testNormalize_empty_returnsEmpty() {
    assertThat(xp("").normalize()).isEqualTo(xp(""));
    assertThat(wp("").normalize()).isEqualTo(wp(""));
  }

  @Test
  public void testNormalize_extraSlashes_getRemoved() {
    assertThat(xp("///").normalize()).isEqualTo(xp("/"));
    assertThat(wp("///").normalize()).isEqualTo(wp("/"));
    assertThat(xp("/hi//there").normalize()).isEqualTo(xp("/hi/there"));
    assertThat(wp("/hi//there").normalize()).isEqualTo(wp("/hi/there"));
    assertThat(xp("/hi////.///there").normalize()).isEqualTo(xp("/hi/there"));
    assertThat(wp("/hi////.///there").normalize()).isEqualTo(wp("/hi/there"));
  }

  @Test
  public void testNormalize_preservesTrailingSlash() {
    assertThat(xp("/hi/").normalize()).isEqualTo(xp("/hi/"));
    assertThat(wp("/hi/").normalize()).isEqualTo(wp("/hi/"));
    assertThat(xp("/hi///").normalize()).isEqualTo(xp("/hi/"));
    assertThat(wp("/hi///").normalize()).isEqualTo(wp("/hi/"));
  }

  @Test
  public void testNormalize_outputIsEqual_newObjectIsntCreated() {
    Webpath path = wp("/hi/there");
    assertThat(path.normalize()).isSameInstanceAs(path);
    path = wp("/hi/there/");
    assertThat(path.normalize()).isSameInstanceAs(path);
    path = wp("../");
    assertThat(path.normalize()).isSameInstanceAs(path);
    path = wp("../..");
    assertThat(path.normalize()).isSameInstanceAs(path);
    path = wp("./");
    assertThat(path.normalize()).isSameInstanceAs(path);
  }

  @Test
  public void testResolve() {
    assertThat(xp("").resolve(xp("cat"))).isEqualTo(xp("cat"));
    assertThat(wp("").resolve(wp("cat"))).isEqualTo(wp("cat"));
    assertThat(xp("/hello").resolve(xp("cat"))).isEqualTo(xp("/hello/cat"));
    assertThat(wp("/hello").resolve(wp("cat"))).isEqualTo(wp("/hello/cat"));
    assertThat(xp("/hello/").resolve(xp("cat"))).isEqualTo(xp("/hello/cat"));
    assertThat(wp("/hello/").resolve(wp("cat"))).isEqualTo(wp("/hello/cat"));
    assertThat(xp("hello/").resolve(xp("cat"))).isEqualTo(xp("hello/cat"));
    assertThat(wp("hello/").resolve(wp("cat"))).isEqualTo(wp("hello/cat"));
    assertThat(xp("hello/").resolve(xp("cat/"))).isEqualTo(xp("hello/cat/"));
    assertThat(wp("hello/").resolve(wp("cat/"))).isEqualTo(wp("hello/cat/"));
    assertThat(xp("hello/").resolve(xp(""))).isEqualTo(xp("hello/"));
    assertThat(wp("hello/").resolve(wp(""))).isEqualTo(wp("hello/"));
    assertThat(xp("hello/").resolve(xp("/hi/there"))).isEqualTo(xp("/hi/there"));
    assertThat(wp("hello/").resolve(wp("/hi/there"))).isEqualTo(wp("/hi/there"));
  }

  @Test
  public void testResolve_sameObjectOptimization() {
    Webpath path = wp("/hi/there");
    assertThat(path.resolve(wp(""))).isSameInstanceAs(path);
    assertThat(wp("hello").resolve(path)).isSameInstanceAs(path);
  }

  @Test
  public void testResolveSibling() {
    assertThat(xp("/hello/cat").resolveSibling(xp("dog"))).isEqualTo(xp("/hello/dog"));
    assertThat(wp("/hello/cat").resolveSibling(wp("dog"))).isEqualTo(wp("/hello/dog"));
    assertThat(xp("/").resolveSibling(xp("dog"))).isEqualTo(xp("dog"));
    assertThat(wp("/").resolveSibling(wp("dog"))).isEqualTo(wp("dog"));
  }

  @Test
  public void testRelativize() {
    assertThat(wp("/foo/bar/hop/dog").relativize(wp("/foo/mop/top")))
        .isEqualTo(wp("../../../mop/top"));
    assertThat(wp("/foo/bar/dog").relativize(wp("/foo/mop/top"))).isEqualTo(wp("../../mop/top"));
    assertThat(wp("/foo/bar/hop/dog").relativize(wp("/foo/mop/top/../../mog")))
        .isEqualTo(wp("../../../mop/top/../../mog"));
    assertThat(wp("/foo/bar/hop/dog").relativize(wp("/foo/../mog")))
        .isEqualTo(wp("../../../../mog"));
    assertThat(wp("").relativize(wp("foo/mop/top/"))).isEqualTo(wp("foo/mop/top/"));
  }

  @Test
  public void testRelativize_absoluteMismatch_notAllowed() {
    thrown.expect(IllegalArgumentException.class);
    wp("/a/b/").relativize(wp(""));
  }

  @Test
  public void testRelativize_preservesTrailingSlash() {
    // This behavior actually diverges from sun.nio.fs.UnixPath:
    //   bsh % print(Paths.get("/a/b/").relativize(Paths.get("/etc/")));
    //   ../../etc
    assertThat(wp("/foo/bar/hop/dog").relativize(wp("/foo/../mog/")))
        .isEqualTo(wp("../../../../mog/"));
    assertThat(wp("/a/b/").relativize(wp("/etc/"))).isEqualTo(wp("../../etc/"));
  }

  @Test
  public void testStartsWith() {
    assertThat(xp("/hi/there").startsWith(xp("/hi/there"))).isTrue();
    assertThat(wp("/hi/there").startsWith(wp("/hi/there"))).isTrue();
    assertThat(xp("/hi/there").startsWith(xp("/hi/therf"))).isFalse();
    assertThat(wp("/hi/there").startsWith(wp("/hi/therf"))).isFalse();
    assertThat(xp("/hi/there").startsWith(xp("/hi"))).isTrue();
    assertThat(wp("/hi/there").startsWith(wp("/hi"))).isTrue();
    assertThat(xp("/hi/there").startsWith(xp("/hi/"))).isTrue();
    assertThat(wp("/hi/there").startsWith(wp("/hi/"))).isTrue();
    assertThat(xp("/hi/there").startsWith(xp("hi"))).isFalse();
    assertThat(wp("/hi/there").startsWith(wp("hi"))).isFalse();
    assertThat(xp("/hi/there").startsWith(xp("/"))).isTrue();
    assertThat(wp("/hi/there").startsWith(wp("/"))).isTrue();
    assertThat(xp("/hi/there").startsWith(xp(""))).isFalse();
    assertThat(wp("/hi/there").startsWith(wp(""))).isFalse();
    assertThat(xp("/a/b").startsWith(xp("a/b/"))).isFalse();
    assertThat(wp("/a/b").startsWith(wp("a/b/"))).isFalse();
    assertThat(xp("/a/b/").startsWith(xp("a/b/"))).isFalse();
    assertThat(wp("/a/b/").startsWith(wp("a/b/"))).isFalse();
    assertThat(xp("/hi/there").startsWith(xp(""))).isFalse();
    assertThat(wp("/hi/there").startsWith(wp(""))).isFalse();
    assertThat(xp("").startsWith(xp(""))).isTrue();
    assertThat(wp("").startsWith(wp(""))).isTrue();
  }

  @Test
  public void testStartsWith_comparesComponentsIndividually() {
    assertThat(xp("/hello").startsWith(xp("/hell"))).isFalse();
    assertThat(wp("/hello").startsWith(wp("/hell"))).isFalse();
    assertThat(xp("/hello").startsWith(xp("/hello"))).isTrue();
    assertThat(wp("/hello").startsWith(wp("/hello"))).isTrue();
  }

  @Test
  public void testEndsWith() {
    assertThat(xp("/hi/there").endsWith(xp("there"))).isTrue();
    assertThat(wp("/hi/there").endsWith(wp("there"))).isTrue();
    assertThat(xp("/hi/there").endsWith(xp("therf"))).isFalse();
    assertThat(wp("/hi/there").endsWith(wp("therf"))).isFalse();
    assertThat(xp("/hi/there").endsWith(xp("/blag/therf"))).isFalse();
    assertThat(wp("/hi/there").endsWith(wp("/blag/therf"))).isFalse();
    assertThat(xp("/hi/there").endsWith(xp("/hi/there"))).isTrue();
    assertThat(wp("/hi/there").endsWith(wp("/hi/there"))).isTrue();
    assertThat(xp("/hi/there").endsWith(xp("/there"))).isFalse();
    assertThat(wp("/hi/there").endsWith(wp("/there"))).isFalse();
    assertThat(xp("/human/that/you/cry").endsWith(xp("that/you/cry"))).isTrue();
    assertThat(wp("/human/that/you/cry").endsWith(wp("that/you/cry"))).isTrue();
    assertThat(xp("/human/that/you/cry").endsWith(xp("that/you/cry/"))).isTrue();
    assertThat(wp("/human/that/you/cry").endsWith(wp("that/you/cry/"))).isTrue();
    assertThat(xp("/hi/there/").endsWith(xp("/"))).isFalse();
    assertThat(wp("/hi/there/").endsWith(wp("/"))).isFalse();
    assertThat(xp("/hi/there").endsWith(xp(""))).isFalse();
    assertThat(wp("/hi/there").endsWith(wp(""))).isFalse();
    assertThat(xp("").endsWith(xp(""))).isTrue();
    assertThat(wp("").endsWith(wp(""))).isTrue();
  }

  @Test
  public void testEndsWith_comparesComponentsIndividually() {
    assertThat(xp("/hello").endsWith(xp("lo"))).isFalse();
    assertThat(wp("/hello").endsWith(wp("lo"))).isFalse();
    assertThat(xp("/hello").endsWith(xp("hello"))).isTrue();
    assertThat(wp("/hello").endsWith(wp("hello"))).isTrue();
  }

  @Test
  public void testGetParent() {
    assertThat(xp("").getParent()).isNull();
    assertThat(wp("").getParent()).isNull();
    assertThat(xp("/").getParent()).isNull();
    assertThat(wp("/").getParent()).isNull();
    assertThat(xp("aaa/").getParent()).isNull();
    assertThat(wp("aaa/").getParent()).isNull();
    assertThat(xp("aaa").getParent()).isNull();
    assertThat(wp("aaa").getParent()).isNull();
    assertThat(xp("/aaa/").getParent()).isEqualTo(xp("/"));
    assertThat(wp("/aaa/").getParent()).isEqualTo(wp("/"));
    assertThat(xp("a/b/c").getParent()).isEqualTo(xp("a/b/"));
    assertThat(wp("a/b/c").getParent()).isEqualTo(wp("a/b/"));
    assertThat(xp("a/b/c/").getParent()).isEqualTo(xp("a/b/"));
    assertThat(wp("a/b/c/").getParent()).isEqualTo(wp("a/b/"));
    assertThat(xp("a/b/").getParent()).isEqualTo(xp("a/"));
    assertThat(wp("a/b/").getParent()).isEqualTo(wp("a/"));
  }

  @Test
  public void testGetRoot() {
    assertThat(xp("/hello").getRoot()).isEqualTo(xp("/"));
    assertThat(wp("/hello").getRoot()).isEqualTo(wp("/"));
    assertThat(xp("hello").getRoot()).isNull();
    assertThat(wp("hello").getRoot()).isNull();
    assertThat(xp("/hello/friend").getRoot()).isEqualTo(xp("/"));
    assertThat(wp("/hello/friend").getRoot()).isEqualTo(wp("/"));
    assertThat(xp("hello/friend").getRoot()).isNull();
    assertThat(wp("hello/friend").getRoot()).isNull();
  }

  @Test
  public void testGetFileName() {
    assertThat(xp("").getFileName()).isEqualTo(xp(""));
    assertThat(wp("").getFileName()).isEqualTo(wp(""));
    assertThat(xp("/").getFileName()).isNull();
    assertThat(wp("/").getFileName()).isNull();
    assertThat(xp("/dark").getFileName()).isEqualTo(xp("dark"));
    assertThat(wp("/dark").getFileName()).isEqualTo(wp("dark"));
    assertThat(xp("/angels/").getFileName()).isEqualTo(xp("angels"));
    assertThat(wp("/angels/").getFileName()).isEqualTo(wp("angels"));
  }

  @Test
  public void testEquals() {
    assertThat(xp("/a/").equals(xp("/a/"))).isTrue();
    assertThat(wp("/a/").equals(wp("/a/"))).isTrue();
    assertThat(xp("/a/").equals(xp("/b/"))).isFalse();
    assertThat(wp("/a/").equals(wp("/b/"))).isFalse();
    assertThat(xp("b").equals(xp("/b"))).isFalse();
    assertThat(wp("b").equals(wp("/b"))).isFalse();
    assertThat(xp("b").equals(xp("b"))).isTrue();
    assertThat(wp("b").equals(wp("b"))).isTrue();
  }

  @Test
  public void testEquals_trailingSlash_isConsideredADifferentFile() {
    assertThat(xp("/b/").equals(xp("/b"))).isTrue();
    assertThat(wp("/b/").equals(wp("/b"))).isFalse(); // different behavior!
    assertThat(xp("/b").equals(xp("/b/"))).isTrue();
    assertThat(wp("/b").equals(wp("/b/"))).isFalse(); // different behavior!
  }

  @Test
  public void testEquals_redundantComponents_doesNotNormalize() {
    assertThat(xp("/.").equals(xp("/"))).isFalse();
    assertThat(wp("/.").equals(wp("/"))).isFalse();
    assertThat(xp("/..").equals(xp("/"))).isFalse();
    assertThat(wp("/..").equals(wp("/"))).isFalse();
    assertThat(xp("a/").equals(xp("a/."))).isFalse();
    assertThat(wp("a/").equals(wp("a/."))).isFalse();
  }

  @Test
  public void testSplit() {
    assertThat(wp("").split().hasNext()).isFalse();
    assertThat(wp("hi/there").split().hasNext()).isTrue();
    assertThat(wp(wp("hi/there").split().next())).isEqualTo(wp("hi"));
    assertThat(ImmutableList.copyOf(Iterators.toArray(wp("hi/there").split(), String.class)))
        .containsExactly("hi", "there")
        .inOrder();
  }

  @Test
  public void testToAbsolute() {
    assertThat(wp("lol").toAbsolutePath(wp("/"))).isEqualTo(wp("/lol"));
    assertThat(wp("lol/cat").toAbsolutePath(wp("/"))).isEqualTo(wp("/lol/cat"));
  }

  @Test
  public void testToAbsolute_withCurrentDirectory() {
    assertThat(wp("cat").toAbsolutePath(wp("/lol"))).isEqualTo(wp("/lol/cat"));
    assertThat(wp("cat").toAbsolutePath(wp("/lol/"))).isEqualTo(wp("/lol/cat"));
    assertThat(wp("/hi/there").toAbsolutePath(wp("/lol"))).isEqualTo(wp("/hi/there"));
  }

  @Test
  public void testToAbsolute_preservesTrailingSlash() {
    assertThat(wp("cat/").toAbsolutePath(wp("/lol"))).isEqualTo(wp("/lol/cat/"));
  }

  @Test
  public void testSubpath() {
    assertThat(xp("/eins/zwei/drei/vier").subpath(0, 1)).isEqualTo(xp("eins"));
    assertThat(wp("/eins/zwei/drei/vier").subpath(0, 1)).isEqualTo(wp("eins"));
    assertThat(xp("/eins/zwei/drei/vier").subpath(0, 2)).isEqualTo(xp("eins/zwei"));
    assertThat(wp("/eins/zwei/drei/vier").subpath(0, 2)).isEqualTo(wp("eins/zwei"));
    assertThat(xp("eins/zwei/drei/vier/").subpath(1, 4)).isEqualTo(xp("zwei/drei/vier"));
    assertThat(wp("eins/zwei/drei/vier/").subpath(1, 4)).isEqualTo(wp("zwei/drei/vier"));
    assertThat(xp("eins/zwei/drei/vier/").subpath(2, 4)).isEqualTo(xp("drei/vier"));
    assertThat(wp("eins/zwei/drei/vier/").subpath(2, 4)).isEqualTo(wp("drei/vier"));
  }

  @Test
  public void testSubpath_empty_returnsEmpty() {
    assertThat(xp("").subpath(0, 1)).isEqualTo(xp(""));
    assertThat(wp("").subpath(0, 1)).isEqualTo(wp(""));
  }

  @Test
  public void testSubpath_root_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/").subpath(0, 1);
  }

  @Test
  public void testSubpath_negativeIndex_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/eins/zwei/drei/vier").subpath(-1, 1);
  }

  @Test
  public void testSubpath_notEnoughElements_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/eins/zwei/drei/vier").subpath(0, 5);
  }

  @Test
  public void testSubpath_beginAboveEnd_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/eins/zwei/drei/vier").subpath(1, 0);
  }

  @Test
  public void testSubpath_beginAndEndEqual_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/eins/zwei/drei/vier").subpath(0, 0);
  }

  @Test
  public void testNameCount() {
    assertThat(xp("").getNameCount()).isEqualTo(1);
    assertThat(wp("").getNameCount()).isEqualTo(1);
    assertThat(xp("/").getNameCount()).isEqualTo(0);
    assertThat(wp("/").getNameCount()).isEqualTo(0);
    assertThat(xp("/hi/").getNameCount()).isEqualTo(1);
    assertThat(wp("/hi/").getNameCount()).isEqualTo(1);
    assertThat(xp("/hi/yo").getNameCount()).isEqualTo(2);
    assertThat(wp("/hi/yo").getNameCount()).isEqualTo(2);
    assertThat(xp("hi/yo").getNameCount()).isEqualTo(2);
    assertThat(wp("hi/yo").getNameCount()).isEqualTo(2);
  }

  @Test
  public void testNameCount_dontPermitEmptyComponents_emptiesGetIgnored() {
    assertThat(xp("hi//yo").getNameCount()).isEqualTo(2);
    assertThat(wp("hi//yo").getNameCount()).isEqualTo(2);
    assertThat(xp("//hi//yo//").getNameCount()).isEqualTo(2);
    assertThat(wp("//hi//yo//").getNameCount()).isEqualTo(2);
  }

  @Test
  public void testGetName() {
    assertThat(xp("").getName(0)).isEqualTo(xp(""));
    assertThat(wp("").getName(0)).isEqualTo(wp(""));
    assertThat(xp("/hi").getName(0)).isEqualTo(xp("hi"));
    assertThat(wp("/hi").getName(0)).isEqualTo(wp("hi"));
    assertThat(xp("hi/there").getName(1)).isEqualTo(xp("there"));
    assertThat(wp("hi/there").getName(1)).isEqualTo(wp("there"));
  }

  @Test
  public void testGetName_outOfBoundsOnEmpty_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("").getName(1);
  }

  @Test
  public void testGetName_outOfBoundsGreater_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("a").getName(1);
  }

  @Test
  public void testGetName_outOfBoundsLesser_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("a").getName(-1);
  }

  @Test
  public void testGetName_outOfBoundsOnRoot_throwsIae() {
    thrown.expect(IllegalArgumentException.class);
    wp("/").getName(0);
  }

  @Test
  public void testCompareTo() {
    assertThat(xp("/hi/there").compareTo(xp("/hi/there"))).isEqualTo(0);
    assertThat(wp("/hi/there").compareTo(wp("/hi/there"))).isEqualTo(0);
    assertThat(xp("/hi/there").compareTo(xp("/hi/therf"))).isEqualTo(-1);
    assertThat(wp("/hi/there").compareTo(wp("/hi/therf"))).isEqualTo(-1);
    assertThat(xp("/hi/there").compareTo(xp("/hi/therd"))).isEqualTo(1);
    assertThat(wp("/hi/there").compareTo(wp("/hi/therd"))).isEqualTo(1);
  }

  @Test
  public void testCompareTo_emptiesGetIgnored() {
    assertThat(xp("a/b").compareTo(xp("a//b"))).isEqualTo(0);
    assertThat(wp("a/b").compareTo(wp("a//b"))).isEqualTo(0);
  }

  @Test
  public void testCompareTo_isConsistentWithEquals() {
    Helpers.testCompareToAndEquals(
        ImmutableList.of(
            wp(""),
            wp("0"),
            wp("a"),
            wp("a/"),
            wp("a/b"),
            wp("b"),
            wp("/"),
            wp("//a"),
            wp("/a/"),
            wp("/a/a"),
            wp("/a//b"),
            wp("/a/c"),
            wp("/b")));
  }

  @Test
  @SuppressWarnings("ComplexBooleanConstant") // suppression needed for assume statements
  public void testCompareTo_comparesComponentsIndividually() {
    assumeTrue('.' < '/');
    assertThat("hi./there".compareTo("hi/there")).isEqualTo(-1); // demonstration
    assertThat("hi.".compareTo("hi")).isEqualTo(1); // demonstration
    assertThat(wp("hi./there").compareTo(wp("hi/there"))).isEqualTo(1);
    assertThat(wp("hi./there").compareTo(wp("hi/there"))).isEqualTo(1);
    assumeTrue('0' > '/');
    assertThat("hi0/there".compareTo("hi/there")).isEqualTo(1); // demonstration
    assertThat("hi0".compareTo("hi")).isEqualTo(1); // demonstration
    assertThat(wp("hi0/there").compareTo(wp("hi/there"))).isEqualTo(1);
  }

  @Test
  public void testSorting_shorterPathsFirst() {
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("/a/b"), wp("/a"))))
        .containsExactly(wp("/a"), wp("/a/b"))
        .inOrder();
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("/a"), wp("/a/b"))))
        .containsExactly(wp("/a"), wp("/a/b"))
        .inOrder();
  }

  @Test
  public void testSorting_relativePathsFirst() {
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("/a/b"), wp("a"))))
        .containsExactly(wp("a"), wp("/a/b"))
        .inOrder();
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("a"), wp("/a/b"))))
        .containsExactly(wp("a"), wp("/a/b"))
        .inOrder();
  }

  @Test
  public void testSorting_trailingSlashLast() {
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("/a/"), wp("/a"))))
        .containsExactly(wp("/a"), wp("/a/"))
        .inOrder();
    assertThat(Ordering.natural().immutableSortedCopy(ImmutableList.of(wp("/a"), wp("/a/"))))
        .containsExactly(wp("/a"), wp("/a/"))
        .inOrder();
  }

  @Test
  public void testSeemsLikeADirectory() {
    assertThat(wp("a").seemsLikeADirectory()).isFalse();
    assertThat(wp("a.").seemsLikeADirectory()).isFalse();
    assertThat(wp("a..").seemsLikeADirectory()).isFalse();
    assertThat(wp("/a").seemsLikeADirectory()).isFalse();
    assertThat(wp("").seemsLikeADirectory()).isTrue();
    assertThat(wp("/").seemsLikeADirectory()).isTrue();
    assertThat(wp(".").seemsLikeADirectory()).isTrue();
    assertThat(wp("/.").seemsLikeADirectory()).isTrue();
    assertThat(wp("..").seemsLikeADirectory()).isTrue();
    assertThat(wp("/..").seemsLikeADirectory()).isTrue();
  }

  @Test
  public void testEquals_withEqualsTester() {
    new EqualsTester()
        .addEqualityGroup(wp(""))
        .addEqualityGroup(wp("/"), wp("//"), wp("///"))
        .addEqualityGroup(wp("lol"))
        .addEqualityGroup(wp("/lol"))
        .addEqualityGroup(wp("/lol//"), wp("/lol//"), wp("//lol//"), wp("//lol///"))
        .addEqualityGroup(wp("a/b"), wp("a//b"))
        .testEquals();
  }

  @Test
  public void testNullness() throws Exception {
    NullPointerTester tester = new NullPointerTester();
    tester.ignore(Webpath.class.getMethod("equals", Object.class));
    tester.testAllPublicStaticMethods(Webpath.class);
    tester.testAllPublicInstanceMethods(wp("solo"));
    tester.testConstructors(WebpathInterner.class, NullPointerTester.Visibility.PUBLIC);
    tester.testAllPublicInstanceMethods(new WebpathInterner());
  }

  @Test
  public void testInterner_producesIdenticalInstances() throws Exception {
    WebpathInterner interner = new WebpathInterner();
    assertThat(interner.get("foo")).isSameInstanceAs(interner.get("foo"));
  }

  @Test
  public void testInterner_supportsFunctionalProgramming_forGreatJustice() throws Exception {
    WebpathInterner interner = new WebpathInterner();
    List<Webpath> dubs = Lists.transform(ImmutableList.of("foo", "foo"), interner);
    assertThat(dubs.get(0)).isSameInstanceAs(dubs.get(1));
  }

  @Test
  public void testInterner_duplicateSlashes_throwsIae() throws Exception {
    WebpathInterner interner = new WebpathInterner();
    thrown.expect(IllegalArgumentException.class);
    interner.get("foo//bar");
  }
}
