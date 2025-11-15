import 'Response/task.dart';

abstract class TasksManagementRepository {
	/// Get tasks assigned to current user
	Future<List<Task>> getTasks();

	/// Mark task as done
	Future<void> markDone(String taskId);

	/// Reject task
	Future<void> rejectTask(String taskId);
}

