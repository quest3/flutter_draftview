import 'dart:math';

import 'package:draft_renderer/models.dart';
import 'package:draft_renderer/renderers/atomic.dart';
import 'package:draft_renderer/renderers/code.dart';
import 'package:draft_renderer/renderers/list.dart';
import 'package:draft_renderer/renderers/quote.dart';
import 'package:draft_renderer/renderers/text.dart';
import 'package:flutter/material.dart';

class DraftWidget extends StatelessWidget {
  static const URL_REGEX =
      r"((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[.\!\/\\w]*))?)";

  ///Root span. All rendered spans will be this span's children
  late final InlineSpan _rootSpan;

  ///Input json data
  final Map<String, dynamic> rawDraftData;

  ///Default text style
  final TextStyle? textStyle;

  ///Text style for code block
  final TextStyle? codeStyle;

  ///Links' color. Leave null to be same color as textStyle
  final Color? linkColor;

  ///Amount of spaces for one indent, default 4
  final int indent;

  ///Text style for header-one
  final TextStyle? h1Style;

  ///Text style for header-two
  final TextStyle? h2Style;

  ///Text style for header-three
  final TextStyle? h3Style;

  ///Text style for header-four
  final TextStyle? h4Style;

  ///Text style for header-five
  final TextStyle? h5Style;

  ///Text style for header-six
  final TextStyle? h6Style;

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

  DraftWidget(
      {Key? key,
      required BuildContext context,
      required this.rawDraftData,
      this.textStyle,
      this.codeStyle,
      this.linkColor,
      this.indent = 4,
      this.h1Style,
      this.h2Style,
      this.h3Style,
      this.h4Style,
      this.h5Style,
      this.h6Style,
      this.orderedListItemStyle,
      this.unorderedListItemStyle,
      this.blockquoteStyle,
      this.onTapLink,
      this.onTapImage,
      this.customImageWidget,
      this.customBlockQuoteWidget,
      this.customCodeBlockWidget})
      : super(key: key) {
    TextTheme textTheme = Theme.of(context).textTheme;
    _textRenderer = TextRenderer(textStyle ?? textTheme.bodyText1!, (textStyle ?? textTheme.bodyText1!).copyWith(color: linkColor), onTapLink: onTapLink);
    _codeBlockRenderer = CodeBlockRenderer(codeStyle ?? textTheme.bodyText1!);
    _h1Renderer = TextRenderer(h1Style ?? textTheme.headline1!, (h1Style ?? textTheme.headline1!).copyWith(color: linkColor));
    _h2Renderer = TextRenderer(h2Style ?? textTheme.headline2!, (h2Style ?? textTheme.headline2!).copyWith(color: linkColor));
    _h3Renderer = TextRenderer(h3Style ?? textTheme.headline3!, (h3Style ?? textTheme.headline3!).copyWith(color: linkColor));
    _h4Renderer = TextRenderer(h4Style ?? textTheme.headline4!, (h4Style ?? textTheme.headline4!).copyWith(color: linkColor));
    _h5Renderer = TextRenderer(h5Style ?? textTheme.headline5!, (h5Style ?? textTheme.headline5!).copyWith(color: linkColor));
    _h6Renderer = TextRenderer(h6Style ?? textTheme.headline6!, (h6Style ?? textTheme.headline6!).copyWith(color: linkColor));
    _orderedListRenderer = OrderedListRenderer(_textRenderer, indent);
    _unorderedListRenderer = UnorderedListRenderer(_textRenderer, indent);
    _blockQuoteRenderer = BlockQuoteRenderer(context, _textRenderer, customBlockQuoteWidget: customBlockQuoteWidget);
    _imageRenderer = ImageRenderer(_textRenderer, onTapImage: onTapImage, customImageWidget: customImageWidget);

    _rootSpan = TextSpan(children: _generateSpans());
  }

  List<InlineSpan> _generateSpans() {
    List<InlineSpan> result = [];
    DraftTree draftNode = DraftTree.fromJson(rawDraftData);
    _recognizePlainLinks(draftNode);
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

  void _recognizePlainLinks(DraftTree draftNode) {
    List<DraftBlock> blocks = draftNode.blocks;
    Map<String, EntityData> entityMap = draftNode.entityMap;
    int maxKey = entityMap.keys.map((e) => int.tryParse(e)).whereType<int>().reduce((value, element) => max(value, element));
    int newKey = maxKey + 1;
    RegExp reg = RegExp(URL_REGEX);
    for (var block in blocks) {
      var allMatches = reg.allMatches(block.text);
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
          Entity entity = Entity(start, end - start, newKey);
          entity.data = EntityData("LINK", "MUTABLE", {'url': match.input.substring(match.start, match.end)});
          block.entityRanges.add(entity);
          newKey++;
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
    return TextSpan(text: "\n", style: textStyle);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _rootSpan,
    );
  }
}
