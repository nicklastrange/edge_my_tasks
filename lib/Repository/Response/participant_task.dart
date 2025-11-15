import 'package:json_annotation/json_annotation.dart';
import 'event.dart';

part 'participant_task.g.dart';

@JsonSerializable(explicitToJson: true)
class ParticipantTask {
  final String? id;
  final DateTime? createdAt;
  final DateTime? deadline;
  final String? status;
  final Event? event;
  final String? actionUrl;
  final String? employeeFirstName;
  final String? employeeLastName;

  ParticipantTask({this.id, this.createdAt, this.deadline, this.status, this.event, this.actionUrl, this.employeeFirstName, this.employeeLastName});

  factory ParticipantTask.fromJson(Map<String, dynamic> json) => _$ParticipantTaskFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantTaskToJson(this);
}
