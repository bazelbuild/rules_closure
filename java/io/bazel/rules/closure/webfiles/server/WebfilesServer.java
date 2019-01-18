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

import static com.google.common.base.Preconditions.checkState;
import static com.google.common.base.Strings.nullToEmpty;
import static com.google.common.io.Resources.getResource;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.ImmutableList;
import com.google.common.io.Resources;
import com.google.common.net.HostAndPort;
import dagger.BindsInstance;
import dagger.Component;
import dagger.Subcomponent;
import io.bazel.rules.closure.http.HttpConnectionComponent;
import io.bazel.rules.closure.http.HttpHandler;
import io.bazel.rules.closure.http.HttpRequestComponent;
import io.bazel.rules.closure.http.HttpServer;
import io.bazel.rules.closure.http.HttpServerComponent;
import io.bazel.rules.closure.http.filter.GzipFilter;
import io.bazel.rules.closure.http.filter.LoggingFilter;
import io.bazel.rules.closure.http.filter.NoCacheFilter;
import io.bazel.rules.closure.http.filter.Transmitter;
import io.bazel.rules.closure.webfiles.server.Annotations.Args;
import io.bazel.rules.closure.webfiles.server.Annotations.RequestScope;
import io.bazel.rules.closure.webfiles.server.Annotations.ServerScope;
import io.bazel.rules.closure.webfiles.server.BuildInfo.WebfilesServerInfo;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.ServerSocket;
import java.nio.channels.ClosedByInterruptException;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Nullable;
import javax.annotation.concurrent.GuardedBy;
import javax.inject.Inject;
import javax.net.ServerSocketFactory;

/** Development web server for a single webfiles() rule. */
public final class WebfilesServer implements Runnable {

  private static final Logger logger = Logger.getLogger(WebfilesServer.class.getName());

  private static final boolean WANT_COLOR =
      System.getenv("NO_COLOR") == null &&
      nullToEmpty(System.getenv("TERM")).contains("xterm");

  private static final String BLUE = WANT_COLOR ? "\u001b[34m" : "";
  private static final String BOLD = WANT_COLOR ? "\u001b[1m" : "";
  private static final String RESET = WANT_COLOR ? "\u001b[0m" : "";

  public static void main(String[] args) throws Exception {
    ExecutorService executor = Executors.newCachedThreadPool();
    try {
      DaggerWebfilesServer_Server.builder()
          .args(ImmutableList.copyOf(args))
          .executor(executor)
          .fs(FileSystems.getDefault())
          .serverSocketFactory(ServerSocketFactory.getDefault())
          .build()
          .server()
          .run();
    } finally {
      executor.shutdownNow();
    }
  }

  private final Executor executor;
  private final NetworkUtils network;
  private final HttpServer<Server> httpServer;
  private final Metadata.Config config;
  private final Metadata.Loader metadataLoader;
  private final Metadata.Reloader metadataReloader;

  @Nullable
  @GuardedBy("this")
  private HostAndPort actualAddress;

  @Inject
  WebfilesServer(
      Executor executor,
      NetworkUtils network,
      HttpServer<Server> httpServer,
      Metadata.Config config,
      Metadata.Loader metadataLoader,
      Metadata.Reloader metadataReloader) {
    this.executor = executor;
    this.network = network;
    this.httpServer = httpServer;
    this.config = config;
    this.metadataLoader = metadataLoader;
    this.metadataReloader = metadataReloader;
  }

  /** Spawns a new thread that calls {@link #runForever()} and returns bound address. */
  public HostAndPort spawn() throws InterruptedException {
    synchronized (this) {
      checkState(actualAddress == null);
      executor.execute(this);
      while (actualAddress == null) {
        wait();
      }
      return actualAddress;
    }
  }

  /** Delegates to {@link #runForever()} and handles exceptions. */
  @Override
  public void run() {
    try {
      runForever();
    } catch (InterruptedException | ClosedByInterruptException | InterruptedIOException e) {
      // Ctrl-C
    } catch (IOException | RuntimeException e) {
      logger.log(Level.SEVERE, "Webfiles server died", e);
    }
  }

  /** Runs webfiles server in event loop. */
  public void runForever() throws IOException, InterruptedException {
    WebfilesServerInfo params = config.get();
    HostAndPort bind = HostAndPort.fromString(params.getBind()).withDefaultPort(80);
    try (ServerSocket socket = network.createServerSocket(bind, !params.getFailIfPortInUse())) {
      if (params.getNoReloader()) {
        metadataLoader.loadMetadataIntoObjectGraph();
      } else {
        metadataReloader.spawn();
      }
      HostAndPort address = HostAndPort.fromParts(bind.getHost(), socket.getLocalPort());
      synchronized (this) {
        checkState(actualAddress == null);
        actualAddress = address;
        notify();
      }
      logger.info(
          String.format(
              "\n%sClosure Rules %s%s%s\n%sListening on: %shttp://%s/%s\n\n",
              BLUE,
              BOLD,
              WebfilesServer.class.getSimpleName(),
              RESET,
              BLUE,
              BOLD,
              NetworkUtils.createUrlAddress(address),
              RESET));
      while (true) {
        httpServer.handleOneConnection(socket);
      }
    }
  }

  static final class Processor implements HttpHandler {
    private final HttpHandler delegate;
    private final GzipFilter gzipFilter;
    private final NoCacheFilter noCacheFilter;
    private final IWantToBeVulnerableToXssAttacksFilter corsFilter;

    @Inject
    Processor(
        LoggingFilter<WebfilesHandler> delegate,
        GzipFilter gzipFilter,
        NoCacheFilter noCacheFilter,
        IWantToBeVulnerableToXssAttacksFilter corsFilter) {
      this.delegate = delegate;
      this.gzipFilter = gzipFilter;
      this.noCacheFilter = noCacheFilter;
      this.corsFilter = corsFilter;
    }

    @Override
    public void handle() throws Exception {
      delegate.handle();
      gzipFilter.apply();
      noCacheFilter.apply();
      corsFilter.apply();
    }
  }

  @ServerScope
  @Component
  interface Server
      extends HttpServerComponent<
          Transmitter<Processor>, Connection, Connection.Builder, Request, Request.Builder> {
    WebfilesServer server();

    @Component.Builder
    interface Builder {
      @BindsInstance Builder args(@Args ImmutableList<String> args);
      @BindsInstance Builder executor(Executor executor);
      @BindsInstance Builder fs(FileSystem fs);
      @BindsInstance Builder serverSocketFactory(ServerSocketFactory serverSocketFactory);
      Server build();
    }
  }

  @Subcomponent
  interface Connection
      extends HttpConnectionComponent<Transmitter<Processor>, Request, Request.Builder> {
    @Subcomponent.Builder
    interface Builder
        extends HttpConnectionComponent.Builder<
            Transmitter<Processor>, Connection, Connection.Builder, Request, Request.Builder> {}
  }

  @RequestScope
  @Subcomponent(modules = Metadata.class)
  interface Request extends HttpRequestComponent<Transmitter<Processor>> {
    @Subcomponent.Builder
    interface Builder
        extends HttpRequestComponent.Builder<Transmitter<Processor>, Request, Request.Builder> {}
  }
}
