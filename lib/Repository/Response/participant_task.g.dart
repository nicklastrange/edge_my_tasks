// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantTask _$ParticipantTaskFromJson(Map<String, dynamic> json) =>
    ParticipantTask(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      status: json['status'] as String?,
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      actionUrl: json['actionUrl'] as String?,
      employeeFirstName: json['employeeFirstName'] as String?,
      employeeLastName: json['employeeLastName'] as String?,
    );

Map<String, dynamic> _$ParticipantTaskToJson(ParticipantTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'status': instance.status,
      'event': instance.event?.toJson(),
      'actionUrl': instance.actionUrl,
      'employeeFirstName': instance.employeeFirstName,
      'employeeLastName': instance.employeeLastName,
    };
