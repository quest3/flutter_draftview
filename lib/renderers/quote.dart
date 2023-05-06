import 'package:draft_view/models.dart';
import 'package:flutter/material.dart';

import 'renderers.dart';

class BlockQuoteRenderer extends Renderer {
  final TextRenderer _textRenderer;
  final BuildContext _context;
  final WidgetSpan Function(InlineSpan span)? blockquoteBuilder;
  BlockQuoteRenderer(
    this._context,
    this._textRenderer, {
    this.blockquoteBuilder,
  });

  @override
  InlineSpan render(DraftBlock block) {
    if (blockquoteBuilder != null) {
      return blockquoteBuilder!(_textRenderer.render(block));
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
            child: RichText(text: _textRenderer.render(block)),
          ),
        ),
      );
    }
  }
}
