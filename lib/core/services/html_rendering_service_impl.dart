import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:happyco/core/services/html_rendering_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Concrete implementation of [HtmlRenderingService] using
/// `flutter_widget_from_html_core`.
///
/// Both collapsed and expanded states render via [HtmlWidget] to maintain
/// consistent typography and styling. Collapsed mode truncates the raw HTML
/// to the first block element + a short snippet of the second.
class HtmlRenderingServiceImpl implements HtmlRenderingService {
  @override
  Widget renderHtml(
    String html, {
    bool isExpanded = true,
    TextStyle? textStyle,
  }) {
    if (html.isEmpty) {
      return const SizedBox.shrink();
    }

    final baseStyle = textStyle ??
        TextStyle(
          fontSize: UISizes.font.sp14,
          color: UIColors.gray700,
          fontFamily: UIFonts.gilroy,
          height: 1.6,
        );

    final content = isExpanded ? html : _truncateHtml(html);

    return HtmlWidget(
      content,
      renderMode: RenderMode.column,
      textStyle: baseStyle,
    );
  }

  /// Truncate HTML: keep first block element intact, take ~9 visible chars
  /// from the second block, append "..."
  ///
  /// Example input:  <h1>TITLE</h1><p>Long paragraph...</p><h2>...</h2>
  /// Example output: <h1>TITLE</h1><p>Long para...</p>
  String _truncateHtml(String html) {
    // Split on block-level closing tags to find natural break points
    final blockPattern = RegExp(
      r'(<\/(?:h[1-6]|p|div|li|ul|ol|tr)>)',
      caseSensitive: false,
    );

    final matches = blockPattern.allMatches(html).toList();
    if (matches.isEmpty) {
      // No block tags — fallback: strip tags, truncate plain text
      final plain = html.replaceAll(RegExp(r'<[^>]+>'), '').trim();
      if (plain.length <= 50) return html;
      return '<p>${plain.substring(0, 50)}...</p>';
    }

    // Take everything up to end of first block
    final firstBlockEnd = matches.first.end;
    final firstBlock = html.substring(0, firstBlockEnd);

    if (matches.length < 2) return firstBlock;

    // From second block: extract visible text, take ~9 chars
    final secondBlockStart = firstBlockEnd;
    final secondBlockEnd = matches[1].end;
    final secondBlockHtml = html.substring(secondBlockStart, secondBlockEnd);
    final secondBlockText =
        secondBlockHtml.replaceAll(RegExp(r'<[^>]+>'), '').trim();

    if (secondBlockText.isEmpty) return firstBlock;

    final snippetLength =
        secondBlockText.length < 9 ? secondBlockText.length : 9;
    final snippet = secondBlockText.substring(0, snippetLength);

    return '$firstBlock<p>$snippet...</p>';
  }
}
