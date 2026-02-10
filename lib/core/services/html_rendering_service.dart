import 'package:flutter/widgets.dart';

/// HTML Rendering Service
///
/// Abstraction for rendering HTML content as Flutter widgets.
/// This allows swapping the underlying HTML engine (e.g. flutter_html,
/// flutter_widget_from_html) without modifying UI code.
///
/// Usage:
/// ```dart
/// final htmlService = getIt<HtmlRenderingService>();
/// final widget = htmlService.renderHtml('<h1>Hello</h1>');
/// ```
abstract class HtmlRenderingService {
  /// Render an HTML string as a Flutter widget.
  ///
  /// [html] - Raw HTML content string (may contain Base64 images).
  /// [isExpanded] - If false, truncates to a short preview. If true, renders full content.
  /// [textStyle] - Optional base text style for the rendered content.
  Widget renderHtml(
    String html, {
    bool isExpanded = true,
    TextStyle? textStyle,
  });
}
