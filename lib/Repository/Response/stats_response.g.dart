// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCompletionRate _$CategoryCompletionRateFromJson(
  Map<String, dynamic> json,
) => CategoryCompletionRate(
  category: $enumDecode(_$CategoryDtoEnumMap, json['category']),
  donePercentage: (json['donePercentage'] as num).toDouble(),
  rejectedPercentage: (json['rejectedPercentage'] as num).toDouble(),
  total: (json['total'] as num).toInt(),
  done: (json['done'] as num).toInt(),
  rejected: (json['rejected'] as num).toInt(),
);

Map<String, dynamic> _$CategoryCompletionRateToJson(
  CategoryCompletionRate instance,
) => <String, dynamic>{
  'category': _$CategoryDtoEnumMap[instance.category]!,
  'donePercentage': instance.donePercentage,
  'rejectedPercentage': instance.rejectedPercentage,
  'total': instance.total,
  'done': instance.done,
  'rejected': instance.rejected,
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

ChannelEffectiveness _$ChannelEffectivenessFromJson(
  Map<String, dynamic> json,
) => ChannelEffectiveness(
  channel: $enumDecode(_$NotificationChannelEnumMap, json['channel']),
  completionRate: (json['completionRate'] as num).toDouble(),
  tasks: (json['tasks'] as num).toInt(),
);

Map<String, dynamic> _$ChannelEffectivenessToJson(
  ChannelEffectiveness instance,
) => <String, dynamic>{
  'channel': _$NotificationChannelEnumMap[instance.channel]!,
  'completionRate': instance.completionRate,
  'tasks': instance.tasks,
};

const _$NotificationChannelEnumMap = {
  NotificationChannel.email: 'EMAIL',
  NotificationChannel.sms: 'SMS',
  NotificationChannel.whatsapp: 'WHATSAPP',
  NotificationChannel.msTeams: 'MS_TEAMS',
};

ChannelPreferenceSlice _$ChannelPreferenceSliceFromJson(
  Map<String, dynamic> json,
) => ChannelPreferenceSlice(
  channel: $enumDecode(_$NotificationChannelEnumMap, json['channel']),
  percentage: (json['percentage'] as num).toDouble(),
  employees: (json['employees'] as num).toInt(),
);

Map<String, dynamic> _$ChannelPreferenceSliceToJson(
  ChannelPreferenceSlice instance,
) => <String, dynamic>{
  'channel': _$NotificationChannelEnumMap[instance.channel]!,
  'percentage': instance.percentage,
  'employees': instance.employees,
};

StatsResponse _$StatsResponseFromJson(
  Map<String, dynamic> json,
) => StatsResponse(
  overallDonePercentage: (json['overallDonePercentage'] as num).toDouble(),
  overallRejectedPercentage: (json['overallRejectedPercentage'] as num)
      .toDouble(),
  pendingPercentage: (json['pendingPercentage'] as num).toDouble(),
  expiringSoonPercentage: (json['expiringSoonPercentage'] as num).toDouble(),
  categoryRates: (json['categoryRates'] as List<dynamic>?)
      ?.map((e) => CategoryCompletionRate.fromJson(e as Map<String, dynamic>))
      .toList(),
  alertEmployees: (json['alertEmployees'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  totalDeliveredNotifications: (json['totalDeliveredNotifications'] as num)
      .toInt(),
  totalUniqueClicks: (json['totalUniqueClicks'] as num).toInt(),
  averageCompletionHours: (json['averageCompletionHours'] as num?)?.toDouble(),
  channelEffectiveness: (json['channelEffectiveness'] as List<dynamic>?)
      ?.map((e) => ChannelEffectiveness.fromJson(e as Map<String, dynamic>))
      .toList(),
  channelPreferences: (json['channelPreferences'] as List<dynamic>?)
      ?.map((e) => ChannelPreferenceSlice.fromJson(e as Map<String, dynamic>))
      .toList(),
  activeTasksCount: (json['activeTasksCount'] as num).toInt(),
  overdueTasksCount: (json['overdueTasksCount'] as num).toInt(),
  completionPercentage: (json['completionPercentage'] as num).toDouble(),
  activeEmployeesCount: (json['activeEmployeesCount'] as num).toInt(),
);

Map<String, dynamic> _$StatsResponseToJson(StatsResponse instance) =>
    <String, dynamic>{
      'overallDonePercentage': instance.overallDonePercentage,
      'overallRejectedPercentage': instance.overallRejectedPercentage,
      'pendingPercentage': instance.pendingPercentage,
      'expiringSoonPercentage': instance.expiringSoonPercentage,
      'categoryRates': instance.categoryRates?.map((e) => e.toJson()).toList(),
      'alertEmployees': instance.alertEmployees,
      'totalDeliveredNotifications': instance.totalDeliveredNotifications,
      'totalUniqueClicks': instance.totalUniqueClicks,
      'averageCompletionHours': instance.averageCompletionHours,
      'channelEffectiveness': instance.channelEffectiveness
          ?.map((e) => e.toJson())
          .toList(),
      'channelPreferences': instance.channelPreferences
          ?.map((e) => e.toJson())
          .toList(),
      'activeTasksCount': instance.activeTasksCount,
      'overdueTasksCount': instance.overdueTasksCount,
      'completionPercentage': instance.completionPercentage,
      'activeEmployeesCount': instance.activeEmployeesCount,
    };
