import 'package:flutter/material.dart';

import 'renderers/renderers.dart';

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

  DraftViewTheme get draftTheme {
    const double lineHeight = 1.35;
    const bigStyle = TextStyle(
      fontSize: 17,
      height: lineHeight,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    );
    const bold20 = TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      height: lineHeight,
    );
    const bold15 = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      height: lineHeight,
    );
    const medium15 = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      height: lineHeight,
    );
    const regular15 = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      height: lineHeight,
    );

    return DraftViewTheme(
      textStyle: textStyle ?? medium15,
      boldStyle: boldStyle ?? bold15,
      italicStyle:
          italicStyle ?? medium15.copyWith(fontStyle: FontStyle.italic),
      highlightedStyle: highlightedStyle ?? bold15,
      codeStyle: codeStyle ?? regular15,
      linkColor: linkColor ?? Colors.black,
      indent: indent,
      h1Style: h1Style ?? bold20,
      h2Style: h2Style ?? bigStyle,
      h3Style: h3Style ?? bigStyle,
      h4Style: h4Style ?? bigStyle,
      h5Style: h5Style ?? bigStyle,
      h6Style: h6Style ?? bigStyle,
      orderedListItemStyle: orderedListItemStyle,
      unorderedListItemStyle: unorderedListItemStyle,
      blockquoteStyle:
          blockquoteStyle ?? regular15.copyWith(fontStyle: FontStyle.italic),
    );
  }

  static TextRenderer textRenderer(
    DraftViewTheme theme, {
    TextStyle? baseStyle,
    bool replace = true,
    Function(String url, Map<String, dynamic> data)? onTapLink,
  }) {
    final textStyle = baseStyle ?? theme.textStyle!;
    return TextRenderer(
      defaultStyle: textStyle,
      boldStyle: (!replace && baseStyle != null ? baseStyle : null) ??
          theme.boldStyle!,
      italicStyle: (!replace && baseStyle != null
              ? baseStyle.copyWith(fontStyle: FontStyle.italic)
              : null) ??
          theme.italicStyle!,
      highlightedStyle: (!replace && baseStyle != null ? baseStyle : null) ??
          theme.highlightedStyle!,
      linkStyle: textStyle.copyWith(
        color: theme.linkColor,
        decoration: TextDecoration.underline,
      ),
      onTapLink: onTapLink,
    );
  }
}

class Renderers {
  final TextRenderer textRenderer;
  final TextRenderer h1Renderer;
  final TextRenderer h2Renderer;
  final TextRenderer h3Renderer;
  final TextRenderer h4Renderer;
  final TextRenderer h5Renderer;
  final TextRenderer h6Renderer;
  final CodeBlockRenderer codeBlockRenderer;
  final OrderedListRenderer orderedListRenderer;
  final UnorderedListRenderer unorderedListRenderer;
  final BlockQuoteRenderer blockQuoteRenderer;
  final ImageRenderer imageRenderer;

  factory Renderers.fromTheme({
    required BuildContext context,
    required DraftViewTheme theme,
    Function(String url, Map<String, dynamic> data)? onTapLink,
    Function(String url)? onTapImage,
    Widget Function(String url)? imageBuilder,
    WidgetSpan Function(InlineSpan span)? blockquoteBuilder,
    WidgetSpan Function(InlineSpan span)? codeBlockBuilder,
  }) {
    final draftTheme = theme.draftTheme;
    final textRenderer = DraftViewTheme.textRenderer(
      draftTheme,
      onTapLink: onTapLink,
    );

    final h1Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h1Style,
      onTapLink: onTapLink,
      replace: false,
    );
    final h2Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h2Style,
      onTapLink: onTapLink,
      replace: false,
    );
    final h3Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h3Style,
      onTapLink: onTapLink,
      replace: false,
    );
    final h4Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h4Style,
      onTapLink: onTapLink,
      replace: false,
    );
    final h5Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h5Style,
      onTapLink: onTapLink,
      replace: false,
    );
    final h6Renderer = DraftViewTheme.textRenderer(
      draftTheme,
      baseStyle: draftTheme.h6Style,
      onTapLink: onTapLink,
      replace: false,
    );

    final orderedListRenderer = OrderedListRenderer(
      draftTheme.orderedListItemStyle == null
          ? textRenderer
          : DraftViewTheme.textRenderer(
              draftTheme,
              baseStyle: draftTheme.orderedListItemStyle,
              onTapLink: onTapLink,
            ),
      draftTheme.indent,
    );
    final unorderedListRenderer = UnorderedListRenderer(
      draftTheme.unorderedListItemStyle == null
          ? textRenderer
          : DraftViewTheme.textRenderer(
              draftTheme,
              baseStyle: draftTheme.unorderedListItemStyle,
              onTapLink: onTapLink,
            ),
      draftTheme.indent,
    );

    final codeBlockRenderer = CodeBlockRenderer(
      DraftViewTheme.textRenderer(
        draftTheme,
        baseStyle: draftTheme.codeStyle,
        onTapLink: onTapLink,
      ),
      codeBlockBuilder: codeBlockBuilder,
    );
    final blockQuoteRenderer = BlockQuoteRenderer(
      context,
      DraftViewTheme.textRenderer(
        draftTheme,
        baseStyle: draftTheme.blockquoteStyle,
        onTapLink: onTapLink,
      ),
      blockquoteBuilder: blockquoteBuilder,
    );

    final imageRenderer = ImageRenderer(
      textRenderer,
      onTapImage: onTapImage,
      imageBuilder: imageBuilder,
    );
    return Renderers._internal(
      textRenderer: textRenderer,
      h1Renderer: h1Renderer,
      h2Renderer: h2Renderer,
      h3Renderer: h3Renderer,
      h4Renderer: h4Renderer,
      h5Renderer: h5Renderer,
      h6Renderer: h6Renderer,
      codeBlockRenderer: codeBlockRenderer,
      orderedListRenderer: orderedListRenderer,
      unorderedListRenderer: unorderedListRenderer,
      blockQuoteRenderer: blockQuoteRenderer,
      imageRenderer: imageRenderer,
    );
  }

  Renderers._internal({
    required this.textRenderer,
    required this.h1Renderer,
    required this.h2Renderer,
    required this.h3Renderer,
    required this.h4Renderer,
    required this.h5Renderer,
    required this.h6Renderer,
    required this.codeBlockRenderer,
    required this.orderedListRenderer,
    required this.unorderedListRenderer,
    required this.blockQuoteRenderer,
    required this.imageRenderer,
  });
}
