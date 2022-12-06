import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

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

@JsonSerializable(explicitToJson: true)
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

  @JsonKey(name: "type")
  String rawType;
  @JsonKey(ignore: true)
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

@JsonSerializable(explicitToJson: true)
class Entity {
  int offset;
  int length;
  int key;
  EntityData? data;

  Entity(this.offset, this.length, this.key);

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InlineStyle {
  int offset;
  int length;
  String style;

  InlineStyle(this.offset, this.length, this.style);

  factory InlineStyle.fromJson(Map<String, dynamic> json) => _$InlineStyleFromJson(json);

  Map<String, dynamic> toJson() => _$InlineStyleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EntityData {
  String type;
  String mutability;
  Map<String, dynamic> data;

  EntityData(this.type, this.mutability, this.data);

  factory EntityData.fromJson(Map<String, dynamic> json) => _$EntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$EntityDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
