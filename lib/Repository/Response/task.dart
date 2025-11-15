import 'package:json_annotation/json_annotation.dart';
import 'event.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  final String? id;
  final DateTime? createdAt;
  final DateTime? deadline;
  final Event? event;
  final String? status; // NEW, DONE, REJECTED
  final String? actionUrl;
  final String? employeeId;

  Task({this.id, this.createdAt, this.deadline, this.event, this.status, this.actionUrl, this.employeeId});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
