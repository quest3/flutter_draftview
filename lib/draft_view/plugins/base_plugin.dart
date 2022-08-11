import 'package:draft_view/draft_view/blocks/blocks.dart' show BaseBlock;

abstract class BasePlugin {
  /// Block renderer map
  Map<String, BaseBlock>? blockRenderFn(BaseBlock block,
          {bool shouldWrite = false}) =>
      null;

  /// Entity type renderer map
  Map<String, BaseBlock>? get entityRenderFn => null;

  Map<String, BaseBlock>? get inlineStyleRenderFn => null;
}
