import 'Response/stats_response.dart';

abstract class StatsRepository {
  Future<StatsResponse> getStats({int expiringHours = 24});
}
