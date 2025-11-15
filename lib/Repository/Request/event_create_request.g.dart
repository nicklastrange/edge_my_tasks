// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreateRequest _$EventCreateRequestFromJson(Map<String, dynamic> json) =>
    EventCreateRequest(
      category: $enumDecode(_$CategoryDtoEnumMap, json['category']),
      title: json['title'] as String,
      description: json['description'] as String?,
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$GroupEnumEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EventCreateRequestToJson(EventCreateRequest instance) =>
    <String, dynamic>{
      'category': _$CategoryDtoEnumMap[instance.category]!,
      'title': instance.title,
      'description': instance.description,
      'groups': instance.groups.map((e) => _$GroupEnumEnumMap[e]!).toList(),
    };

const _$CategoryDtoEnumMap = {
  CategoryDto.SECURITY: 'SECURITY',
  CategoryDto.SALES: 'SALES',
  CategoryDto.GENERAL: 'GENERAL',
  CategoryDto.ONBOARDING: 'ONBOARDING',
  CategoryDto.TRAINING: 'TRAINING',
  CategoryDto.PARTY: 'PARTY',
  CategoryDto.HR: 'HR',
  CategoryDto.IT: 'IT',
  CategoryDto.COMPLIANCE: 'COMPLIANCE',
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
