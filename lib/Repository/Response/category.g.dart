// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  name: $enumDecode(_$CategoryDtoEnumMap, json['name']),
  requiredField: json['required'] as bool?,
  notificationPolicy: json['notificationPolicy'] as String?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'name': _$CategoryDtoEnumMap[instance.name]!,
  'required': instance.requiredField,
  'notificationPolicy': instance.notificationPolicy,
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
