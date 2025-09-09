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

package io.bazel.rules.closure.webfiles;

import com.google.common.hash.Hasher;
import java.io.IOException;
import java.io.InputStream;
import javax.annotation.WillCloseWhenClosed;

/** Input stream wrapper that computes a webfile digest token. */
@SuppressWarnings("BetaApi")
final class HasherInputStream extends InputStream {

  private final InputStream delegate;
  final Hasher hasher;

  HasherInputStream(@WillCloseWhenClosed InputStream delegate, Hasher hasher) {
    this.delegate = delegate;
    this.hasher = hasher;
  }

  @Override
  public int read() throws IOException {
    int result = delegate.read();
    if (result != -1) {
      hasher.putByte((byte) result);
    }
    return result;
  }

  @Override
  public int read(byte[] buffer, int offset, int length) throws IOException {
    int amount = delegate.read(buffer, offset, length);
    if (amount > 0) {
      hasher.putBytes(buffer, offset, amount);
    }
    return amount;
  }

  @Override
  public int available() throws IOException {
    return delegate.available();
  }

  @Override
  public void close() throws IOException {
    delegate.close();
  }
}
