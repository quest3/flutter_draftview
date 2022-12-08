import 'package:draft_view/renderers/atomic.dart';
import 'package:draft_view/renderers/code.dart';
import 'package:draft_view/renderers/list.dart';
import 'package:draft_view/renderers/quote.dart';
import 'package:draft_view/renderers/text.dart';
import 'package:flutter/material.dart';

class DraftViewTheme {
  ///Default text style
  final TextStyle? textStyle;

  ///Bold style
  final TextStyle? boldStyle;

  ///Italic style
  final TextStyle? italicStyle;

  ///Highlighted style for mention and hashtag
  final TextStyle? highlightedStyle;

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

  const DraftViewTheme({
    this.textStyle,
    this.boldStyle,
    this.italicStyle,
    this.highlightedStyle,
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
  });

  Renderers buildRenderers({
    required BuildContext context,
    Function(String url, Map<String, dynamic> data)? onTapLink,
    Function(String url)? onTapImage,
    Widget Function(String url)? imageBuilder,
    WidgetSpan Function(InlineSpan span)? blockquoteBuilder,
    WidgetSpan Function(InlineSpan span)? codeBlockBuilder,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Renderers renderers = Renderers();
    renderers.textRenderer = buildTextRenderer(baseStyle: textStyle ?? textTheme.bodyText1!, onTapLink: onTapLink);
    renderers.codeBlockRenderer = CodeBlockRenderer(buildTextRenderer(baseStyle: codeStyle ?? textTheme.bodyText1!), codeBlockBuilder: codeBlockBuilder);
    renderers.h1Renderer = buildTextRenderer(baseStyle: h1Style ?? textTheme.headline1!, onTapLink: onTapLink);
    renderers.h2Renderer = buildTextRenderer(baseStyle: h2Style ?? textTheme.headline2!, onTapLink: onTapLink);
    renderers.h3Renderer = buildTextRenderer(baseStyle: h3Style ?? textTheme.headline3!, onTapLink: onTapLink);
    renderers.h4Renderer = buildTextRenderer(baseStyle: h4Style ?? textTheme.headline4!, onTapLink: onTapLink);
    renderers.h5Renderer = buildTextRenderer(baseStyle: h5Style ?? textTheme.headline5!, onTapLink: onTapLink);
    renderers.h6Renderer = buildTextRenderer(baseStyle: h6Style ?? textTheme.headline6!, onTapLink: onTapLink);
    renderers.orderedListRenderer = OrderedListRenderer(
        orderedListItemStyle == null ? renderers.textRenderer : buildTextRenderer(baseStyle: orderedListItemStyle!, onTapLink: onTapLink), indent);
    renderers.unorderedListRenderer = UnorderedListRenderer(
        unorderedListItemStyle == null ? renderers.textRenderer : buildTextRenderer(baseStyle: unorderedListItemStyle!, onTapLink: onTapLink), indent);
    renderers.blockQuoteRenderer = BlockQuoteRenderer(
        context, blockquoteStyle == null ? renderers.textRenderer : buildTextRenderer(baseStyle: blockquoteStyle!, onTapLink: onTapLink),
        blockquoteBuilder: blockquoteBuilder);
    renderers.imageRenderer = ImageRenderer(renderers.textRenderer, onTapImage: onTapImage, imageBuilder: imageBuilder);
    return renderers;
  }

  TextRenderer buildTextRenderer({required TextStyle baseStyle, Function(String url, Map<String, dynamic> data)? onTapLink}) {
    TextStyle boldStyle2 = boldStyle ?? baseStyle.copyWith(fontWeight: FontWeight.bold);
    TextStyle italicStyle2 = italicStyle ?? baseStyle.copyWith(fontStyle: FontStyle.italic);
    TextStyle highlightedStyle2 = highlightedStyle ?? boldStyle2;
    return TextRenderer(
        defaultStyle: baseStyle,
        boldStyle: boldStyle2,
        italicStyle: italicStyle2,
        highlightedStyle: highlightedStyle2,
        linkStyle: baseStyle.copyWith(color: linkColor),
        onTapLink: onTapLink);
  }
}

class Renderers {
  late final TextRenderer textRenderer;
  late final TextRenderer h1Renderer;
  late final TextRenderer h2Renderer;
  late final TextRenderer h3Renderer;
  late final TextRenderer h4Renderer;
  late final TextRenderer h5Renderer;
  late final TextRenderer h6Renderer;
  late final CodeBlockRenderer codeBlockRenderer;
  late final OrderedListRenderer orderedListRenderer;
  late final UnorderedListRenderer unorderedListRenderer;
  late final BlockQuoteRenderer blockQuoteRenderer;
  late final ImageRenderer imageRenderer;
}
