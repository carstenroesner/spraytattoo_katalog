import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tattoo_template.dart';
import '../services/wishlist_service.dart';
import '../widgets/template_thumbnail.dart';

/// Detailansicht einer einzelnen Vorlage mit Beschreibung, Preis,
/// Schablonen-Nummer und Wunschlisten-Button.
class TemplateDetailScreen extends StatelessWidget {
  final TattooTemplate template;

  const TemplateDetailScreen({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistService>();
    final isInWishlist = wishlist.contains(template);

    return Scaffold(
      appBar: AppBar(title: Text(template.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 260,
              child: TemplateThumbnail(template: template, iconSize: 96),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          template.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        template.formattedPrice,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    avatar: Icon(template.category.icon, size: 18),
                    label: Text(template.category.label),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.confirmation_number_outlined, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Schablonen-Nr.: ${template.templateNumber}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Diese Nummer nennst du dem Sprayer vor Ort, damit er die '
                    'passende physische Schablone findet.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Text(template.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 28),
                  FilledButton.icon(
                    onPressed: () {
                      final result = wishlist.toggle(template);
                      if (result == AddToWishlistResult.limitReached) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Du kannst maximal ${WishlistService.maxItems} '
                              'Vorlagen auf die Wunschliste legen.',
                            ),
                          ));
                      }
                    },
                    icon: Icon(isInWishlist ? Icons.star : Icons.star_border),
                    label: Text(
                      isInWishlist
                          ? 'Von der Wunschliste entfernen'
                          : 'Zur Wunschliste hinzufügen',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
