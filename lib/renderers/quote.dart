import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/base.dart';
import 'package:draft_renderer/renderers/text.dart';
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
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 10, color: Theme.of(_context).primaryColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: _textRenderer.render(block),
            ),
          ),
        ),
      );
    }
  }
}
