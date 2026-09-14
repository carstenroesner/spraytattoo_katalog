import 'package:flutter/material.dart';

import '../content/feature_overview_content.dart';

/// Zeigt den Funktionsumfang der App an — inhaltlich deckungsgleich mit
/// FUNKTIONSUMFANG.md im Repository.
class FeatureOverviewScreen extends StatelessWidget {
  const FeatureOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Funktionsumfang')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(featureOverviewIntro, style: textTheme.bodyLarge),
          const SizedBox(height: 20),
          for (final section in featureOverviewSections) ...[
            Text(
              section.title,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final point in section.points) _BulletPoint(text: point),
            const SizedBox(height: 20),
          ],
          Text(
            'Aktueller Stand / bekannte Einschränkungen',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final point in featureOverviewKnownLimitations) _BulletPoint(text: point),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Automatisch aktualisierte Web-Vorschau: '
              'carstenroesner.github.io/spraytattoo_katalog',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6),
          ),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
