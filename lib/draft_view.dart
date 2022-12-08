import 'dart:math';

import 'package:draft_view/models.dart';
import 'package:draft_view/theme.dart';
import 'package:flutter/material.dart';

class DraftView extends StatelessWidget {
  static const URL_REGEX =
      r"((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[.\!\/\\w]*))?)";
  static const MENTION_REGEX = r"(^|\s)@([0-9a-zA-Z._]+)";
  static const TAG_REGEX = r"(^|\s)#([0-9a-zA-Z]+)";

  ///Root span. All rendered spans will be this span's children
  late final InlineSpan _rootSpan;

  ///Input json data
  final Map<String, dynamic> rawDraftData;

  ///Theme
  final DraftViewTheme draftViewTheme;

  late final Renderers _renderers;

  DraftView({
    Key? key,
    required BuildContext context,
    required this.rawDraftData,
    required this.draftViewTheme,
    Function(Map<String, dynamic> data)? onTapLink,
    Function(String url)? onTapImage,
    Widget Function(String url)? customImageWidget,
    WidgetSpan Function(InlineSpan span)? customBlockQuoteWidget,
    WidgetSpan Function(InlineSpan span)? customCodeBlockWidget,
  }) : super(key: key) {
    _renderers = draftViewTheme.buildRenderers(
      context: context,
      onTapLink: onTapLink,
      onTapImage: onTapImage,
      customImageWidget: customImageWidget,
      customBlockQuoteWidget: customBlockQuoteWidget,
      customCodeBlockWidget: customCodeBlockWidget,
    );
    _rootSpan = TextSpan(children: _generateSpans());
  }

  List<InlineSpan> _generateSpans() {
    List<InlineSpan> result = [];
    DraftTree draftNode = DraftTree.fromJson(rawDraftData);
    _recognizePlainUrls(draftNode);
    _recognizeMentionAndTags(draftNode);
    result.addAll(draftNode.blocks
        .map((e) {
          //insert new line between blocks
          return [_renderBlock(e), _newlineSpan()];
        })
        .expand((element) => element)
        .toList());
    if (result.isNotEmpty) {
      //remove last empty line if needed
      result.removeLast();
    }
    return result;
  }

  void _recognizePlainUrls(DraftTree draftNode) {
    List<DraftBlock> blocks = draftNode.blocks;
    Map<String, EntityData> entityMap = draftNode.entityMap;
    int maxKey = entityMap.keys.isEmpty ? 0 : entityMap.keys.map((e) => int.tryParse(e)).whereType<int>().reduce((value, element) => max(value, element));
    int newKey = maxKey + 1;
    for (DraftBlock block in blocks) {
      var allMatches = RegExp(URL_REGEX).allMatches(block.text);
      for (RegExpMatch match in allMatches) {
        int start = match.start;
        int end = match.end;
        bool exist = false;
        for (Entity entity in block.entityRanges) {
          if (entity.offset == start && entity.offset + entity.length == end) {
            exist = true;
            break;
          }
        }
        if (!exist) {
          Entity entity = Entity(match.start, match.end - match.start, newKey);
          entity.data = EntityData("LINK", "MUTABLE", {'url': match.input.substring(match.start, match.end)});
          block.entityRanges.add(entity);
          newKey++;
        }
      }
    }
  }

  void _recognizeMentionAndTags(DraftTree draftNode) {
    List<DraftBlock> blocks = draftNode.blocks;
    List<RegExp> regs = [RegExp(MENTION_REGEX), RegExp(TAG_REGEX)];
    for (DraftBlock block in blocks) {
      for (var reg in regs) {
        Iterable<RegExpMatch> allMatches = reg.allMatches(block.text);
        for (RegExpMatch match in allMatches) {
          // block.inlineStyleRanges.add(InlineStyle(match.start, match.end - match.start, "BOLD"));
          block.inlineStyleRanges.add(InlineStyle(match.start, match.end - match.start, "HIGHLIGHTED"));
        }
      }
    }
  }

  InlineSpan _renderBlock(DraftBlock e) {
    InlineSpan span;
    switch (e.type) {
      case BlockType.atomic:
        {
          if (e.entityRanges.isNotEmpty) {
            EntityData? entityData = e.entityRanges.first.data;
            if (entityData != null) {
              switch (entityData.type.toLowerCase()) {
                case "image":
                  {
                    span = _renderers.imageRenderer.render(e);
                    break;
                  }
                //other types
                default:
                  {
                    span = _renderers.textRenderer.render(e);
                    break;
                  }
              }
            } else {
              span = _renderers.textRenderer.render(e);
            }
          } else {
            span = _renderers.textRenderer.render(e);
          }
          break;
        }
      case BlockType.ordered_list_item:
        {
          span = _renderers.orderedListRenderer.render(e);
          // _orderedListRenderer.index++;
          break;
        }
      case BlockType.unordered_list_item:
        {
          span = _renderers.unorderedListRenderer.render(e);
          break;
        }
      case BlockType.blockquote:
        {
          span = _renderers.blockQuoteRenderer.render(e);
          break;
        }
      case BlockType.code_block:
        {
          span = _renderers.codeBlockRenderer.render(e);
          break;
        }
      case BlockType.header1:
        {
          span = _renderers.h1Renderer.render(e);
          break;
        }
      case BlockType.header2:
        {
          span = _renderers.h2Renderer.render(e);
          break;
        }
      case BlockType.header3:
        {
          span = _renderers.h3Renderer.render(e);
          break;
        }
      case BlockType.header4:
        {
          span = _renderers.h4Renderer.render(e);
          break;
        }
      case BlockType.header5:
        {
          span = _renderers.h5Renderer.render(e);
          break;
        }
      case BlockType.header6:
        {
          span = _renderers.h6Renderer.render(e);
          break;
        }
      case BlockType.unknown:
        {
          span = _renderers.textRenderer.render(DraftBlock("key", "<unknown>", "", 0, [], []));
          break;
        }
      case BlockType.unstyled:
      case BlockType.paragraph:
      default:
        {
          span = _renderers.textRenderer.render(e);
          break;
        }
    }
    if (e.type != BlockType.ordered_list_item) {
      _renderers.orderedListRenderer.resetIndex();
    }
    return span;
  }

  InlineSpan _newlineSpan() {
    return TextSpan(text: "\n", style: draftViewTheme.textStyle);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _rootSpan,
    );
  }
}
