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

package io.bazel.rules.closure.webfiles;

import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;

/** Utilities for networking. */
final class NetworkUtils {

  /**
   * Returns the fully-qualified domain name of the local host in all lower case.
   *
   * @throws RuntimeException to wrap {@link UnknownHostException} if the local host could not be
   *     resolved into an address
   */
  static String getCanonicalHostName() {
    try {
      return getExternalAddressOfLocalSystem().getCanonicalHostName().toLowerCase();
    } catch (UnknownHostException e) {
      throw new RuntimeException(e);
    }
  }

  /**
   * Returns the externally-facing IPv4 network address of the local host.
   *
   * <p>This function implements a workaround for an
   * <a href="http://bugs.java.com/bugdatabase/view_bug.do?bug_id=4665037">issue</a> in
   * {@link InetAddress#getLocalHost}.
   *
   * <p><b>Note:</b> This code was pilfered from {@link "com.google.net.base.LocalHost"} which was
   * never made open source.
   *
   * @throws UnknownHostException if the local host could not be resolved into an address
   */
  private static InetAddress getExternalAddressOfLocalSystem() throws UnknownHostException {
    InetAddress localhost = InetAddress.getLocalHost();
    // If we have a loopback address, look for an address using the network cards.
    if (localhost.isLoopbackAddress()) {
      try {
        Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
        if (interfaces == null) {
          return localhost;
        }
        while (interfaces.hasMoreElements()) {
          NetworkInterface networkInterface = interfaces.nextElement();
          Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
          while (addresses.hasMoreElements()) {
            InetAddress address = addresses.nextElement();
            if (!(address.isLoopbackAddress()
                || address.isLinkLocalAddress()
                || address instanceof Inet6Address)) {
              return address;
            }
          }
        }
      } catch (SocketException e) {
        // Fall-through.
      }
    }
    return localhost;
  }

  private NetworkUtils() {}
}
