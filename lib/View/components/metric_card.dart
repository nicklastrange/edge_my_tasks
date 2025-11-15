import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const MetricCard({super.key, required this.title, required this.value, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    // Use a colored background with white text to match prototype
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.white70, decoration: TextDecoration.none), overflow: TextOverflow.ellipsis)),
            // small icon placeholder
            const Icon(Icons.check, color: Colors.white24, size: 20),
          ]),
          const SizedBox(height: 8),
          // make the large value scale down when vertical space is tight
          Flexible(
            fit: FlexFit.loose,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.none)),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(child: Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.white70, decoration: TextDecoration.none), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
