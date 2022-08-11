import 'package:draft_view/draft_view/blocks/blocks.dart'
    show BaseBlock, BlockQuoteBlock;

import 'base_plugin.dart';

class BlockQuotePlugin extends BasePlugin {
  @override
  blockRenderFn(BaseBlock block, {bool shouldWrite = false}) => {
        "blockquote": BlockQuoteBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          children: [],
        ),
      };
}
