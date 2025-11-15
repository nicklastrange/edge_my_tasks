// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  id: json['id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  categoriesBlacklist: (json['categoriesBlacklist'] as List<dynamic>?)
      ?.map(Category.fromJson)
      .toList(),
  groups: (json['groups'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$GroupEnumEnumMap, e))
      .toList(),
  position: json['position'] as String?,
  notificationChannels: (json['notificationChannels'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$NotificationChannelEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'categoriesBlacklist': instance.categoriesBlacklist
      ?.map((e) => e.toJson())
      .toList(),
  'groups': instance.groups?.map((e) => _$GroupEnumEnumMap[e]!).toList(),
  'position': instance.position,
  'notificationChannels': instance.notificationChannels
      ?.map((e) => _$NotificationChannelEnumMap[e]!)
      .toList(),
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

const _$NotificationChannelEnumMap = {
  NotificationChannel.email: 'EMAIL',
  NotificationChannel.sms: 'SMS',
  NotificationChannel.whatsapp: 'WHATSAPP',
  NotificationChannel.msTeams: 'MS_TEAMS',
};
