import 'dart:convert';

class DraftObject {
  final List<RawDraftContentBlock> blocks;
  final Map<String, RawDraftEntityKeyStringAny> entityMap;

  DraftObject({
    required this.blocks,
    required this.entityMap,
  });

  DraftObject copyWith({
    List<RawDraftContentBlock>? blocks,
    Map<String, RawDraftEntityKeyStringAny>? entityMap,
  }) =>
      DraftObject(
        blocks: blocks ?? this.blocks,
        entityMap: entityMap ?? this.entityMap,
      );

  factory DraftObject.fromRawJson(String str) =>
      DraftObject.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory DraftObject.fromJson(Map<String, dynamic> json) => DraftObject(
        blocks: (json["blocks"] as List<dynamic>)
            .map(
                (x) => RawDraftContentBlock.fromJson(x as Map<String, dynamic>))
            .toList(),
        entityMap: Map<String, dynamic>.from(json["entityMap"] as Map).map(
          (k, v) => MapEntry(k,
              RawDraftEntityKeyStringAny.fromJson(v as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "blocks": blocks.map((x) => x.toJson()).toList(),
        "entityMap":
            entityMap.map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class RawDraftContentBlock {
  final Map<String, dynamic> data;
  final double depth;
  final List<RawDraftEntityRange> entityRanges;
  final List<RawDraftInlineStyleRange> inlineStyleRanges;
  final String key;
  final String text;
  final String type;

  RawDraftContentBlock({
    required this.data,
    required this.depth,
    required this.entityRanges,
    required this.inlineStyleRanges,
    required this.key,
    required this.text,
    required this.type,
  });

  RawDraftContentBlock copyWith({
    Map<String, dynamic>? data,
    double? depth,
    List<RawDraftEntityRange>? entityRanges,
    List<RawDraftInlineStyleRange>? inlineStyleRanges,
    String? key,
    String? text,
    String? type,
  }) =>
      RawDraftContentBlock(
        data: data ?? this.data,
        depth: depth ?? this.depth,
        entityRanges: entityRanges ?? this.entityRanges,
        inlineStyleRanges: inlineStyleRanges ?? this.inlineStyleRanges,
        key: key ?? this.key,
        text: text ?? this.text,
        type: type ?? this.type,
      );

  factory RawDraftContentBlock.fromRawJson(String str) =>
      RawDraftContentBlock.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RawDraftContentBlock.fromJson(Map<String, dynamic> json) =>
      RawDraftContentBlock(
        data: Map<String, dynamic>.from(json["data"]),
        depth: json["depth"].toDouble(),
        entityRanges: (json["entityRanges"] as List<dynamic>)
            .map((x) => RawDraftEntityRange.fromJson(x as Map<String, dynamic>))
            .toList(),
        inlineStyleRanges: (json["inlineStyleRanges"] as List<dynamic>)
            .map((x) =>
                RawDraftInlineStyleRange.fromJson(x as Map<String, dynamic>))
            .toList(),
        key: json["key"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "depth": depth,
        "entityRanges": entityRanges.map((x) => x.toJson()).toList(),
        "inlineStyleRanges": inlineStyleRanges.map((x) => x.toJson()).toList(),
        "key": key,
        "text": text,
        "type": type,
      };
}

class RawDraftEntityRange {
  final String key;
  final double length;
  final double offset;

  RawDraftEntityRange({
    required this.key,
    required this.length,
    required this.offset,
  });

  RawDraftEntityRange copyWith({
    String? key,
    double? length,
    double? offset,
  }) =>
      RawDraftEntityRange(
        key: key ?? this.key,
        length: length ?? this.length,
        offset: offset ?? this.offset,
      );

  factory RawDraftEntityRange.fromRawJson(String str) =>
      RawDraftEntityRange.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RawDraftEntityRange.fromJson(Map<String, dynamic> json) =>
      RawDraftEntityRange(
        key: json["key"].toString(),
        length: json["length"].toDouble(),
        offset: json["offset"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "length": length,
        "offset": offset,
      };
}

class RawDraftInlineStyleRange {
  final double length;
  final double offset;
  final String style;

  RawDraftInlineStyleRange({
    required this.length,
    required this.offset,
    required this.style,
  });

  RawDraftInlineStyleRange copyWith({
    double? length,
    double? offset,
    String? style,
  }) =>
      RawDraftInlineStyleRange(
        length: length ?? this.length,
        offset: offset ?? this.offset,
        style: style ?? this.style,
      );

  factory RawDraftInlineStyleRange.fromRawJson(String str) =>
      RawDraftInlineStyleRange.fromJson(
          json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RawDraftInlineStyleRange.fromJson(Map<String, dynamic> json) =>
      RawDraftInlineStyleRange(
        length: json["length"].toDouble(),
        offset: json["offset"].toDouble(),
        style: json["style"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
        "style": style,
      };
}

class RawDraftEntityKeyStringAny {
  final Map<String, dynamic> data;
  final String mutability;
  final String type;

  RawDraftEntityKeyStringAny({
    required this.data,
    required this.mutability,
    required this.type,
  });

  RawDraftEntityKeyStringAny copyWith({
    Map<String, dynamic>? data,
    String? mutability,
    String? type,
  }) =>
      RawDraftEntityKeyStringAny(
        data: data ?? this.data,
        mutability: mutability ?? this.mutability,
        type: type ?? this.type,
      );

  factory RawDraftEntityKeyStringAny.fromRawJson(String str) =>
      RawDraftEntityKeyStringAny.fromJson(
          json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RawDraftEntityKeyStringAny.fromJson(Map<String, dynamic> json) =>
      RawDraftEntityKeyStringAny(
        data: Map<String, dynamic>.from(json["data"]),
        mutability: json["mutability"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "mutability": mutability,
        "type": type,
      };
}

class RawDraftEntityT {
  final Map<String, dynamic> data;
  final String mutability;
  final String type;

  RawDraftEntityT({
    required this.data,
    required this.mutability,
    required this.type,
  });

  RawDraftEntityT copyWith({
    Map<String, dynamic>? data,
    String? mutability,
    String? type,
  }) =>
      RawDraftEntityT(
        data: data ?? this.data,
        mutability: mutability ?? this.mutability,
        type: type ?? this.type,
      );

  factory RawDraftEntityT.fromRawJson(String str) =>
      RawDraftEntityT.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RawDraftEntityT.fromJson(Map<String, dynamic> json) =>
      RawDraftEntityT(
        data: Map<String, dynamic>.from(json["data"]),
        mutability: json["mutability"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "mutability": mutability,
        "type": type,
      };
}

enum ComposedEntityType { IMAGE, LINK, PHOTO, TOKEN }

enum CoreDraftBlockType {
  ATOMIC,
  BLOCKQUOTE,
  CODE_BLOCK,
  HEADER_FIVE,
  HEADER_FOUR,
  HEADER_ONE,
  HEADER_SIX,
  HEADER_THREE,
  HEADER_TWO,
  ORDERED_LIST_ITEM,
  PARAGRAPH,
  UNORDERED_LIST_ITEM,
  UNSTYLED
}
