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

import static com.google.common.base.MoreObjects.firstNonNull;
import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Strings.nullToEmpty;
import static com.google.common.base.Verify.verify;
import static com.google.common.io.Resources.getResource;
import static java.nio.charset.StandardCharsets.UTF_8;
import static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST;
import static javax.servlet.http.HttpServletResponse.SC_NOT_FOUND;

import com.google.common.base.Functions;
import com.google.common.base.Predicate;
import com.google.common.base.Splitter;
import com.google.common.collect.FluentIterable;
import com.google.common.collect.Iterables;
import com.google.common.collect.Iterators;
import com.google.common.io.Resources;
import com.google.common.net.HostAndPort;
import com.google.common.net.MediaType;
import com.google.template.soy.SoyFileSet;
import com.google.template.soy.data.SoyListData;
import com.google.template.soy.data.SoyMapData;
import com.google.template.soy.tofu.SoyTofu;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.BindException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.util.zip.GZIPOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.bio.SocketConnector;
import org.mortbay.jetty.servlet.Context;
import org.mortbay.jetty.servlet.ServletHolder;

/** Development web server for a single webfiles() rule. */
public final class WebfilesServer extends HttpServlet {

  private static final String BLUE = "\u001b[34m";
  private static final String BOLD = "\u001b[1m";
  private static final String RESET = "\u001b[0m";

  private static final HostAndPort DEFAULT_BIND = HostAndPort.fromString("[::]:6006");
  private static final Path RUNFILES_PATH = Paths.get("..");
  private static final Path RUNFILES_PREFIX = Paths.get("/_/runfiles");
  private static final MediaType DEFAULT_MIME_TYPE = MediaType.OCTET_STREAM;
  private static final Splitter TAB_SPLITTER = Splitter.on('\t');
  private static final Pattern ALLOWS_GZIP =
      Pattern.compile("(?:^|,|\\s)(?:(?:x-)?gzip|\\*)(?!;q=0)(?:\\s|,|$)");
  private static final SoyTofu TOFU =
      SoyFileSet.builder()
          .add(getResource(ListingSoyInfo.class, ListingSoyInfo.getInstance().getFileName()))
          .build()
          .compileToTofu();

  private static final Logger logger = Logger.getLogger(WebfilesServer.class.getName());
  private static final HashMap<Path, Path> assets = new HashMap<>();
  private static final List<Path> reverseTopologicalPaths = new ArrayList<>();
  private static String label = "//";

  public static void main(String[] args) throws Exception {
    boolean bindWasAskedFor = false;
    HostAndPort bind = DEFAULT_BIND;
    Iterator<String> flags = Iterators.forArray(args);
    while (flags.hasNext()) {
      String flag = flags.next();
      switch (flag) {
        case "--bind":
          bind = HostAndPort.fromString(flags.next());
          bindWasAskedFor = true;
          break;
        case "--label":
          label = flags.next();
          break;
        case "--manifest":
          loadManifest(Paths.get(flags.next()));
          break;
        default:
          throw new RuntimeException("Unexpected flag: " + flag);
      }
    }
    Server server;
    while (true) {
      server = new Server();
      server.addConnector(createConnector(bind));
      Context context = new Context(server, "/", Context.SESSIONS);
      context.addServlet(new ServletHolder(WebfilesServer.class), "/*");
      server.addHandler(context);
      try {
        server.start();
        break;
      } catch (BindException e) {
        if (bindWasAskedFor) {
          server.stop();
          throw e;
        }
        bind = HostAndPort.fromParts(bind.getHostText(), bind.getPort() + 1);
      }
    }
    System.err.println();
    System.err.write(
        Resources.toByteArray(getResource(WebfilesServer.class, "invisible_college.ansi")));
    System.err.printf(
        "\n%sClosure Rules %s%s%s\n%sListening on: %shttp://%s/%s\n\n",
        BLUE, BOLD, WebfilesServer.class.getSimpleName(), RESET,
        BLUE, BOLD, createUrlAddress(bind), RESET);
    server.join();
  }

  @Override
  public void doHead(HttpServletRequest req, HttpServletResponse rsp) throws IOException {
    new Handler(req, rsp, true).handle();
  }

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException {
    new Handler(req, rsp, false).handle();
  }

  private static final class Handler {
    private final HttpServletRequest req;
    private final HttpServletResponse rsp;
    private final boolean isHead;

    Handler(HttpServletRequest req, HttpServletResponse rsp, boolean isHead) {
      this.req = req;
      this.rsp = rsp;
      this.isHead = isHead;
    }

    void handle() throws IOException {
      final Path webpath = Paths.get(req.getPathInfo()).normalize();
      if (webpath == null || !webpath.isAbsolute()) {
        serveError(SC_BAD_REQUEST, "Bad path");
        return;
      }
      Path path = assets.get(webpath);
      if (path != null) {
        serveAsset(path);
        return;
      }
      if (webpath.startsWith(RUNFILES_PREFIX)) {
        path = webpath.subpath(RUNFILES_PREFIX.getNameCount(), webpath.getNameCount());
        verify(!path.isAbsolute());
        path = RUNFILES_PATH.resolve(path);
        if (Files.exists(path)) {
          serveAsset(path);
          return;
        }
      }
      rsp.setStatus(SC_NOT_FOUND);
      serveData(
          TOFU.newRenderer(ListingSoyInfo.LISTING)
              .setData(new SoyMapData(
                  ListingSoyInfo.ListingSoyTemplateInfo.LABEL,
                  label,
                  ListingSoyInfo.ListingSoyTemplateInfo.PATHS,
                  new SoyListData(FluentIterable
                      .from(reverseTopologicalPaths)
                      .filter(
                          new Predicate<Path>() {
                            @Override
                            public boolean apply(Path path) {
                              return path.startsWith(webpath);
                            }
                          })
                      .transform(Functions.toStringFunction()))))
              .render()
              .getBytes(UTF_8),
          MediaType.HTML_UTF_8);
    }

    private void serveAsset(Path path) throws IOException {
      serveData(
          Files.readAllBytes(path),
          firstNonNull(
              MimeTypes.EXTENSIONS.get(getExtension(path)),
              DEFAULT_MIME_TYPE));
    }

    private void serveError(int status, String message) throws IOException {
      logger.info(String.format("sending %d for %s: %s", status, req.getPathInfo(), message));
      rsp.setStatus(status);
      serveData(message.getBytes(UTF_8), MediaType.PLAIN_TEXT_UTF_8);
    }

    private void serveData(byte[] data, MediaType contentType) throws IOException {
      rsp.setContentType(contentType.toString());
      if (MimeTypes.COMPRESSIBLE.contains(contentType.withoutParameters())
          && ALLOWS_GZIP.matcher(nullToEmpty(req.getHeader("Accept-Encoding"))).find()) {
        rsp.setHeader("Content-Encoding", "gzip");
        try (ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
          try (GZIPOutputStream zipper = new GZIPOutputStream(buffer)) {
            zipper.write(data);
          }
          data = buffer.toByteArray();
        }
      }
      rsp.setContentLength(data.length);
      disableCaching();
      if (!isHead) {
        rsp.getOutputStream().write(data);
      }
    }

    private void disableCaching() {
      rsp.setHeader("Expires", "0");
      rsp.setHeader("Cache-Control", "no-cache, must-revalidate");
    }

    private static String getExtension(Path path) {
      String name = path.getFileName().toString();
      int dot = name.lastIndexOf('.');
      return dot == -1 ? "" : name.substring(dot + 1);
    }
  }

  private static void loadManifest(Path manifest) throws IOException {
    for (String line : Iterables.skip(Files.readAllLines(manifest, UTF_8), 1)) {
      List<String> columns = TAB_SPLITTER.splitToList(line);
      Path webpath = Paths.get(columns.get(0));
      Path runfile = Paths.get(columns.get(1));
      checkArgument(webpath.isAbsolute(),
          "bad webpath in %s on line %s", manifest, line);
      assets.put(webpath, runfile);
      reverseTopologicalPaths.add(webpath);
    }
  }

  private static Connector createConnector(HostAndPort address) {
    SocketConnector connector = new SocketConnector();
    connector.setHost(address.getHostText());
    connector.setPort(address.getPortOrDefault(80));
    return connector;
  }

  private static HostAndPort createUrlAddress(HostAndPort address) {
    if (address.getHostText().equals("::") || address.getHostText().equals("0.0.0.0")) {
      return address.getPortOrDefault(80) == 80
          ? HostAndPort.fromHost(NetworkUtils.getCanonicalHostName())
          : HostAndPort.fromParts(NetworkUtils.getCanonicalHostName(), address.getPort());
    } else {
      return address.getPortOrDefault(80) == 80
          ? HostAndPort.fromHost(address.getHostText())
          : address;
    }
  }
}
