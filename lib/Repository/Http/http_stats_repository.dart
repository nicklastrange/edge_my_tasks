import 'dart:convert';

import 'package:http/http.dart' as http;

import '../stats_repository.dart';
import '../Response/stats_response.dart';

class HttpStatsRepository implements StatsRepository {
  final String baseUrl;
  final http.Client client;

  HttpStatsRepository({required this.baseUrl, http.Client? client}) : client = client ?? http.Client();

  @override
  Future<StatsResponse> getStats({int expiringHours = 24}) async {
    final url = Uri.parse('$baseUrl/api/stats?expiringHours=$expiringHours');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      return StatsResponse.fromJson(body);
    }
    throw Exception('Failed to fetch stats: ${res.statusCode} ${res.body}');
  }
}
