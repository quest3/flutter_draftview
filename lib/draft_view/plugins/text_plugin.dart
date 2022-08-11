import 'package:draft_view/draft_view/blocks/blocks.dart'
    show BaseBlock, TextBlock;

import 'base_plugin.dart';

class TextPlugin extends BasePlugin {
  @override
  blockRenderFn(BaseBlock block, {bool shouldWrite = false}) => {
        "unstyled": TextBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
        )
      };
}
