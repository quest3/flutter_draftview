import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/base.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class OrderedListRenderer extends ListRenderer {
  OrderedListRenderer(super.textRenderer, super.indent);

  @override
  InlineSpan render(DraftBlock block) {
    TextSpan span = textRenderer.render(block) as TextSpan;
    Tuple2<String, int> indentInfo = getIndent(block);
    return WidgetSpan(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${indentInfo.item1}${indentInfo.item2}. ",
          style: textRenderer.style,
        ),
        Expanded(
          child: Text.rich(TextSpan(style: textRenderer.style, children: (span.children == null || span.children!.isEmpty) ? [span] : span.children)),
        ),
      ],
    ));
  }
}

class UnorderedListRenderer extends ListRenderer {
  UnorderedListRenderer(super.textRenderer, super.indent);

  @override
  InlineSpan render(DraftBlock block) {
    TextSpan span = textRenderer.render(block) as TextSpan;
    Tuple2<String, int> indentInfo = getIndent(block);
    return WidgetSpan(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${indentInfo.item1}• ",
          style: textRenderer.style,
        ),
        Expanded(
          child: Text.rich(TextSpan(style: textRenderer.style, children: (span.children == null || span.children!.isEmpty) ? [span] : span.children)),
        ),
      ],
    ));
  }
}
