import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../Repository/Http/http_stats_repository.dart';
import '../Repository/Http/http_event_management_repository.dart';
import '../Repository/Response/stats_response.dart';
import '../Repository/Response/event.dart' as resp;
import 'styles.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool _loading = true;
  String? _error;
  StatsResponse? _stats;
  List<resp.Event> _events = [];
  // selected event handled inline in dialog; no field required
  late HttpStatsRepository _statsRepo;
  late HttpEventManagementRepository _eventsRepo;
  final String baseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

  @override
  void initState() {
    super.initState();
    _statsRepo = HttpStatsRepository(baseUrl: baseUrl);
    _eventsRepo = HttpEventManagementRepository(baseUrl: baseUrl);
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    setState(() { _loading = true; _error = null; });
    try {
      final results = await Future.wait([_statsRepo.getStats(), _eventsRepo.getEvents()]);
      _stats = results[0] as StatsResponse;
      _events = results[1] as List<resp.Event>;
      setState(() { _loading = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  Future<void> _selectEvent(resp.Event e) async {
    setState(() { _loading = true; _error = null; });
    try {
      final status = await _eventsRepo.getParticipantsStatus(e.id ?? '');
      // attach status to event via a simple dialog for now
      if (!mounted) return;
      setState(() { _loading = false; });
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Status uczestników: ${e.title}'),
          content: SizedBox(
            width: 720,
            height: 420,
            child: Row(children: [
              // Left: donut chart
              Expanded(
                flex: 4,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 4),
                  Expanded(
                    child: Center(
                      child: DonutChart(
                        segments: {
                          'Ukończone': (status.done?.length ?? 0).toDouble(),
                          'Nieukończone': (status.pending?.length ?? 0).toDouble(),
                          'Odrzucone': (status.rejected?.length ?? 0).toDouble(),
                        },
                        colors: [AppColors.primary, AppColors.accent, Colors.grey.shade500],
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(width: 20),
              // Right: legend and lists
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    LegendRow(color: AppColors.primary, label: 'Ukończone', value: '${status.done?.length ?? 0}', percent: _percent(status.done?.length ?? 0, (status.done?.length ?? 0) + (status.pending?.length ?? 0) + (status.rejected?.length ?? 0))),
                    const SizedBox(height: 8),
                    LegendRow(color: AppColors.accent, label: 'Nieukończone', value: '${status.pending?.length ?? 0}', percent: _percent(status.pending?.length ?? 0, (status.done?.length ?? 0) + (status.pending?.length ?? 0) + (status.rejected?.length ?? 0))),
                    const SizedBox(height: 8),
                    LegendRow(color: Colors.grey.shade500, label: 'Odrzucone', value: '${status.rejected?.length ?? 0}', percent: _percent(status.rejected?.length ?? 0, (status.done?.length ?? 0) + (status.pending?.length ?? 0) + (status.rejected?.length ?? 0))),
                    const SizedBox(height: 12),
                    ExpansionTile(title: const Text('Nieukończone (pending)'), children: (status.pending ?? []).map((p) => ListTile(title: Text('${p.employeeFirstName ?? ''} ${p.employeeLastName ?? ''}'), subtitle: Text(p.actionUrl ?? ''))).toList()),
                    ExpansionTile(title: const Text('Ukończone (done)'), children: (status.done ?? []).map((p) => ListTile(title: Text('${p.employeeFirstName ?? ''} ${p.employeeLastName ?? ''}'), subtitle: Text(p.actionUrl ?? ''))).toList()),
                    ExpansionTile(title: const Text('Odrzucone (rejected)'), children: (status.rejected ?? []).map((p) => ListTile(title: Text('${p.employeeFirstName ?? ''} ${p.employeeLastName ?? ''}'), subtitle: Text(p.actionUrl ?? ''))).toList()),
                  ]),
                ),
              ),
            ]),
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Zamknij'))],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Statystyki', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, decoration: TextDecoration.none)),
            const SizedBox(height: 6),
            const Text('Analiza wydajności i skuteczności zadań', style: TextStyle(color: Colors.grey, decoration: TextDecoration.none)),
            const SizedBox(height: 16),

            Expanded(
              child: _loading
                ? const Center(child: CircularProgressIndicator())
                : (_error != null)
                  ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Błąd: $_error', style: const TextStyle(color: Colors.red)), const SizedBox(height: 8), ElevatedButton(onPressed: _fetchAll, child: const Text('Ponów'))]))
                  : SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        // channel preferences (counts) section
                        Container(padding: const EdgeInsets.all(12), decoration: cardDecoration(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('Preferencje kanałów', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          if ((_stats?.channelPreferences ?? []).isEmpty) const Text('Brak danych')
                          else ...[
                            // donut chart showing counts per channel
                            SizedBox(
                              height: 200,
                              child: Center(
                                child: DonutChart(
                                  segments: Map.fromEntries(_stats!.channelPreferences!.map((s) => MapEntry(s.channel.toString().split('.').last, (s.employees).toDouble()))),
                                  colors: [AppColors.primary, AppColors.accent, Colors.grey.shade500, Colors.blueGrey],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // legend rows showing count and percent
                            ..._stats!.channelPreferences!.map((s) {
                              final total = _stats!.channelPreferences!.fold<int>(0, (p, e) => p + e.employees);
                              final label = s.channel.toString().split('.').last;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: LegendRow(
                                  color: label == 'email' ? AppColors.primary : (label == 'sms' ? AppColors.accent : Colors.grey.shade500),
                                  label: label,
                                  value: '${s.employees}',
                                  percent: _percent(s.employees, total),
                                ),
                              );
                            })
                          ]
                        ])),

                        const SizedBox(height: 16),

                        // events list with participants-status action
                        Container(padding: const EdgeInsets.all(12), decoration: cardDecoration(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('Wydarzenia', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          if (_events.isEmpty) const Text('Brak wydarzeń')
                          else ..._events.map((e) => ListTile(title: Text(e.title), subtitle: Text(e.category.name.toString().split('.').last), trailing: TextButton(onPressed: () => _selectEvent(e), child: const Text('Szczegóły'))))
                        ])),
                        const SizedBox(height: 16),

                        // move summary metrics to bottom
                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(child: _summaryCard(AppColors.primary, 'Aktywne zadania', '${_stats?.activeTasksCount ?? '-'}', 'Zadania o statusie NEW')),
                          const SizedBox(width: 12),
                          Expanded(child: _summaryCard(AppColors.accent, 'Zaległe zadania', '${_stats?.overdueTasksCount ?? '-'}', 'Deadline przeterminowany')),
                          const SizedBox(width: 12),
                          Expanded(child: _summaryCard(AppColors.primary, 'Wskaźnik ukończenia', '${(_stats?.completionPercentage ?? 0).toStringAsFixed(1)}%', 'DONE / total')),
                          const SizedBox(width: 12),
                          Expanded(child: _summaryCard(AppColors.primary, 'Aktywni użytkownicy', '${_stats?.activeEmployeesCount ?? '-'}', 'Liczba pracowników')),
                        ]),
                      ]),
                    ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _summaryCard(Color bg, String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
  // gradient created by using the provided color and a slightly transparent variant
  decoration: BoxDecoration(gradient: LinearGradient(colors: [bg, bg.withAlpha((0.9 * 255).round())]), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: Colors.white70))
      ]),
    );
  }
}

String _percent(int part, int total) {
  if (total <= 0) return '0%';
  final pct = (part / total) * 100;
  return '${pct.toStringAsFixed(pct % 1 == 0 ? 0 : 0)}%';
}

class LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percent;

  const LegendRow({super.key, required this.color, required this.label, required this.value, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
        Row(children: [Text(percent, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(width: 12), Text(value)])
      ]),
    );
  }
}

class DonutChart extends StatelessWidget {
  final Map<String, double> segments;
  final List<Color> colors;

  const DonutChart({super.key, required this.segments, required this.colors});

  @override
  Widget build(BuildContext context) {
    final total = segments.values.fold<double>(0, (p, e) => p + e);
    return SizedBox(
      width: 220,
      height: 220,
      child: CustomPaint(
        painter: _DonutPainter(segments: segments, colors: colors, total: total),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final Map<String, double> segments;
  final List<Color> colors;
  final double total;

  _DonutPainter({required this.segments, required this.colors, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.28;
    var startAngle = -math.pi / 2;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.butt;

    final entries = segments.entries.toList();
    for (var i = 0; i < entries.length; i++) {
      final value = entries[i].value;
      final sweep = total <= 0 ? 0.0 : (value / total) * math.pi * 2;
      paint.color = i < colors.length ? colors[i] : Colors.primaries[i % Colors.primaries.length];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), startAngle, sweep, false, paint);
      startAngle += sweep;
    }

    // inner circle cutout to make donut
    final innerPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - strokeWidth - 2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

