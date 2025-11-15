// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_tasks_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTasksStatus _$EventTasksStatusFromJson(Map<String, dynamic> json) =>
    EventTasksStatus(
      pending: (json['pending'] as List<dynamic>?)
          ?.map((e) => ParticipantTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      done: (json['done'] as List<dynamic>?)
          ?.map((e) => ParticipantTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      rejected: (json['rejected'] as List<dynamic>?)
          ?.map((e) => ParticipantTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventTasksStatusToJson(EventTasksStatus instance) =>
    <String, dynamic>{
      'pending': instance.pending?.map((e) => e.toJson()).toList(),
      'done': instance.done?.map((e) => e.toJson()).toList(),
      'rejected': instance.rejected?.map((e) => e.toJson()).toList(),
    };
