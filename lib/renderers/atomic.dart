import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/base.dart';
import 'package:draft_renderer/renderers/text.dart';
import 'package:flutter/material.dart';

class ImageRenderer extends Renderer {
  final TextRenderer _textRenderer;
  final Widget Function(String)? customImageWidget;
  final Function(String url)? onTapImage;

  ImageRenderer(this._textRenderer, {this.customImageWidget, this.onTapImage});

  @override
  InlineSpan render(DraftBlock block) {
    String? url;
    url = block.entityRanges.first.data?.data['src'];
    if (url != null) {
      Widget widget;
      if (customImageWidget != null) {
        widget = customImageWidget!(url);
      } else {
        widget = Image.network(
          url,
          fit: BoxFit.fitWidth,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200,
              color: Colors.grey.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }
      if (onTapImage != null) {
        return WidgetSpan(
            child: GestureDetector(
          onTap: () {
            onTapImage!(url!);
          },
          child: widget,
        ));
      } else {
        return WidgetSpan(child: widget);
      }
    } else {
      return _textRenderer.render(block);
    }
  }
}
