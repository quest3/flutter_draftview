import 'dart:convert';
import 'dart:io';

import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);
//     final postSettings = postSettingsFromJson(jsonString);
//     final detailSettings = detailSettingsFromJson(jsonString);
Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

_PostSettings postSettingsFromJson(String str) =>
    _PostSettings.fromJson(json.decode(str));

String postSettingsToJson(_PostSettings data) => json.encode(data.toJson());

_DetailSettings detailSettingsFromJson(String str) =>
    _DetailSettings.fromJson(json.decode(str));

String detailSettingsToJson(_DetailSettings data) => json.encode(data.toJson());

/// Post Settings object
class Settings {
  final List<_PostSettings> settings;

  Settings({
    required this.settings,
  });

  Settings copyWith({
    List<_PostSettings>? settings,
  }) =>
      Settings(
        settings: settings ?? this.settings,
      );

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        settings: json["settings"] == null
            ? []
            : List<_PostSettings>.from(
                json["settings"].map(
                  (x) => _PostSettings.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings.isEmpty
            ? []
            : List<dynamic>.from(settings.map((x) => x.toJson())),
      };
}

class _PostSettings {
  final List<_DetailSettings> detailSettings;
  final String? id;

  _PostSettings({
    required this.detailSettings,
    required this.id,
  });

  _PostSettings copyWith({
    List<_DetailSettings>? detailSettings,
    String? id,
  }) =>
      _PostSettings(
        detailSettings: detailSettings ?? this.detailSettings,
        id: id ?? this.id,
      );

  factory _PostSettings.fromJson(Map<String, dynamic> json) => _PostSettings(
        detailSettings: json["detailSettings"] == null
            ? []
            : List<_DetailSettings>.from(
                json["detailSettings"].map((x) => _DetailSettings.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "detailSettings": detailSettings.isEmpty
            ? null
            : List<dynamic>.from(detailSettings.map((x) => x.toJson())),
        "id": id == null ? null : id,
      };
}

class _DetailSettings {
  final String? description;
  final String? name;
  final String? id;

  _DetailSettings({
    required this.description,
    required this.name,
    required this.id,
  });

  _DetailSettings copyWith({
    String? description,
    String? name,
    String? id,
  }) =>
      _DetailSettings(
        description: description ?? this.description,
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory _DetailSettings.fromJson(Map<String, dynamic> json) =>
      _DetailSettings(
          description: json["description"] == null ? null : json["description"],
          name: json["name"] == null ? null : json["name"],
          id: json['id']);

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "name": name == null ? null : name,
        "id": id,
      };
}

/// Post setting's block. This block will be used to render the keyword (like a hashtag ) in blog.
/// For example [iPhone] is a post setting's block
class PostSettingsBlock extends BaseBlock {
  final Settings settings;

  PostSettingsBlock({
    required int depth,
    required int start,
    required int end,
    required List<String> inlineStyles,
    required Map<String, dynamic> data,
    required String text,
    required List<String> entityTypes,
    required String blockType,
    required this.settings,
  }) : super(
          depth: depth,
          start: start,
          end: end,
          inlineStyles: inlineStyles,
          data: data,
          text: text,
          entityTypes: entityTypes,
          blockType: blockType,
        );

  PostSettingsBlock copyWith({BaseBlock? block}) => PostSettingsBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        settings: this.settings,
      );

  @override
  InlineSpan render(BuildContext context, {List<InlineSpan>? children}) {
    late _DetailSettings _detailSettings;
    var textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          color: Colors.orange,
        );

    for (var setting in settings.settings) {
      for (var ds in setting.detailSettings) {
        if (ds.id == data['id']) {
          _detailSettings = ds;
        }
      }
    }

    var recognizer = TapGestureRecognizer()
      ..onTap = () {
        showBottomSheet(
          context: context,
          builder: (c) => PostSettingsCard(
            settings: _detailSettings,
          ),
        );
      };
    bool useTooltip = false;

    if (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      useTooltip = true;
    }

    return TextSpan(
      text: _detailSettings.name,
      recognizer: recognizer,
      style: textStyle,
      children: useTooltip
          ? [
              WidgetSpan(
                style: textStyle,
                alignment: PlaceholderAlignment.middle,
                child: Tooltip(
                  message: _detailSettings.description,
                  child: InkWell(
                    onHover: (_) {},
                    onTap: () {},
                    child: Icon(
                      Icons.link,
                      color: textStyle?.color,
                      size: 20,
                    ),
                  ),
                ),
              )
            ]
          : null,
    );
  }
}

class PostSettingsCard extends StatelessWidget {
  final _DetailSettings settings;

  const PostSettingsCard({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Stack(
        children: [
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "${settings.name}",
                  ),
                  subtitle: Text(
                    "${settings.description}",
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
