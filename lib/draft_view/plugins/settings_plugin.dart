import 'package:draft_view/draft_view/blocks/blocks.dart'
    show SettingsBlock, Settings;

import 'base_plugin.dart';

class SettingsPlugin extends BasePlugin {
  late final Settings settings;

  SettingsPlugin({required Map<String, dynamic> rawSettings}) {
    this.settings = Settings.fromJson(rawSettings);
  }

  @override
  get entityRenderFn => {
        "POST-SETTINGS": SettingsBlock(
          depth: 0,
          blockType: '',
          data: {},
          end: 0,
          entityTypes: [],
          inlineStyles: [],
          start: 0,
          text: '',
          settings: settings,
        )
      };
}
