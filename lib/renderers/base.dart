import 'dart:math';

import 'package:draft_view/models.dart';
import 'package:draft_view/renderers/text.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

abstract class Renderer {
  InlineSpan render(DraftBlock block);
}

abstract class ListRenderer extends Renderer {
  final TextRenderer textRenderer;
  final int indent;

  final Map<int, int> indentMap = {0: 1};

  ListRenderer(this.textRenderer, this.indent);

  Tuple2<String, int> getIndent(DraftBlock block) {
    int index;
    int maxDepth = indentMap.keys.reduce((value, element) => max(value, element));
    if (block.depth > maxDepth) {
      //depth increased
      indentMap[block.depth] = 1;
    } else if (block.depth < maxDepth) {
      //depth decreased
      indentMap.removeWhere((key, value) => key > block.depth);
    } else {
      //is current depth, no extra operation needed
    }
    index = indentMap[block.depth] ?? 1;
    indentMap[block.depth] = index + 1;
    return Tuple2(" " * indent * block.depth, index);
  }

  void resetIndex() {
    indentMap.clear();
    indentMap[0] = 1;
  }
}
