import 'package:flutter/material.dart';
import '../styles.dart';

class TaskCard extends StatelessWidget {
  final String id;
  final String eventTitle;
  final String categoryName;
  final DateTime? deadline;
  final DateTime? createdAt;
  final String? actionUrl;
  final void Function(String) onPrimary;
  final void Function(String) onSecondary;

  const TaskCard({super.key, required this.id, required this.eventTitle, required this.categoryName, this.deadline, this.createdAt, this.actionUrl, required this.onPrimary, required this.onSecondary});

  factory TaskCard.fromMap(Map m, {required void Function(String) onPrimary, required void Function(String) onSecondary}) {
    // Safe parsing for deadline/createdAt: support DateTime or ISO-8601 strings or null
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is String) return DateTime.tryParse(v);
      return null;
    }

    return TaskCard(
      id: m['id'] as String,
      eventTitle: m['eventTitle'] as String,
      categoryName: m['categoryName'] as String,
      deadline: parseDate(m['deadline']),
      createdAt: parseDate(m['createdAt']),
      actionUrl: m['actionUrl'] as String?,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Text(categoryName, style: const TextStyle(fontSize: 12, color: Colors.black54, decoration: TextDecoration.none))),
            const SizedBox(height: 8),
            Text(eventTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, decoration: TextDecoration.none)),
            const SizedBox(height: 8),
            if (deadline != null)
              Text('do ${deadline!.day}.${deadline!.month}', style: const TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.none))
            else
              const Text('brak terminu', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ]),
        ),
        const SizedBox(width: 12),
        Row(children: [
          ElevatedButton(onPressed: () => onPrimary(id), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: const Text('Rozliczam', style: TextStyle(color: Colors.white),)),
          const SizedBox(width: 12),
          OutlinedButton(onPressed: () => onSecondary(id), style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF1B4E9B)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: const Text('Odrzucam', style: TextStyle(color: Colors.black),)),
        ])
      ]),
    );
  }
}
