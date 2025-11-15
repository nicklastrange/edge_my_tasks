import 'package:flutter/material.dart';
import '../styles.dart';

// Prototype-alike EventListItem styling: big title with accent underline

class EventListItem extends StatelessWidget {
  final String title;
  final String category;
  final List<String> groups;

  const EventListItem({super.key, required this.title, required this.category, required this.groups});

  factory EventListItem.fromMap(Map m) => EventListItem(
        title: m['title'] as String,
        category: (() {
          final v = m['category'];
          if (v is String) return v;
          if (v == null) return '';
          return v.toString().split('.').last;
        })(),
        groups: (m['groups'] as List<dynamic>).cast<String>()
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Title row with large red title and small category pill
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.dark, decoration: TextDecoration.none)),
                  // spacer (underline removed)
                  const SizedBox(height: 4),
                ])),
                const SizedBox(width: 8),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color.fromRGBO(240, 160, 32, 0.15), borderRadius: BorderRadius.circular(8)), child: Text(category, style: const TextStyle(color: Color(0xFFF0A020), fontSize: 12, decoration: TextDecoration.none))),
              ]),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: groups.map((g) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color.fromRGBO(27, 78, 155, 0.08), borderRadius: BorderRadius.circular(8)), child: Text(g, style: const TextStyle(color: Color(0xFF1B4E9B), fontSize: 12, decoration: TextDecoration.none)))).toList()),
            ]),
          ),
        ],
      ),
    );
  }
}
