// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: json['id'] as String?,
  category: Category.fromJson(json['category']),
  title: json['title'] as String,
  description: json['description'] as String?,
  groups: (json['groups'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$GroupEnumEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category.toJson(),
  'title': instance.title,
  'description': instance.description,
  'groups': instance.groups?.map((e) => _$GroupEnumEnumMap[e]!).toList(),
};

const _$GroupEnumEnumMap = {
  GroupEnum.uop: 'UoP',
  GroupEnum.sales: 'SALES',
  GroupEnum.backoffice: 'BACKOFFICE',
  GroupEnum.b2b: 'B2B',
  GroupEnum.dev: 'DEV',
  GroupEnum.tl: 'TL',
  GroupEnum.qa: 'QA',
};
