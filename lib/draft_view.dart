import 'dart:math';

import 'package:draft_view/models.dart';
import 'package:draft_view/renderers/atomic.dart';
import 'package:draft_view/renderers/code.dart';
import 'package:draft_view/renderers/list.dart';
import 'package:draft_view/renderers/quote.dart';
import 'package:draft_view/renderers/text.dart';
import 'package:flutter/material.dart';

class DraftView extends StatelessWidget {
  static const URL_REGEX =
      r"((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[.\!\/\\w]*))?)";
  static const MENTION_REGEX = r"(^|\s)@([0-9a-zA-Z._]+)";

  ///Root span. All rendered spans will be this span's children
  late final InlineSpan _rootSpan;

  ///Input json data
  final Map<String, dynamic> rawDraftData;

  ///Theme data. TextStyle bodyText1 and  headline1 ~ headline6 must be set
  late final ThemeData themeData;

  ///Text style for code block
  final TextStyle? codeStyle;

  ///Links' color. Leave null to be same color as textStyle
  final Color? linkColor;

  ///Amount of spaces for one indent, default 4
  final int indent;

  ///Text style for ordered-list-item
  final TextStyle? orderedListItemStyle;

  ///Text style for unordered-list-item
  final TextStyle? unorderedListItemStyle;

  ///Text style for blockquote
  final TextStyle? blockquoteStyle;

  ///Callback for tapping link
  final Function(Map<String, dynamic> data)? onTapLink;

  ///Callback for tapping image
  final Function(String url)? onTapImage;

  ///Customized function to create widget for image
  final Widget Function(String url)? customImageWidget;

  ///Customized function to create widget for blockquote
  final WidgetSpan Function(InlineSpan span)? customBlockQuoteWidget;

  ///Customized function to create widget for code-block
  final WidgetSpan Function(InlineSpan span)? customCodeBlockWidget;

  late final TextRenderer _textRenderer;
  late final TextRenderer _h1Renderer;
  late final TextRenderer _h2Renderer;
  late final TextRenderer _h3Renderer;
  late final TextRenderer _h4Renderer;
  late final TextRenderer _h5Renderer;
  late final TextRenderer _h6Renderer;
  late final CodeBlockRenderer _codeBlockRenderer;
  late final OrderedListRenderer _orderedListRenderer;
  late final UnorderedListRenderer _unorderedListRenderer;
  late final BlockQuoteRenderer _blockQuoteRenderer;
  late final ImageRenderer _imageRenderer;

  DraftView(
      {Key? key,
      required BuildContext context,
      required this.rawDraftData,
      ThemeData? themeData,
      this.codeStyle,
      this.linkColor,
      this.indent = 4,
      this.orderedListItemStyle,
      this.unorderedListItemStyle,
      this.blockquoteStyle,
      this.onTapLink,
      this.onTapImage,
      this.customImageWidget,
      this.customBlockQuoteWidget,
      this.customCodeBlockWidget})
      : super(key: key) {
    this.themeData = themeData ?? Theme.of(context);
    TextTheme textTheme = this.themeData.textTheme;
    TextStyle textStyle = textTheme.bodyText1!;
    _textRenderer = TextRenderer(textStyle, textStyle.copyWith(color: linkColor), onTapLink: onTapLink);
    _codeBlockRenderer = CodeBlockRenderer(codeStyle ?? textStyle);
    _h1Renderer = TextRenderer(textTheme.headline1!, textTheme.headline1!.copyWith(color: linkColor));
    _h2Renderer = TextRenderer(textTheme.headline2!, textTheme.headline2!.copyWith(color: linkColor));
    _h3Renderer = TextRenderer(textTheme.headline3!, textTheme.headline3!.copyWith(color: linkColor));
    _h4Renderer = TextRenderer(textTheme.headline4!, textTheme.headline4!.copyWith(color: linkColor));
    _h5Renderer = TextRenderer(textTheme.headline5!, textTheme.headline5!.copyWith(color: linkColor));
    _h6Renderer = TextRenderer(textTheme.headline6!, textTheme.headline6!.copyWith(color: linkColor));
    _orderedListRenderer = OrderedListRenderer(_textRenderer, indent);
    _unorderedListRenderer = UnorderedListRenderer(_textRenderer, indent);
    _blockQuoteRenderer = BlockQuoteRenderer(context, _textRenderer, customBlockQuoteWidget: customBlockQuoteWidget);
    _imageRenderer = ImageRenderer(_textRenderer, onTapImage: onTapImage, customImageWidget: customImageWidget);

    _rootSpan = TextSpan(children: _generateSpans());
  }

  List<InlineSpan> _generateSpans() {
    List<InlineSpan> result = [];
    DraftTree draftNode = DraftTree.fromJson(rawDraftData);
    _recognizePlainUrls(draftNode);
    _recognizeMentions(draftNode);
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

  void _recognizeMentions(DraftTree draftNode) {
    List<DraftBlock> blocks = draftNode.blocks;
    for (DraftBlock block in blocks) {
      Iterable<RegExpMatch> allMatches = RegExp(MENTION_REGEX).allMatches(block.text);
      for (RegExpMatch match in allMatches) {
        block.inlineStyleRanges.add(InlineStyle(match.start, match.end - match.start, "BOLD"));
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
                    span = _imageRenderer.render(e);
                    break;
                  }
                //other types
                default:
                  {
                    span = _textRenderer.render(e);
                    break;
                  }
              }
            } else {
              span = _textRenderer.render(e);
            }
          } else {
            span = _textRenderer.render(e);
          }
          break;
        }
      case BlockType.ordered_list_item:
        {
          span = _orderedListRenderer.render(e);
          // _orderedListRenderer.index++;
          break;
        }
      case BlockType.unordered_list_item:
        {
          span = _unorderedListRenderer.render(e);
          break;
        }
      case BlockType.blockquote:
        {
          span = _blockQuoteRenderer.render(e);
          break;
        }
      case BlockType.code_block:
        {
          span = _codeBlockRenderer.render(e);
          break;
        }
      case BlockType.header1:
        {
          span = _h1Renderer.render(e);
          break;
        }
      case BlockType.header2:
        {
          span = _h2Renderer.render(e);
          break;
        }
      case BlockType.header3:
        {
          span = _h3Renderer.render(e);
          break;
        }
      case BlockType.header4:
        {
          span = _h4Renderer.render(e);
          break;
        }
      case BlockType.header5:
        {
          span = _h5Renderer.render(e);
          break;
        }
      case BlockType.header6:
        {
          span = _h6Renderer.render(e);
          break;
        }
      case BlockType.unknown:
        {
          span = _textRenderer.render(DraftBlock("key", "<unknown>", "", 0, [], []));
          break;
        }
      case BlockType.unstyled:
      case BlockType.paragraph:
      default:
        {
          span = _textRenderer.render(e);
          break;
        }
    }
    if (e.type != BlockType.ordered_list_item) {
      _orderedListRenderer.resetIndex();
    }
    return span;
  }

  InlineSpan _newlineSpan() {
    return TextSpan(text: "\n", style: themeData.textTheme.bodyText1);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _rootSpan,
    );
  }
}
