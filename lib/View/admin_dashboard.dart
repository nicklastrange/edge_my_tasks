import 'package:flutter/material.dart';
import 'components/metric_card.dart';
import 'components/event_list_item.dart';
import 'styles.dart';

import '../Repository/Http/http_event_management_repository.dart';
import '../Repository/Http/http_stats_repository.dart';
import '../Repository/Response/stats_response.dart';
import '../Repository/Response/event.dart' as resp;

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  bool _loading = true;
  String? _error;

  // Simple metrics
  int _activeTasks = 0;
  int _overdueTasks = 0;
  double _completionRate = 0.0;
  int _activeUsers = 0;
  List<resp.Event> _recentEvents = [];

  // Configure baseUrl here or inject via constructor later
  final String baseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final eventsRepo = HttpEventManagementRepository(baseUrl: baseUrl);
      final statsRepo = HttpStatsRepository(baseUrl: baseUrl);

      // Fetch events and stats in parallel
      final results = await Future.wait([
        eventsRepo.getEvents(),
        statsRepo.getStats(),
      ]);

      final events = results[0] as List<resp.Event>;
      final stats = results[1] as StatsResponse;

      setState(() {
        _completionRate = stats.completionPercentage;
        _activeTasks = stats.activeTasksCount;
        _overdueTasks = stats.overdueTasksCount; // not provided by stats; keep 0 or fetch separately if backend adds it
        _activeUsers = stats.activeEmployeesCount;
        _recentEvents = events;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // events are fetched via repo.getEvents()

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kPagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Dashboard', style: kH1),
          const SizedBox(height: 6),
          const Text('Przegląd aktywności i statystyk zadań', style: kSubtitle),
          const SizedBox(height: 20),

          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            Column(children: [Text('Błąd: $_error', style: const TextStyle(color: Colors.red)), const SizedBox(height: 12), ElevatedButton(onPressed: _fetchData, child: const Text('Ponów'))])
          else ...[
            // Metrics row
            SizedBox(
              height: 110,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: MetricCard(title: 'Aktywne zadania', value: '$_activeTasks', subtitle: 'W tym tygodniu', color: AppColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: MetricCard(title: 'Zaległe zadania', value: '$_overdueTasks', subtitle: 'Wymagają uwagi', color: AppColors.accent)),
                const SizedBox(width: 12),
                Expanded(child: MetricCard(title: 'Wskaźnik ukończenia', value: '${_completionRate.toStringAsFixed(0)}%', subtitle: '+/- względem poprzedniego okresu', color: AppColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: MetricCard(title: 'Aktywni użytkownicy', value: _activeUsers == 0 ? '-' : '$_activeUsers', subtitle: 'Z łącznie zarejestrowanych', color: AppColors.primary)),
              ]),
            ),

            const SizedBox(height: 20),

            // Recent events
            Container(
              padding: const EdgeInsets.all(16),
              decoration: cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ostatnio utworzone wydarzenia', style: kH2),
                  const SizedBox(height: 12),
                  if (_recentEvents.isEmpty)
                    const Text('Brak wydarzeń')
                  else
                    ..._recentEvents.map((e) {
                      final map = {
                        'title': e.title,
                        'category': e.category.name.toString().split('.').last,
                        'groups': e.groups?.map((g) => g.toString().split('.').last).toList() ?? <String>[]
                      };
                      return EventListItem.fromMap(map);
                    }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Szybkie akcje', style: kH2),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: ElevatedButton.icon(onPressed: () => Navigator.of(context).pushNamed('/events'), icon: const Icon(Icons.check_box, color: Colors.white), label: const Text('Utwórz nowe wydarzenie', style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
                    const SizedBox(width: 12),
                    Expanded(child: ElevatedButton.icon(onPressed: () => Navigator.of(context).pushNamed('/employees'), icon: const Icon(Icons.group, color: Colors.white), label: const Text('Zarządzaj pracownikami', style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
                    const SizedBox(width: 12),
                    Expanded(child: OutlinedButton.icon(onPressed: () => Navigator.of(context).pushNamed('/statistics'), icon: const Icon(Icons.bar_chart, color: Colors.black), label: const Text('Zobacz raporty', style: TextStyle(color: Colors.black)), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
                  ]),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
