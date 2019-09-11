/*
 * Copyright 2016 The Closure Rules Authors. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.javascript.jscomp;

import static com.google.common.base.Strings.nullToEmpty;
import static com.google.javascript.jscomp.JsCheckerHelper.convertPathToModuleName;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Ordering;
import com.google.debugging.sourcemap.proto.Mapping.OriginalMapping;
import com.google.javascript.jscomp.SourceExcerptProvider.ExcerptFormatter;
import com.google.javascript.jscomp.SourceExcerptProvider.SourceExcerpt;
import com.google.javascript.rhino.TokenUtil;
import java.util.List;
import java.util.Map;

final class JsCheckerErrorFormatter extends AbstractMessageFormatter {

  private static final SourceExcerpt EXCERPT = SourceExcerptProvider.SourceExcerpt.LINE;
  private static final ExcerptFormatter excerptFormatter =
      new LightweightMessageFormatter.LineNumberingFormatter();

  private final List<String> roots;
  private final Map<String, String> labels;
  private boolean colorize;

  JsCheckerErrorFormatter(
      SourceExcerptProvider source,
      List<String> roots,
      Map<String, String> labels) {
    super(source);
    this.roots = roots;
    this.labels = labels;
  }

  @Override
  public String formatError(JSError error) {
    return format(error, false);
  }

  @Override
  public String formatWarning(JSError warning) {
    return format(warning, true);
  }

  @Override
  public void setColorize(boolean colorize) {
    super.setColorize(colorize);
    this.colorize = colorize;
  }

  private String format(JSError error, boolean warning) {
    SourceExcerptProvider source = getSource();
    String sourceName = error.getSourceName();
    int lineNumber = error.getLineNumber();
    int charno = error.getCharno();

    // Format the non-reverse-mapped position.
    StringBuilder b = new StringBuilder();
    StringBuilder boldLine = new StringBuilder();
    String nonMappedPosition = formatPosition(sourceName, lineNumber);

    // Check if we can reverse-map the source.
    OriginalMapping mapping =
        source == null
            ? null
            : source.getSourceMapping(error.getSourceName(), error.getLineNumber(), error.getCharno());
    if (mapping == null) {
      boldLine.append(nonMappedPosition);
    } else {
      sourceName = mapping.getOriginalFile();
      lineNumber = mapping.getLineNumber();
      charno = mapping.getColumnPosition();

      b.append(nonMappedPosition);
      b.append("\nOriginally at:\n");
      boldLine.append(formatPosition(sourceName, lineNumber));
    }

    // extract source excerpt
    String sourceExcerpt = source == null ? null :
        EXCERPT.get(
            source, sourceName, lineNumber, excerptFormatter);

    boldLine.append(getLevelName(warning ? CheckLevel.WARNING : CheckLevel.ERROR));
    boldLine.append(" - ");
    boldLine.append(error.getDescription());

    b.append(maybeEmbolden(boldLine.toString()));

    b.append('\n');
    if (sourceExcerpt != null) {
      b.append(sourceExcerpt);
      b.append('\n');

      // padding equal to the excerpt and arrow at the end
      // charno == sourceExpert.length() means something is missing
      // at the end of the line
      if (0 <= charno && charno <= sourceExcerpt.length()) {
        for (int i = 0; i < charno; i++) {
          char c = sourceExcerpt.charAt(i);
          if (TokenUtil.isWhitespace(c)) {
            b.append(c);
          } else {
            b.append(' ');
          }
        }
        b.append("^\n");
      }
    }

    // Help the user know how to suppress this warning.
    String module = convertPathToModuleName(nullToEmpty(error.getSourceName()), roots).or("");
    String label = labels.get(module);
    if (label == null) {
      if (colorize) {
        b.append("\033[1;34m");
      }
      b.append("  Codes: ");
      if (colorize) {
        b.append("\033[0m");
      }
      b.append(error.getType().key);
      for (String groupName : getGroupSuppressCodes(error)) {
        if (groupName.startsWith("old")) {
          continue;
        }
        b.append(", ");
        b.append(groupName);
      }
      b.append('\n');
    } else {
      b.append("  ");
      if (colorize) {
        b.append("\033[1;34m");
      }
      b.append("ProTip:");
      if (colorize) {
        b.append("\033[0m");
      }
      b.append(" \"");
      b.append(error.getType().key);
      for (String groupName : getGroupSuppressCodes(error)) {
        if (groupName.startsWith("old")) {
          continue;
        }
        b.append("\" or \"");
        b.append(groupName);
      }
      b.append("\" can be added to the `suppress` attribute of:\n  ");
      b.append(label);
      b.append('\n');
      String jsdocSuppress = Diagnostics.JSDOC_SUPPRESS_CODES.get(error.getType());
      if (jsdocSuppress != null) {
        b.append("  Alternatively /** @suppress {");
        b.append(jsdocSuppress);
        b.append("} */ can be added to the source file.\n");
      }
    }

    return b.toString();
  }

  private static ImmutableList<String> getGroupSuppressCodes(JSError error) {
    return Ordering.natural()
        .immutableSortedCopy(Diagnostics.DIAGNOSTIC_GROUPS.get(error.getType()));
  }

  private static String formatPosition(String sourceName, int lineNumber) {
    StringBuilder b = new StringBuilder();
    if (sourceName != null) {
      b.append(sourceName);
      if (lineNumber > 0) {
        b.append(':');
        b.append(lineNumber);
      }
      b.append(": ");
    }
    return b.toString();
  }
}
