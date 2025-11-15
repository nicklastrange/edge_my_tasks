import 'dart:convert';

import 'package:http/http.dart' as http;

import '../user_management_repository.dart';
import '../Response/category.dart';
import '../Response/enums.dart';

class HttpUserManagementRepository implements UserManagementRepository {
  final String baseUrl;
  final http.Client client;
  final String? userId;
  HttpUserManagementRepository({required this.baseUrl, http.Client? client, this.userId}) : client = client ?? http.Client();

  @override
  Future<List<Category>> getCategoryBlacklist() async {
    final url = Uri.parse('$baseUrl/api/users/me/categories/blacklist');
    final headers = <String, String>{};
    if (userId != null) headers['X-User-Id'] = userId!;
    final res = await client.get(url, headers: headers);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch blacklist: ${res.statusCode} ${res.body}');
  }

  @override
  Future<void> putCategoryBlacklist(List<Category> blacklist) async {
    final url = Uri.parse('$baseUrl/api/users/me/categories/blacklist');
    final headers = {'Content-Type': 'application/json'};
    if (userId != null) headers['X-User-Id'] = userId!;
    final res = await client.put(url, headers: headers, body: jsonEncode(blacklist.map((b) => b.toJson()).toList()));
    if (res.statusCode != 200) throw Exception('Failed to update blacklist: ${res.statusCode} ${res.body}');
  }

  @override
  Future<List<NotificationChannel>> getNotificationChannels() async {
    final url = Uri.parse('$baseUrl/api/users/me/notification-channels');
    final headers = <String, String>{};
    if (userId != null) headers['X-User-Id'] = userId!;
    final res = await client.get(url, headers: headers);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list.map((e) {
        final s = (e as String).toLowerCase();
        return NotificationChannel.values.firstWhere(
          (v) => v.toString().split('.').last.toLowerCase() == s,
          orElse: () => NotificationChannel.email,
        );
      }).toList();
    }
    throw Exception('Failed to fetch notification channels: ${res.statusCode} ${res.body}');
  }

  @override
  Future<void> putNotificationChannels(List<NotificationChannel> channels) async {
    final url = Uri.parse('$baseUrl/api/users/me/notification-channels');
    final headers = {'Content-Type': 'application/json'};
    if (userId != null) headers['X-User-Id'] = userId!;
    final res = await client.put(
      url,
      headers: headers,
      body: jsonEncode(channels.map((c) => c.toString().split('.').last.toUpperCase()).toList()),
    );
    if (res.statusCode != 200) throw Exception('Failed to update notification channels: ${res.statusCode} ${res.body}');
  }
}
