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

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Preconditions.checkNotNull;

import com.google.common.collect.ImmutableSet;
import com.google.common.hash.Funnels;
import com.google.common.hash.Hasher;
import com.google.common.hash.Hashing;
import com.google.common.io.ByteStreams;
import com.google.protobuf.ByteString;
import io.bazel.rules.closure.webfiles.BuildInfo.WebfileInfo;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.Channels;
import java.nio.channels.SeekableByteChannel;
import java.nio.file.attribute.FileTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.annotation.WillCloseWhenClosed;
import javax.annotation.WillNotClose;

/**
 * Utility for creating a single deterministic zip file containing a set of web files.
 *
 * <p>This helper class is used to create both archives containing web files data, and then
 * populating the {@link WebfileInfo} proto fields which can be stored in the proto manifest created
 * by each build rule.
 *
 * <p>This writer is able to make educated guesses about which files in the archive should receive
 * DEFLATE compression based on the file extension. The aggressiveness of the compression can also
 * be tuned for different use cases. For example, incremental archives favor speed whereas deploy
 * archives favor a tradeoff of more CPU for smaller size.
 *
 * <p>This writer goes to the trouble of defining directory entries within the zip archive for any
 * files that are written. This is necessary in order for many zip implementations to be able to
 * successfully extract the archive.
 *
 * <p>This implementation also creates deterministic output. Normally zip archives have timestamps
 * that can harm the ability of Bazel to cache build artifacts. All timestamps within the zip are
 * set to a hard coded value.
 */
@SuppressWarnings("BetaApi")
public final class WebfilesWriter implements Closeable {

  private static final FileTime EPOCH = FileTime.fromMillis(472176000000L);

  private static final ImmutableSet<String> ALREADY_COMPRESSED_EXTENSIONS =
      ImmutableSet.of(
          "7z", "Z", "atom", "bz2", "deflate", "eot", "epub", "flv", "gif", "gz", "ico", "jar",
          "jpeg", "jpg", "kmz", "lzma", "lzo", "mbox", "mov", "mp4", "mpeg", "mpg", "ogg", "otf",
          "p12", "pdf", "png", "psd", "qt", "rdf", "tgz", "tif", "tiff", "ttf", "webm",
          "webmanifest", "webp", "wmv", "woff", "zip");

  private final SeekableByteChannel channel;
  private final OutputStream buffer;
  private final ZipOutputStream zip;
  private final Set<String> directories = new HashSet<>();
  private final List<WebfileInfo> webfiles = new ArrayList<>();

  /**
   * Creates new helper for writing webfiles to a new zip archive.
   *
   * @param channel Java 7 byte {@code channel} already opened with write permission
   * @param compressionLevel {@link Deflater} compression level [1,9] which trades trade and size
   */
  public WebfilesWriter(@WillCloseWhenClosed SeekableByteChannel channel, int compressionLevel) {
    this.channel = channel;
    buffer = new BufferedOutputStream(Channels.newOutputStream(channel), WebfilesUtils.BUFFER_SIZE);
    zip = new ZipOutputStream(buffer); // goes very slow without BufferedOutputStream
    zip.setComment("Created by Bazel Closure Rules");
    zip.setLevel(compressionLevel);
  }

  /** Returns list of protos to put in manifest based on what was written so far. */
  public List<WebfileInfo> getWebfiles() {
    return Collections.unmodifiableList(webfiles);
  }

  /**
   * Writes a webfile byte array.
   *
   * <p>This is a helper method for {@link #writeWebfile(WebfileInfo, InputStream)}.
   */
  public WebfileInfo writeWebfile(WebfileInfo webfile, byte[] data) throws IOException {
    return writeWebfile(webfile, new ByteArrayInputStream(data));
  }

  /**
   * Adds {@code webfile} {@code data} to zip archive and returns proto index entry.
   *
   * <p>The returned value can be written to the manifest associated with a rule so that parent
   * rules can obtain the data written here.
   *
   * @param webfile original information about webfile
   * @return modified version of {@code webfile} that's suitable for writing to the final manifest
   */
  public WebfileInfo writeWebfile(WebfileInfo webfile, @WillNotClose InputStream input)
      throws IOException {
    checkNotNull(input, "input");
    String name = WebfilesUtils.getZipEntryName(webfile);
    createEntriesForParentDirectories(name);
    ZipEntry entry = new ZipEntry(name);
    entry.setComment(webfile.getRunpath());
    // Build outputs need to be deterministic. Bazel also doesn't care about modified times because
    // it uses the file digest to determine if a file is invalidated. So even if we did copy the
    // time information from the original file, it still might not be a good idea.
    entry.setCreationTime(EPOCH);
    entry.setLastModifiedTime(EPOCH);
    entry.setLastAccessTime(EPOCH);
    if (isAlreadyCompressed(webfile.getWebpath())) {
      // When opting out of compression, ZipOutputStream expects us to do ALL THIS
      entry.setMethod(ZipEntry.STORED);
      if (input instanceof ByteArrayInputStream) {
        entry.setSize(input.available());
        Hasher hasher = Hashing.crc32().newHasher();
        input.mark(-1);
        ByteStreams.copy(input, Funnels.asOutputStream(hasher));
        input.reset();
        entry.setCrc(hasher.hash().padToLong());
      } else {
        byte[] data = ByteStreams.toByteArray(input);
        entry.setSize(data.length);
        entry.setCrc(Hashing.crc32().hashBytes(data).padToLong());
        input = new ByteArrayInputStream(data);
      }
    } else {
      entry.setMethod(ZipEntry.DEFLATED);
    }
    HasherInputStream source = new HasherInputStream(input, Hashing.sha256().newHasher());
    long offset = channel.position();
    zip.putNextEntry(entry);
    ByteStreams.copy(source, zip);
    zip.closeEntry();
    buffer.flush();
    WebfileInfo result =
        webfile
            .toBuilder()
            .clearPath() // Now that it's in the zip, we don't need the ctx.action execroot path.
            .setInZip(true)
            .setOffset(offset)
            .setDigest(ByteString.copyFrom(source.hasher.hash().asBytes()))
            .build();
    webfiles.add(result);
    return result;
  }

  private void createEntriesForParentDirectories(String name) throws IOException {
    checkArgument(!name.startsWith("/") && !name.endsWith("/"));
    int pos = 0;
    boolean mutated = false;
    while (true) {
      pos = name.indexOf('/', pos + 1);
      if (pos == -1) {
        break;
      }
      String directory = name.substring(0, pos + 1);
      if (directories.add(directory)) {
        ZipEntry entry = new ZipEntry(directory);
        entry.setSize(0);
        // Directories in web path space aren't real, so we must use the epoch timestamp.
        entry.setCreationTime(EPOCH);
        entry.setLastModifiedTime(EPOCH);
        entry.setLastAccessTime(EPOCH);
        zip.putNextEntry(entry);
        zip.closeEntry();
        mutated = true;
      }
    }
    if (mutated) {
      buffer.flush();
    }
  }

  /** Returns {@code true} if {@code path} has an extension that already seems to be compressed. */
  private static boolean isAlreadyCompressed(String path) {
    return ALREADY_COMPRESSED_EXTENSIONS.contains(path.substring(path.lastIndexOf('.') + 1));
  }

  @Override
  public void close() throws IOException {
    zip.close();
    channel.close(); // superfluous but legal
  }
}
