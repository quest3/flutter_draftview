import 'package:draft_view/models.dart';
import 'package:draft_view/renderers/base.dart';
import 'package:draft_view/renderers/text.dart';
import 'package:flutter/material.dart';

class BlockQuoteRenderer extends Renderer {
  final TextRenderer _textRenderer;
  final BuildContext _context;
  final WidgetSpan Function(InlineSpan span)? customBlockQuoteWidget;

  BlockQuoteRenderer(this._context, this._textRenderer, {this.customBlockQuoteWidget});

  @override
  InlineSpan render(DraftBlock block) {
    if (customBlockQuoteWidget != null) {
      return customBlockQuoteWidget!(_textRenderer.render(block));
    } else {
      return WidgetSpan(
        child: Container(
          width: MediaQuery.of(_context).size.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: Color(0xFFCAFF04)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: RichText(
              text: _textRenderer.render(block),
            ),
          ),
        ),
      );
    }
  }
}
