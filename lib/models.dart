enum BlockType {
  unstyled,
  paragraph,
  header1,
  header2,
  header3,
  header4,
  header5,
  header6,
  unordered_list_item,
  ordered_list_item,
  blockquote,
  code_block,
  atomic,
  unknown,
}

class DraftBlock {
  static const _TYPE_MAP = {
    "unstyled": BlockType.unstyled,
    "paragraph": BlockType.paragraph,
    "header-one": BlockType.header1,
    "header-two": BlockType.header2,
    "header-three": BlockType.header3,
    "header-four": BlockType.header4,
    "header-five": BlockType.header5,
    "header-six": BlockType.header6,
    "unordered-list-item": BlockType.unordered_list_item,
    "ordered-list-item": BlockType.ordered_list_item,
    "blockquote": BlockType.blockquote,
    "code-block": BlockType.code_block,
    "atomic": BlockType.atomic,
  };
  String key;
  String text;
  String rawType;
  late BlockType type;
  int depth;
  List<InlineStyle> inlineStyleRanges;
  List<Entity> entityRanges;

  // Map<dynamic, dynamic> data;

  DraftBlock(this.key, this.text, this.rawType, this.depth, this.inlineStyleRanges, this.entityRanges);

  factory DraftBlock.fromJson(Map<String, dynamic> json) {
    DraftBlock block = _$DraftBlockFromJson(json);
    block.type = _TYPE_MAP[block.rawType] ?? BlockType.unknown;
    return block;
  }

  Map<String, dynamic> toJson() => _$DraftBlockToJson(this);
}

class Entity {
  int offset;
  int length;
  int key;
  EntityData? data;

  Entity(this.offset, this.length, this.key);

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

class InlineStyle {
  int offset;
  int length;
  String style;

  InlineStyle(this.offset, this.length, this.style);

  factory InlineStyle.fromJson(Map<String, dynamic> json) => _$InlineStyleFromJson(json);

  Map<String, dynamic> toJson() => _$InlineStyleToJson(this);
}

class EntityData {
  String type;
  String mutability;
  Map<String, dynamic> data;

  EntityData(this.type, this.mutability, this.data);

  factory EntityData.fromJson(Map<String, dynamic> json) => _$EntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$EntityDataToJson(this);
}

class DraftTree {
  List<DraftBlock> blocks;
  Map<String, EntityData> entityMap;

  DraftTree(this.blocks, this.entityMap);

  factory DraftTree.fromJson(Map<String, dynamic> json) {
    DraftTree tree = _$DraftTreeFromJson(json);
    if (tree.entityMap.isNotEmpty) {
      List<DraftBlock> blocksWithEntity = tree.blocks.where((element) => element.entityRanges.isNotEmpty).toList();
      for (var block in blocksWithEntity) {
        for (var entity in block.entityRanges) {
          entity.data = tree.entityMap["${entity.key}"];
        }
      }
    }
    return tree;
  }

  Map<String, dynamic> toJson() => _$DraftTreeToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DraftBlock _$DraftBlockFromJson(Map<String, dynamic> json) => DraftBlock(
      json['key'] as String,
      json['text'] as String,
      json['type'] as String,
      json['depth'] as int,
      (json['inlineStyleRanges'] as List<dynamic>).map((e) => InlineStyle.fromJson(e as Map<String, dynamic>)).toList(),
      (json['entityRanges'] as List<dynamic>).map((e) => Entity.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$DraftBlockToJson(DraftBlock instance) => <String, dynamic>{
      'key': instance.key,
      'text': instance.text,
      'type': instance.rawType,
      'depth': instance.depth,
      'inlineStyleRanges': instance.inlineStyleRanges.map((e) => e.toJson()).toList(),
      'entityRanges': instance.entityRanges.map((e) => e.toJson()).toList(),
    };

Entity _$EntityFromJson(Map<String, dynamic> json) => Entity(
      json['offset'] as int,
      json['length'] as int,
      json['key'] as int,
    )..data = json['data'] == null ? null : EntityData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'offset': instance.offset,
      'length': instance.length,
      'key': instance.key,
      'data': instance.data?.toJson(),
    };

InlineStyle _$InlineStyleFromJson(Map<String, dynamic> json) => InlineStyle(
      json['offset'] as int,
      json['length'] as int,
      json['style'] as String,
    );

Map<String, dynamic> _$InlineStyleToJson(InlineStyle instance) => <String, dynamic>{
      'offset': instance.offset,
      'length': instance.length,
      'style': instance.style,
    };

EntityData _$EntityDataFromJson(Map<String, dynamic> json) => EntityData(
      json['type'] as String,
      json['mutability'] as String,
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$EntityDataToJson(EntityData instance) => <String, dynamic>{
      'type': instance.type,
      'mutability': instance.mutability,
      'data': instance.data,
    };

DraftTree _$DraftTreeFromJson(Map<String, dynamic> json) => DraftTree(
      (json['blocks'] as List<dynamic>).map((e) => DraftBlock.fromJson(e as Map<String, dynamic>)).toList(),
      (json['entityMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, EntityData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$DraftTreeToJson(DraftTree instance) => <String, dynamic>{
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
      'entityMap': instance.entityMap.map((k, e) => MapEntry(k, e.toJson())),
    };
