import 'package:flutter/material.dart';
import 'components/task_tabs.dart';
import 'components/filter_chips.dart';
import 'components/task_card.dart';
import 'styles.dart';
import 'preferences.dart';
import 'components/notification_preview.dart';

import '../Repository/Http/http_tasks_management_repository.dart';

class EmployeeHomeView extends StatefulWidget {
  final String? userId;
  const EmployeeHomeView({super.key, this.userId});

  @override
  State<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<EmployeeHomeView> {
  String activeTab = 'todo';
  List<String> activeFilters = [];
  int notificationCount = 3;
  bool showNotification = false;

  List<Map<String, dynamic>> tasks = [];
  bool _loading = true;
  String? _error;
  late HttpTasksManagementRepository _tasksRepo;
  final Set<String> _inProgressActions = {};

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final baseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');
      _tasksRepo = HttpTasksManagementRepository(baseUrl: baseUrl, userId: widget.userId);
      final list = await _tasksRepo.getTasks();

      // Map Task objects to the shape expected by TaskCard.fromMap
      tasks = list.map((t) {
            // Map backend status to UI-friendly status
            final backendStatus = (t.status ?? 'NEW').toUpperCase();
            String uiStatus;
            switch (backendStatus) {
              case 'DONE':
                uiStatus = 'completed';
                break;
              case 'REJECTED':
                uiStatus = 'rejected';
                break;
              case 'NEW':
              default:
                uiStatus = 'pending';
            }

            // category may be an enum value (CategoryDto) or string; coerce to a simple label
            final rawCategory = t.event?.category.name;
            String categoryLabel;
            if (rawCategory == null) {
              categoryLabel = '-';
            } else {
              categoryLabel = rawCategory.toString().split('.').last;
            }

            return {
              'id': t.id,
              'status': uiStatus,
              'employeeId': t.employeeId,
              'eventTitle': t.event?.title ?? 'Wydarzenie',
              'categoryName': categoryLabel,
              'deadline': t.deadline,
              'createdAt': t.createdAt,
              'actionUrl': t.actionUrl,
            };
          }).toList();

      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  void toggleFilter(String f) {
    setState(() {
      if (activeFilters.contains(f)) {
        activeFilters.remove(f);
      } else {
        activeFilters.add(f);
      }
    });
  }

  void primaryAction(String id) async {
    if (_inProgressActions.contains(id)) return;
    _inProgressActions.add(id);

    // optimistic update
    final prevTask = tasks.firstWhere((t) => t['id'] == id, orElse: () => <String, dynamic>{'status': 'pending'});
    final prev = prevTask['status'];
    setState(() {
      tasks = tasks.map((t) => t['id'] == id ? {...t, 'status': 'completed'} : t).toList();
    });

    try {
      await _tasksRepo.markDone(id);
    } catch (e) {
      // revert
      setState(() {
        tasks = tasks.map((t) => t['id'] == id ? {...t, 'status': prev} : t).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Błąd podczas oznaczania zadania jako wykonane: $e')));
    } finally {
      _inProgressActions.remove(id);
    }
  }

  void secondaryAction(String id) async {
    if (_inProgressActions.contains(id)) return;
    _inProgressActions.add(id);

    final prevTask = tasks.firstWhere((t) => t['id'] == id, orElse: () => <String, dynamic>{'status': 'pending'});
    final prev = prevTask['status'];
    setState(() {
      tasks = tasks.map((t) => t['id'] == id ? {...t, 'status': 'rejected'} : t).toList();
    });

    try {
      await _tasksRepo.rejectTask(id);
    } catch (e) {
      setState(() {
        tasks = tasks.map((t) => t['id'] == id ? {...t, 'status': prev} : t).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Błąd podczas odrzucania zadania: $e')));
    } finally {
      _inProgressActions.remove(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // derive filters dynamically from tasks' categoryName values
    final derived = tasks.map((t) => (t['categoryName'] as String?) ?? '-').where((s) => s != '-' && s.isNotEmpty).toSet().toList();
    // prefer a stable, friendly ordering if common categories are present
    final preferredOrder = ['HR', 'Obowiązkowe', 'Rozrywka', 'Finanse'];
    final filters = [
      ...preferredOrder.where((p) => derived.contains(p)),
      ...derived.where((d) => !preferredOrder.contains(d))
    ];

    final filteredTasks = tasks.where((task) {
      if (activeTab == 'todo' && task['status'] != 'pending') return false;
      if (activeTab == 'done' && task['status'] == 'pending') return false;
      if (activeFilters.isNotEmpty && !activeFilters.contains(task['categoryName'])) return false;
      return true;
    }).toList();

    final todoCount = tasks.where((t) => t['status'] == 'pending').length;
    final doneCount = tasks.where((t) => t['status'] != 'pending').length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [
        // Top bar with role pills and bell
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const SizedBox(width: 8),
                ]),
                IconButton(
                  onPressed: () => setState(() => showNotification = true),
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications),
                      if (notificationCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(radius: 8, backgroundColor: AppColors.accent, child: Text('$notificationCount', style: const TextStyle(fontSize: 10, color: Colors.white))),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kPagePadding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Tab bar
              TaskTabs(activeTab: activeTab, onTabChange: (v) => setState(() => activeTab = v), todoCount: todoCount, doneCount: doneCount),
              const SizedBox(height: 12),
              // Category filters
              FilterChips(filters: filters, activeFilters: activeFilters, onToggle: toggleFilter),
              const SizedBox(height: 16),

              // Tasks grid
              if (_loading)
                const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 24), child: CircularProgressIndicator()))
              else if (_error != null)
                Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Column(children: [Text('Błąd: $_error', style: const TextStyle(color: Colors.red)), const SizedBox(height: 8), ElevatedButton(onPressed: _fetchTasks, child: const Text('Ponów'))])))
              else if (filteredTasks.isEmpty)
                Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Text(activeTab == 'todo' ? 'Brak zadań do wykonania' : 'Brak wykonanych zadań', style: const TextStyle(color: Colors.grey))))
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredTasks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1, mainAxisExtent: 160, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    final t = filteredTasks[index];
                    return TaskCard.fromMap(t, onPrimary: primaryAction, onSecondary: secondaryAction);
                  },
                ),
            ]),
          ),
        )
      ]),
      // Notification preview overlay + settings FAB
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showNotification)
            NotificationPreview(
              title: 'Przypomnienie z Eosic',
              body: "Zadanie '${tasks.first['eventTitle']}' wygasa za 3 godziny.",
              ctaText: 'Wykonaj teraz',
              onCta: () {
                setState(() {
                  showNotification = false;
                  notificationCount = (notificationCount - 1).clamp(0, 999);
                });
              },
              onDismiss: () => setState(() => showNotification = false),
              isVisible: true,
            ),
          Positioned(
            bottom: 0,
            right: 0,
              child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PreferencesPage(userId: widget.userId)));
              },
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
