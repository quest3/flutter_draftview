import 'package:draft_view/models.dart';
import 'package:flutter/material.dart';

import 'renderers.dart';

class ImageRenderer extends Renderer {
  final TextRenderer _textRenderer;
  final Widget Function(String)? imageBuilder;
  final Function(String url)? onTapImage;
  ImageRenderer(
    this._textRenderer, {
    this.imageBuilder,
    this.onTapImage,
  });

  @override
  InlineSpan render(DraftBlock block) {
    String? url;
    url = block.entityRanges.first.data?.data['src'];
    if (url?.isNotEmpty ?? false) {
      Widget widget;
      if (imageBuilder != null) {
        widget = imageBuilder!(url!);
      } else {
        widget = Image.network(
          url!,
          fit: BoxFit.fitWidth,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200,
              color: Colors.grey.withOpacity(0.4),
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        );
      }
      if (onTapImage != null) {
        return WidgetSpan(
          child: GestureDetector(
            onTap: () => onTapImage!(url!),
            child: widget,
          ),
        );
      }
      return WidgetSpan(child: widget);
    }
    return _textRenderer.render(block);
  }
}
