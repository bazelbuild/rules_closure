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

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import com.google.common.net.HostAndPort;
import java.net.BindException;
import java.net.InetAddress;
import java.net.ServerSocket;
import javax.net.ServerSocketFactory;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Unit tests for {@link NetworkUtils}. */
@RunWith(JUnit4.class)
public class NetworkUtilsTest {

  private final ServerSocket serverSocket = mock(ServerSocket.class);
  private final ServerSocketFactory serverSocketFactory = mock(ServerSocketFactory.class);
  private final NetworkUtils networkUtils = new NetworkUtils(serverSocketFactory);

  @Rule public final ExpectedException thrown = ExpectedException.none();

  @Test
  public void createServerSocket_bindRepeatedlyFails_eventuallyGivesUp() throws Exception {
    when(serverSocketFactory.createServerSocket(anyInt(), anyInt(), any(InetAddress.class)))
        .thenThrow(new BindException());
    thrown.expect(BindException.class);
    networkUtils.createServerSocket(HostAndPort.fromParts("localhost", 80), true);
  }
}
