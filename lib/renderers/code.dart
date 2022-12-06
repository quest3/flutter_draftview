import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/base.dart';
import 'package:draft_renderer/renderers/text.dart';
import 'package:flutter/material.dart';

class CodeBlockRenderer extends Renderer {
  late final TextRenderer _textRenderer;
  final TextStyle style;
  final WidgetSpan Function(InlineSpan span)? customCodeBlockWidget;

  CodeBlockRenderer(this.style, {this.customCodeBlockWidget}) {
    _textRenderer = TextRenderer(style, style);
  }

  @override
  InlineSpan render(DraftBlock block) {
    if (customCodeBlockWidget != null) {
      return customCodeBlockWidget!(_textRenderer.render(block));
    } else {
      return WidgetSpan(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200, border: Border.all(color: Colors.grey.shade300, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: RichText(text: _textRenderer.render(block)),
      ));
    }
  }
}
