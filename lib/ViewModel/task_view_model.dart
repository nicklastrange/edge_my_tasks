import '../Repository/Response/task.dart';

class TaskViewModel {
  final String? id;
  final String? status;
  final String? actionUrl;
  final String? employeeId;
  final DateTime? createdAt;
  final DateTime? deadline;
  final String? eventTitle;

  TaskViewModel({this.id, this.status, this.actionUrl, this.employeeId, this.createdAt, this.deadline, this.eventTitle});

  factory TaskViewModel.fromModel(Task t) => TaskViewModel(
        id: t.id,
        status: t.status,
        actionUrl: t.actionUrl,
        employeeId: t.employeeId,
        createdAt: t.createdAt,
        deadline: t.deadline,
        eventTitle: t.event?.title,
      );
}
