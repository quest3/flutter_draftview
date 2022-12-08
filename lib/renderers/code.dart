import 'package:draft_view/models.dart';
import 'package:draft_view/renderers/base.dart';
import 'package:draft_view/renderers/text.dart';
import 'package:flutter/material.dart';

class CodeBlockRenderer extends Renderer {
  final TextRenderer _textRenderer;
  final WidgetSpan Function(InlineSpan span)? codeBlockBuilder;

  CodeBlockRenderer(this._textRenderer, {this.codeBlockBuilder});

  @override
  InlineSpan render(DraftBlock block) {
    if (codeBlockBuilder != null) {
      return codeBlockBuilder!(_textRenderer.render(block));
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
