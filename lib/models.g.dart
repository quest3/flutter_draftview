// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

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
