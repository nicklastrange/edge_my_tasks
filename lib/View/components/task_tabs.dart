import 'package:flutter/material.dart';
import '../styles.dart';

class TaskTabs extends StatelessWidget {
  final String activeTab;
  final void Function(String) onTabChange;
  final int todoCount;
  final int doneCount;

  const TaskTabs({super.key, required this.activeTab, required this.onTabChange, required this.todoCount, required this.doneCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 6)]),
      padding: const EdgeInsets.all(6),
      child: Row(children: [
        Expanded(
            child: GestureDetector(onTap: () => onTabChange('todo'), child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: activeTab == 'todo' ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(12)), child: Center(child: Text('Do zrobienia ($todoCount)', style: TextStyle(color: activeTab == 'todo' ? Colors.white : AppColors.dark)))))),
        const SizedBox(width: 8),
        Expanded(child: GestureDetector(onTap: () => onTabChange('done'), child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: activeTab == 'done' ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(12)), child: Center(child: Text('Wykonane ($doneCount)', style: TextStyle(color: activeTab == 'done' ? Colors.white : AppColors.dark)))))),
      ]),
    );
  }
}
