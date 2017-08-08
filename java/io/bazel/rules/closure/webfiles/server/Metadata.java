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

import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.base.Joiner;
import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.ImmutableSortedMap;
import com.google.common.collect.Lists;
import com.google.common.collect.Ordering;
import com.google.common.collect.Sets;
import com.google.protobuf.TextFormat;
import dagger.Module;
import dagger.Provides;
import io.bazel.rules.closure.Webpath;
import io.bazel.rules.closure.webfiles.BuildInfo.Webfiles;
import io.bazel.rules.closure.webfiles.BuildInfo.WebfilesSource;
import io.bazel.rules.closure.webfiles.server.Annotations.Args;
import io.bazel.rules.closure.webfiles.server.Annotations.RequestScope;
import io.bazel.rules.closure.webfiles.server.Annotations.ServerScope;
import io.bazel.rules.closure.webfiles.server.BuildInfo.AssetInfo;
import io.bazel.rules.closure.webfiles.server.BuildInfo.WebfilesServerInfo;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.nio.channels.ClosedByInterruptException;
import java.nio.charset.StandardCharsets;
import java.nio.file.ClosedWatchServiceException;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardWatchEventKinds;
import java.nio.file.WatchEvent;
import java.nio.file.WatchKey;
import java.nio.file.WatchService;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.concurrent.Executor;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Nullable;
import javax.annotation.concurrent.GuardedBy;
import javax.inject.Inject;

@Module
final class Metadata {

  private static final Logger logger = Logger.getLogger(Metadata.class.getName());

  @Provides
  static ImmutableSortedMap<Webpath, Path> provideAssets(Snapshot snapshot) {
    return snapshot.assets;
  }

  @Provides
  static ImmutableSet<Webpath> provideWebpaths(Snapshot snapshot) {
    return snapshot.webpaths;
  }

  @Provides
  @RequestScope // so build graph has snapshot isolation within each request
  static Snapshot provideBuildGraph(Container container) {
    return container.snapshot;
  }

  static class Config {
    private final Path path;
    private final String args;

    @Inject
    Config(Runfiles runfiles, @Args ImmutableList<String> args) {
      Iterator<String> i = args.iterator();
      this.path = runfiles.getPath(i.next());
      this.args = Joiner.on(' ').join(i);
    }

    Path getPath() {
      return path;
    }

    WebfilesServerInfo get() throws IOException {
      TextFormat.Parser parser = TextFormat.getParser();
      WebfilesServerInfo.Builder builder = WebfilesServerInfo.newBuilder();
      parser.merge(new String(Files.readAllBytes(path), StandardCharsets.UTF_8), builder);
      parser.merge(args, builder);
      return builder.build();
    }
  }

  static final class Loader implements Runnable {
    private final Runfiles runfiles;
    private final Container container;
    private final Config config;

    @Nullable
    @GuardedBy("this")
    private Thread activeThread;

    @Inject
    Loader(Runfiles runfiles, Container container, Config config) {
      this.runfiles = runfiles;
      this.container = container;
      this.config = config;
    }

    @Override
    public void run() {
      synchronized (this) {
        if (activeThread != null) {
          activeThread.interrupt();
        }
        activeThread = Thread.currentThread();
      }
      try {
        loadMetadataIntoObjectGraph();
      } catch (ClosedByInterruptException | InterruptedIOException e) {
        // this thread was preempted
      } catch (IOException | RuntimeException e) {
        logger.log(Level.SEVERE, "Failed to load build graph", e);
      } finally {
        synchronized (this) {
          if (Thread.currentThread().equals(activeThread)) {
            activeThread = null;
          }
        }
      }
    }

    void loadMetadataIntoObjectGraph() throws IOException {
      long start = System.currentTimeMillis();
      ImmutableSet.Builder<Path> manifestPaths = new ImmutableSet.Builder<>();
      manifestPaths.add(config.getPath());
      WebfilesServerInfo params = config.get();
      List<Webfiles> manifests = new ArrayList<>();
      for (String longPath : Lists.reverse(params.getManifestList())) {
        Path manifestPath = runfiles.getPath(longPath);
        manifestPaths.add(manifestPath);
        Webfiles.Builder builder = Webfiles.newBuilder();
        TextFormat.getParser().merge(new String(Files.readAllBytes(manifestPath), UTF_8), builder);
        manifests.add(builder.build());
      }
      SortedMap<Webpath, Path> assets = new TreeMap<>(Ordering.natural());
      for (AssetInfo asset : params.getExternalAssetList()) {
        assets.put(Webpath.get(asset.getWebpath()), runfiles.getPath(asset.getPath()));
      }
      Set<Webpath> webpaths = new LinkedHashSet<>();
      for (Webfiles manifest : manifests) {
        for (WebfilesSource src : manifest.getSrcList()) {
          Webpath webpath = Webpath.get(src.getWebpath());
          assets.put(webpath, runfiles.getPath(src.getLongpath()));
          webpaths.add(Webpath.get(src.getWebpath()));
        }
      }
      container.snapshot =
          new Snapshot(
              ImmutableSortedMap.copyOfSorted(assets),
              ImmutableSet.copyOf(webpaths),
              manifestPaths.build());
      logger.info(String.format("Loaded build graph in %,dms", System.currentTimeMillis() - start));
      synchronized (container) {
        container.notifyAll();
      }
    }
  }

  static final class Reloader implements Runnable {
    private final Executor executor;
    private final FileSystem fs;
    private final Container container;
    private final Loader loader;

    @GuardedBy("this")
    private boolean isReady;

    @Inject
    Reloader(Executor executor, FileSystem fs, Container container, Loader loader) {
      this.executor = executor;
      this.fs = fs;
      this.container = container;
      this.loader = loader;
    }

    void spawn() throws InterruptedException {
      synchronized (this) {
        executor.execute(this);
        while (!isReady) {
          wait();
        }
      }
    }

    @Override
    public void run() {
      try {
        monitorFileSystem();
      } catch (ClosedWatchServiceException e) {
        // shutting down
      } catch (IOException | RuntimeException e) {
        logger.log(Level.SEVERE, "Failed to monitor filesystem", e);
      }
    }

    private void monitorFileSystem() throws IOException {
      loader.run();
      Set<Path> directories = new HashSet<>();
      BiMap<Path, Path> symlinksToFiles = HashBiMap.create();
      try (WatchService watcher = fs.newWatchService()) {
        while (true) {
          for (Path symlink : container.snapshot.manifestPaths) {
            if (!symlinksToFiles.containsKey(symlink)) {
              Path file = symlink.toRealPath();
              symlinksToFiles.put(symlink, file);
              Path directory = file.getParent();
              if (directories.add(directory)) {
                directory.register(watcher, StandardWatchEventKinds.ENTRY_MODIFY);
              }
            }
          }
          synchronized (this) {
            isReady = true;
            notify();
          }
          Set<Path> modified;
          try {
            modified = awaitChanges(watcher);
          } catch (InterruptedException e) {
            break;
          }
          if (Sets.intersection(symlinksToFiles.values(), modified).isEmpty()) {
            continue;
          }
          executor.execute(loader);
        }
      }
    }
  }

  @ServerScope // per-server global variable with state change notifications
  static final class Container {
    private volatile Snapshot snapshot =
        new Snapshot(
            ImmutableSortedMap.<Webpath, Path>of(),
            ImmutableSet.<Webpath>of(),
            ImmutableSet.<Path>of());

    @Inject
    Container() {}
  }

  static final class Snapshot {
    private final ImmutableSortedMap<Webpath, Path> assets;
    private final ImmutableSet<Webpath> webpaths;
    private final ImmutableSet<Path> manifestPaths;

    private Snapshot(
        ImmutableSortedMap<Webpath, Path> assets,
        ImmutableSet<Webpath> webpaths,
        ImmutableSet<Path> manifestPaths) {
      this.assets = assets;
      this.webpaths = webpaths;
      this.manifestPaths = manifestPaths;
    }
  }

  /** Returns set of files that have been modified. */
  private static Set<Path> awaitChanges(WatchService watcher) throws InterruptedException {
    Set<Path> paths = new HashSet<>();
    WatchKey key = watcher.take();
    do {
      Path directory = (Path) key.watchable();
      for (WatchEvent<?> event : key.pollEvents()) {
        paths.add(directory.resolve((Path) event.context()));
      }
      key.reset();
    } while ((key = watcher.poll()) != null);
    return paths;
  }
}
