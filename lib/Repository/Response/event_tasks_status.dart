import 'package:json_annotation/json_annotation.dart';
import 'participant_task.dart';

part 'event_tasks_status.g.dart';

@JsonSerializable(explicitToJson: true)
class EventTasksStatus {
  final List<ParticipantTask>? pending;
  final List<ParticipantTask>? done;
  final List<ParticipantTask>? rejected;

  EventTasksStatus({this.pending, this.done, this.rejected});

  factory EventTasksStatus.fromJson(Map<String, dynamic> json) => _$EventTasksStatusFromJson(json);
  Map<String, dynamic> toJson() => _$EventTasksStatusToJson(this);
}
