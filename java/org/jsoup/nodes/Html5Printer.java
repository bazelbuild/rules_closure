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

package org.jsoup.nodes;

import static com.google.common.base.Preconditions.checkNotNull;

import com.google.common.base.CharMatcher;
import com.google.common.collect.ImmutableSet;
import java.io.IOException;

/**
 * HTML5 document serializer.
 *
 * <p>This printer prints HTML documents in HTML5 style, where optional tags are omitted. This
 * printer is particularly suitable to the printing of HTML documents that have additional documents
 * inlined within them, which is the case with HTML imports.
 *
 * <h3>Implementation Notes</h3>
 *
 * <p>The rules implemented by this class are defined by the <a
 * href="https://www.w3.org/TR/html5/syntax.html#optional-tags">W3C HTML5 Specification</a>.
 *
 * <p>This class is sealed within the jsoup package as a stopgap until we can upstream a patch that
 * makes {@link Node#outerHtmlHead(Appendable, int, org.jsoup.nodes.Document.OutputSettings)} and
 * {@link Node#outerHtmlTail(Appendable, int, org.jsoup.nodes.Document.OutputSettings)} publicly
 * visible. Otherwise it would not be possible for us to efficiently serialize HTML documents
 * without rewriting this functionality ourselves.
 */
public final class Html5Printer {

  private static final ImmutableSet<String> CHILDREN_THAT_MAKE_BODY_OPEN_MANDATORY =
      ImmutableSet.of("meta", "link", "script", "style", "template");

  private static final ImmutableSet<String> SIBLINGS_THAT_MAKE_P_CLOSE_OPTIONAL =
      ImmutableSet.of(
          "address",
          "article",
          "aside",
          "blockquote",
          "div",
          "dl",
          "fieldset",
          "footer",
          "form",
          "h1",
          "h2",
          "h3",
          "h4",
          "h5",
          "h6",
          "header",
          "hgroup",
          "hr",
          "main",
          "nav",
          "ol",
          "p",
          "pre",
          "section",
          "table",
          "ul");

  /** Turns {@code document} into HTML text. */
  public static String stringify(Document document) throws IOException {
    StringBuilder result = new StringBuilder(2048);
    Html5Printer printer = new Html5Printer(result, document.getOutputSettings());
    printer.append(document);
    return result.toString();
  }

  private final Appendable output;
  private final Document.OutputSettings settings;
  private boolean omittedTableSectionEnd;
  private Node currentNode;
  private boolean hadHead;
  private boolean hadHeadClose;

  public Html5Printer(Appendable output, Document.OutputSettings settings) throws IOException {
    this.output = checkNotNull(output, "output");
    this.settings = checkNotNull(settings, "settings");
    output.append("<!doctype html>");
  }

  /** Stringifies {@code root} recursively to output state. */
  public void append(Node root) throws IOException {
    currentNode = root;
    int depth = 0;
    while (currentNode != null) {
      emitOpeningTagIfRequiredByHtml5(depth);
      if (currentNode.childNodeSize() > 0) {
        currentNode = currentNode.childNode(0);
        depth++;
      } else {
        while (currentNode.nextSibling() == null && depth > 0) {
          emitClosingTagIfRequiredByHtml5(depth);
          currentNode = currentNode.parentNode();
          depth--;
        }
        emitClosingTagIfRequiredByHtml5(depth);
        if (currentNode.equals(root)) {
          break;
        }
        currentNode = currentNode.nextSibling();
      }
    }
  }

  private void emitOpeningTagIfRequiredByHtml5(int depth) throws IOException {
    if (isDocumentOrDoctype()) {
      return;
    }
    if (currentNode instanceof Element
        && currentNode.attributes().size() == 0
        && currentNode.attributes().dataset().isEmpty()) {
      switch (currentNode.nodeName()) {
        case "html":
          if (currentNode.childNodeSize() > 0 && !(currentNode.childNode(0) instanceof Comment)) {
            return;
          }
          break;
        case "head":
          if (hadHead) {
            return;
          }
          hadHead = true;
          if (currentNode.childNodeSize() == 0 || currentNode.childNode(0) instanceof Element) {
            return;
          }
          break;
        case "body":
          if (currentNode.childNodeSize() == 0) {
            return;
          }
          Node firstChild = currentNode.childNode(0);
          if (firstChild instanceof Comment
              || CHILDREN_THAT_MAKE_BODY_OPEN_MANDATORY.contains(firstChild.nodeName())
              || startsWithWhitespace(firstChild)) {
            break;
          }
          return;
        case "tbody":
          if (currentNode.childNodeSize() > 0
              && currentNode.childNode(0).nodeName().equals("tr")
              && !omittedTableSectionEnd) {
            return;
          }
          break;
        default:
          // ignored
      }
    }
    // This method is package-private. We intend to beseech jsoup's author to make it public.
    currentNode.outerHtmlHead(output, depth, settings);
  }

  private void emitClosingTagIfRequiredByHtml5(int depth) throws IOException {
    omittedTableSectionEnd = false;
    if (isDocumentOrDoctype()) {
      return;
    }
    Node nextSibling = currentNode.nextSibling();
    if (currentNode instanceof Element) {
      switch (currentNode.nodeName()) {
        case "html":
        case "body":
          if (!(nextSibling instanceof Comment)) {
            return;
          }
          break;
        case "head":
          if (hadHeadClose) {
            return;
          }
          hadHeadClose = true;
          if (!(nextSibling instanceof Comment && startsWithWhitespace(nextSibling))) {
            return;
          }
          break;
        case "li":
          if (nextSibling == null || nextSibling.nodeName().equals("li")) {
            return;
          }
          break;
        case "dt":
          if (nextSibling != null
              && (nextSibling.nodeName().equals("dt") || nextSibling.nodeName().equals("dd"))) {
            return;
          }
          break;
        case "dd":
          if (nextSibling == null
              || nextSibling.nodeName().equals("dt")
              || nextSibling.nodeName().equals("dd")) {
            return;
          }
          break;
        case "p":
          if (!currentNode.parent().nodeName().equals("a")
              || nextSibling == null
              || SIBLINGS_THAT_MAKE_P_CLOSE_OPTIONAL.contains(nextSibling.nodeName())) {
            return;
          }
          break;
        case "rb":
        case "rt":
        case "rtc":
        case "rp":
          if (nextSibling == null
              || nextSibling.nodeName().equals("rb")
              || nextSibling.nodeName().equals("rtc")
              || nextSibling.nodeName().equals("rp")
              || (nextSibling.nodeName().equals("rt") && !currentNode.nodeName().equals("rtc"))) {
            return;
          }
          break;
        case "optgroup":
          if (nextSibling == null || nextSibling.nodeName().equals("optgroup")) {
            return;
          }
          break;
        case "option":
          if (nextSibling == null
              || nextSibling.nodeName().equals("option")
              || nextSibling.nodeName().equals("optgroup")) {
            return;
          }
          break;
        case "thead":
        case "tbody":
          if (nextSibling == null
              || nextSibling.nodeName().equals("tbody")
              || nextSibling.nodeName().equals("tfoot")) {
            omittedTableSectionEnd = true;
            return;
          }
          break;
        case "tfoot":
          if (nextSibling == null || nextSibling.nodeName().equals("tbody")) {
            omittedTableSectionEnd = true;
            return;
          }
          break;
        case "tr":
          if (nextSibling == null || nextSibling.nodeName().equals("tr")) {
            return;
          }
          break;
        case "td":
        case "th":
          if (nextSibling == null
              || nextSibling.nodeName().equals("tr")
              || nextSibling.nodeName().equals("th")) {
            return;
          }
          break;
        default:
          // ignored
      }
    }
    // This method is package-private. We intend to beseech jsoup's author to make it public.
    currentNode.outerHtmlTail(output, depth, settings);
  }

  private boolean isDocumentOrDoctype() {
    return currentNode instanceof DocumentType || currentNode instanceof Document;
  }

  private static boolean startsWithWhitespace(Node child) {
    if (child instanceof TextNode) {
      String firstText = ((TextNode) child).text();
      if (!firstText.isEmpty() && CharMatcher.whitespace().matches(firstText.charAt(0))) {
        return true;
      }
    }
    return false;
  }
}
