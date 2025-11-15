import 'dart:convert';

import 'package:http/http.dart' as http;

import '../tasks_management_repository.dart';
import '../Response/task.dart';

class HttpTasksManagementRepository implements TasksManagementRepository {
  final String baseUrl;
  final http.Client client;
  final String? userId;

  HttpTasksManagementRepository({required this.baseUrl, http.Client? client, this.userId}) : client = client ?? http.Client();

  @override
  Future<List<Task>> getTasks() async {
    final url = Uri.parse('$baseUrl/api/tasks');
    final headers = <String, String>{};
    if (userId != null) headers['X-User-Id'] = userId!;
    final res = await client.get(url, headers: headers);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to fetch tasks: ${res.statusCode} ${res.body}');
  }

  @override
  Future<void> markDone(String taskId) async {
    final url = Uri.parse('$baseUrl/api/tasks/$taskId/done');
    final res = await client.post(url);
    if (res.statusCode != 200) throw Exception('Failed to mark done: ${res.statusCode} ${res.body}');
  }

  @override
  Future<void> rejectTask(String taskId) async {
    final url = Uri.parse('$baseUrl/api/tasks/$taskId/reject');
    final res = await client.post(url);
    if (res.statusCode != 200) throw Exception('Failed to reject task: ${res.statusCode} ${res.body}');
  }
}
