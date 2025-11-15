import 'package:flutter/material.dart';
import '../styles.dart';

class NotificationPreview extends StatelessWidget {
  final String title;
  final String body;
  final String ctaText;
  final VoidCallback onCta;
  final VoidCallback onDismiss;
  final bool isVisible;

  const NotificationPreview({super.key, required this.title, required this.body, required this.ctaText, required this.onCta, required this.onDismiss, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Positioned(
      bottom: 88, // sits above settings FAB
      left: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 340,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 12, offset: const Offset(0, 6))]),
          child: Stack(children: [
            // blue vertical accent on left
            Positioned(
              left: -8,
              top: 0,
              bottom: 0,
              child: Container(width: 8, decoration: const BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.notifications, color: Colors.white)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text(body, style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(onPressed: onCta, style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Text(ctaText, style: const TextStyle(color: Colors.white))),
                    )
                  ]),
                ),
                // dismiss X
                IconButton(onPressed: onDismiss, icon: const Icon(Icons.close)),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
