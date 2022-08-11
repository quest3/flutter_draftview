import 'package:draft_view/draft_view/block/blocks/link_block.dart';
import 'package:draft_view/draft_view/block/callbacks.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';

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
