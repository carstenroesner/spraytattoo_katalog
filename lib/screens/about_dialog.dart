import 'package:flutter/material.dart';

/// Zeigt ein Overlay-Fenster mit Copyright-Hinweis über die App an.
void showAboutAppDialog(BuildContext context) {
  final year = DateTime.now().year;

  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Über diese App'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spray Tattoo – Vorlagen-Katalog',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text('© $year Carsten Rösner'),
          const SizedBox(height: 4),
          const Text(
            'Alle Rechte vorbehalten.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Schließen'),
        ),
      ],
    ),
  );
}
