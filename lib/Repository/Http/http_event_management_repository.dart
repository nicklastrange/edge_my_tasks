import 'dart:convert';

import 'package:http/http.dart' as http;

import '../event_management_repository.dart';
import '../Request/event_create_request.dart';
import '../Response/event.dart';
import '../Response/event_tasks_status.dart';

class HttpEventManagementRepository implements EventManagementRepository {
  final String baseUrl;
  final http.Client client;

  HttpEventManagementRepository({required this.baseUrl, http.Client? client}) : client = client ?? http.Client();

  @override
  Future<Event> createEvent(EventCreateRequest request) async {
    final url = Uri.parse('$baseUrl/api/events');
    final res = await client.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(request.toJson()));
    if (res.statusCode == 201 || res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      return Event.fromJson(body);
    }
    throw Exception('Failed to create event: ${res.statusCode} ${res.body}');
  }

  @override
  Future<List<Event>> getEvents() async {
    final url = Uri.parse('$baseUrl/api/events');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to fetch events: ${res.statusCode} ${res.body}');
  }

  @override
  Future<EventTasksStatus> getParticipantsStatus(String eventId) async {
    final url = Uri.parse('$baseUrl/api/events/$eventId/participants-status');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      return EventTasksStatus.fromJson(body);
    }
    throw Exception('Failed to fetch participants status: ${res.statusCode} ${res.body}');
  }
}
