import 'package:draft_view/draft_view/blocks/blocks.dart'
    show LinkBlock, OnTap, OnDoubleTap, OnLongPress, ActionBuilder;

import 'base_plugin.dart';

class LinkPlugin extends BasePlugin {
  final OnTap? onTap;
  final OnDoubleTap? onDoubleTap;
  final OnLongPress? onLongPress;
  final ActionBuilder? actionBuilder;

  LinkPlugin({
    this.onDoubleTap,
    this.onLongPress,
    this.onTap,
    this.actionBuilder,
  }) : super();

  @override
  get entityRenderFn => {
        "LINK": LinkBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          children: [],
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          actionBuilder: actionBuilder,
        )
      };
}
