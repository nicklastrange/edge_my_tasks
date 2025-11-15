import 'package:flutter/material.dart';
import 'styles.dart';

class EmployeeManagementPage extends StatefulWidget {
  const EmployeeManagementPage({super.key});

  @override
  State<EmployeeManagementPage> createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  String searchQuery = '';
  String selectedGroup = 'all';

  final employees = [
    {'id': '1', 'displayName': 'Jan Kowalski', 'position': 'Senior Developer', 'groups': ['Dział IT', 'Wszyscy pracownicy']},
    {'id': '2', 'displayName': 'Anna Nowak', 'position': 'Marketing Manager', 'groups': ['Marketing', 'Wszyscy pracownicy']},
    {'id': '3', 'displayName': 'Piotr Wiśniewski', 'position': 'Sales Representative', 'groups': ['Dział sprzedaży', 'Wszyscy pracownicy']},
    {'id': '4', 'displayName': 'Maria Dąbrowska', 'position': 'HR Specialist', 'groups': ['HR', 'Wszyscy pracownicy']},
    {'id': '5', 'displayName': 'Tomasz Lewandowski', 'position': 'CEO', 'groups': ['Zarząd', 'Wszyscy pracownicy']},
  ];

  final groups = ['all', 'Wszyscy pracownicy', 'Dział IT', 'Dział sprzedaży', 'Marketing', 'Zarząd', 'HR'];

  @override
  Widget build(BuildContext context) {
    final filtered = employees.where((emp) {
      final display = emp['displayName'] as String? ?? '';
      final position = emp['position'] as String? ?? '';
      final matchesSearch = display.toLowerCase().contains(searchQuery.toLowerCase()) || position.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGroup = selectedGroup == 'all' || (emp['groups'] as List).contains(selectedGroup);
      return matchesSearch && matchesGroup;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Zarządzanie pracownikami', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              const Text('Przeglądaj i zarządzaj grupami pracowników', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              // Actions card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: cardDecoration(),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => searchQuery = v),
                          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Szukaj pracownika...', border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.person_add, color: Colors.white), label: const Text('Dodaj pracownika', style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
                    ]),
                    const SizedBox(height: 12),
                    Wrap(spacing: 8, children: groups.map((g) => ChoiceChip(label: Text(g == 'all' ? 'Wszystkie grupy' : g), selected: selectedGroup == g, onSelected: (_) => setState(() => selectedGroup = g))).toList()),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Employee list card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Pracownicy (${filtered.length})', style: const TextStyle(fontWeight: FontWeight.w600)), const Icon(Icons.group, color: AppColors.primary)]),
                    const SizedBox(height: 12),
                    if (filtered.isEmpty)
                      Container(padding: const EdgeInsets.symmetric(vertical: 24), alignment: Alignment.center, child: const Text('Nie znaleziono pracowników', style: TextStyle(color: Colors.grey)))
                    else
                      Column(
                        children: filtered.map((employee) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(employee['displayName'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(employee['position'] as String, style: const TextStyle(color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Wrap(spacing: 6, children: (employee['groups'] as List).map((g) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0x1A1B4E9B), borderRadius: BorderRadius.circular(8)), child: Text(g as String, style: const TextStyle(color: Color(0xFF1B4E9B), fontSize: 12)))).toList()),
                                  ]),
                                ),
                                Row(children: [
                                  TextButton(onPressed: () {}, style: TextButton.styleFrom(side: const BorderSide(color: AppColors.primary), foregroundColor: AppColors.primary), child: const Text('Edytuj')),
                                  const SizedBox(width: 8),
                                  ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('Zobacz zadania', style: TextStyle(color: Colors.white),))
                                ])
                              ],
                            ),
                          );
                        }).toList(),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
