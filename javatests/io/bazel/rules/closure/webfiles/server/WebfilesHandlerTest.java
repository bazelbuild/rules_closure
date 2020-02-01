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
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

import com.google.common.jimfs.Configuration;
import com.google.common.jimfs.Jimfs;
import io.bazel.rules.closure.Webpath;
import io.bazel.rules.closure.http.HttpRequest;
import io.bazel.rules.closure.http.HttpResponse;
import java.net.URI;
import java.nio.file.FileSystem;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Unit tests for {@link WebfilesHandler}. */
@RunWith(JUnit4.class)
public class WebfilesHandlerTest {

  private final FileSystem fs = Jimfs.newFileSystem(Configuration.unix());
  private final FileServer fileServer = mock(FileServer.class);
  private final ListingPage listingPage = mock(ListingPage.class);
  private final HttpRequest request = new HttpRequest();
  private final HttpResponse response = new HttpResponse();
  private final WebfilesHandler app =
      new WebfilesHandler(request, response, fileServer, listingPage);

  @After
  public void after() throws Exception {
    fs.close();
    verifyNoMoreInteractions(fileServer, listingPage);
  }

  @Test
  public void uriWithoutSlash_returns400() throws Exception {
    request.setUri(URI.create("laffo"));
    app.handle();
    assertThat(response.getStatus()).isEqualTo(400);
  }

  @Test
  public void postRequest_respondsBadMethod() throws Exception {
    request.setMethod("POST");
    app.handle();
    assertThat(response.getStatus()).isEqualTo(405);
  }

  @Test
  public void fileFound_servesFileAndDoesntDisplayListingPage() throws Exception {
    when(fileServer.serve(Webpath.get("/foo.txt"))).thenReturn(true);
    request.setUri(URI.create("/foo.txt"));
    app.handle();
    assertThat(response.getStatus()).isEqualTo(200);
    verify(fileServer).serve(eq(Webpath.get("/foo.txt")));
  }

  @Test
  public void fileNotFound_servesFileAndDoesntDisplayListingPage() throws Exception {
    request.setUri(URI.create("/ohno.txt"));
    app.handle();
    assertThat(response.getStatus()).isEqualTo(404);
    verify(fileServer).serve(eq(Webpath.get("/ohno.txt")));
    verify(listingPage).serve(eq(Webpath.get("/ohno.txt")));
  }
}
