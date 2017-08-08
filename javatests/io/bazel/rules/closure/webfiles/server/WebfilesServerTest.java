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

package io.bazel.rules.closure.webfiles.server;

import static com.google.common.truth.Truth.assertThat;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.ImmutableList;
import com.google.common.io.ByteStreams;
import com.google.common.jimfs.Configuration;
import com.google.common.jimfs.Jimfs;
import com.google.common.net.HostAndPort;
import io.bazel.rules.closure.webfiles.BuildInfo.Webfiles;
import io.bazel.rules.closure.webfiles.BuildInfo.WebfilesSource;
import io.bazel.rules.closure.webfiles.server.BuildInfo.AssetInfo;
import io.bazel.rules.closure.webfiles.server.BuildInfo.WebfilesServerInfo;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.net.ServerSocketFactory;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Integration test for {@link WebfilesServer}. */
@RunWith(JUnit4.class)
public class WebfilesServerTest {

  private static final WebfilesServerInfo CONFIG =
      WebfilesServerInfo.newBuilder()
          .setLabel("//label")
          .setBind("localhost:0")
          .addManifest("/manifest.pbtxt")
          .addExternalAsset(
              AssetInfo.newBuilder().setWebpath("/external.txt").setPath("/external.txt").build())
          .build();

  private static final Webfiles MANIFEST =
      Webfiles.newBuilder()
          .addSrc(
              WebfilesSource.newBuilder()
                  .setWebpath("/a/b.txt")
                  .setPath("/webfile.txt")
                  .setLongpath("/webfile.txt")
                  .build())
          .build();

  private static final ExecutorService executor = Executors.newCachedThreadPool();

  @AfterClass
  public static void closeExecutor() throws Exception {
    executor.shutdownNow();
  }

  private final FileSystem fs = Jimfs.newFileSystem(Configuration.unix());
  private final WebfilesServer server =
      DaggerWebfilesServer_Server.builder()
          .args(ImmutableList.of("/config.pbtxt"))
          .executor(executor)
          .fs(fs)
          .serverSocketFactory(ServerSocketFactory.getDefault())
          .build()
          .server();

  @Before
  public void before() throws Exception {
    Files.write(fs.getPath("/external.txt"), "hello".getBytes(UTF_8));
    Files.write(fs.getPath("/webfile.txt"), "ohmygoth".getBytes(UTF_8));
    Files.write(fs.getPath("/manifest.pbtxt"), MANIFEST.toString().getBytes(UTF_8));
    Files.write(fs.getPath("/config.pbtxt"), CONFIG.toString().getBytes(UTF_8));
  }

  @After
  public void after() throws Exception {
    fs.close();
  }

  @Test
  public void indexPage_showsListingWithLabel() throws Exception {
    assertThat(fetch(server.spawn(), "/")).contains("//label");
  }

  @Test
  public void listingPage_showsWebpathsOnly() throws Exception {
    HostAndPort address = server.spawn();
    assertThat(fetch(address, "/")).contains("/a/b.txt");
    assertThat(fetch(address, "/")).doesNotContain("/external.txt");
  }

  @Test
  public void listingPage_filtersByRequestPath() throws Exception {
    assertThat(fetch(server.spawn(), "/fop")).doesNotContain("/a/b.txt");
  }

  @Test
  public void requestPathIsWebpath_servesContent() throws Exception {
    assertThat(fetch(server.spawn(), "/a/b.txt")).isEqualTo("ohmygoth");
  }

  @Test
  public void dottedPath_normalizes() throws Exception {
    assertThat(fetch(server.spawn(), "/a/c/../b.txt")).isEqualTo("ohmygoth");
  }

  @Test
  public void requestPathIsExternalFile_servesContent() throws Exception {
    assertThat(fetch(server.spawn(), "/external.txt")).isEqualTo("hello");
  }

  private static String fetch(HostAndPort address, String path) throws IOException {
    HttpURLConnection connection =
        (HttpURLConnection) new URL(String.format("http://%s%s", address, path)).openConnection();
    InputStream input;
    try {
      connection.connect();
      connection.getResponseCode();
      input = connection.getInputStream();
    } catch (FileNotFoundException e) {
      // don't care about 404 magic exception
      input = connection.getErrorStream();
    }
    try {
      return new String(ByteStreams.toByteArray(input), UTF_8);
    } finally {
      input.close();
    }
  }
}
