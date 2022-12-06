import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/base.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRenderer extends Renderer {
  final TextStyle style;
  final TextStyle linkStyle;
  final Function(Map<String, dynamic> data)? onTapLink;

  TextRenderer(this.style, this.linkStyle, {this.onTapLink});

  @override
  InlineSpan render(DraftBlock block) {
    if (block.inlineStyleRanges.isEmpty && block.entityRanges.isEmpty) {
      return TextSpan(text: block.text, style: style);
    } else {
      List<SplitBlock> blocks = [SplitBlock(block, 0, block.text.length, style)];
      //must apply entity data (ex. links) first so inline style can be combined with link style
      _split(
          blocks,
          block.entityRanges
              .map((entity) => SplitOperation(offset: entity.offset, length: entity.length, proceed: (block) => _applyEntity(block, entity)))
              .toList());
      _split(
          blocks,
          block.inlineStyleRanges
              .map((inlineStyle) => SplitOperation(offset: inlineStyle.offset, length: inlineStyle.length, proceed: (block) => _applyStyle(block, inlineStyle)))
              .toList());

      TextSpan textSpan = TextSpan(
          children: blocks.map((e) {
        TapGestureRecognizer? recognizer = e.tapData == null
            ? null
            : (TapGestureRecognizer()
              ..onTap = () {
                if (onTapLink != null) {
                  onTapLink!(e.tapData!);
                }
              });
        return TextSpan(text: e.text, style: e.style, recognizer: recognizer);
      }).toList());
      Widget? alignWidget;
      if (block.inlineStyleRanges.where((e) => e.style.toLowerCase() == 'left').isNotEmpty) {
        alignWidget = Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(textSpan),
        );
      } else if (block.inlineStyleRanges.where((e) => e.style.toLowerCase() == 'right').isNotEmpty) {
        alignWidget = Align(
          alignment: Alignment.centerRight,
          child: Text.rich(textSpan),
        );
      } else if (block.inlineStyleRanges.where((e) => e.style.toLowerCase() == 'center').isNotEmpty) {
        alignWidget = Align(
          alignment: Alignment.center,
          child: Text.rich(textSpan),
        );
      }
      if (alignWidget != null) {
        return WidgetSpan(child: alignWidget);
      } else {
        return textSpan;
      }
    }
  }

  void _split(List<SplitBlock> blocks, List<SplitOperation> operations) {
    for (SplitOperation operation in operations) {
      int start = operation.offset;
      int end = start + operation.length;
      for (int i = 0; i < blocks.length; i++) {
        SplitBlock block = blocks[i];
        if (start <= block.start && end >= block.end) {
          //cover
          operation.proceed(block);
          // _applyStyle(block, operation);
        } else if (end <= block.start || start >= block.end) {
          //missed, do nothing
        } else {
          //split
          //from where the block should be split
          List<int> splitPoints = [start, end].where((element) => element < block.end && element > block.start).toList();
          splitPoints = [...splitPoints, block.end];
          int lastPartEnd = block.start;
          List<SplitBlock> newBlocks = [];
          for (int point in splitPoints) {
            //cut off a new segment
            // debugPrint("splitBlock lastPartEnd=$lastPartEnd point=$point ");
            SplitBlock splitBlock = SplitBlock(block.block, lastPartEnd, point, block.style);
            if (lastPartEnd >= start && point <= end) {
              operation.proceed(splitBlock);
              // _applyStyle(splitBlock, operation);
            }
            newBlocks.add(splitBlock);
            lastPartEnd = point;
          }
          //replace old block with new split blocks
          blocks.replaceRange(i, i + 1, newBlocks);
          //search from next old block
          i += newBlocks.length - 1;
        }
      }
    }
  }

  void _applyEntity(SplitBlock block, Entity entity) {
    EntityData? data = entity.data;
    if (data != null) {
      String type = data.type.toLowerCase();
      if (type == "link") {
        block.style = linkStyle.copyWith(decoration: TextDecoration.underline);
        block.tapData = data.data;
      }
    }
  }

  void _applyStyle(SplitBlock block, InlineStyle inlineStyle) {
    String styleString = inlineStyle.style.toLowerCase();
    switch (styleString) {
      case "underline":
        {
          block.style = block.style.copyWith(decoration: TextDecoration.underline);
          break;
        }
      case "italic":
        {
          block.style = block.style.copyWith(fontStyle: FontStyle.italic);
          break;
        }
      case "bold":
        {
          block.style = block.style.copyWith(fontWeight: FontWeight.bold);
          break;
        }
    }
  }
}

///blocks split from draft-js blocks
class SplitBlock {
  ///original block
  DraftBlock block;

  ///start index in original block
  int start;

  ///end index in original block
  int end;

  ///text for this split block
  late String text;

  ///text style for this split block
  TextStyle style;

  ///data for gesture
  Map<String, dynamic>? tapData;

  SplitBlock(
    this.block,
    this.start,
    this.end,
    this.style,
  ) {
    text = block.text.substring(start, end);
  }
}

///describe operation in splitting blocks
class SplitOperation {
  ///inline style or entity index
  final int offset;

  ///inline style or entity length
  final int length;

  ///what to do when split
  final Function(SplitBlock) proceed;

  SplitOperation({required this.offset, required this.length, required this.proceed});
}
