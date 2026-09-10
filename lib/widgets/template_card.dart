import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tattoo_template.dart';
import '../services/wishlist_service.dart';
import 'template_thumbnail.dart';

/// Eine Kachel im Katalog-Grid: Thumbnail, Name, Preis und
/// Wunschlisten-Stern zum schnellen Hinzufügen/Entfernen.
class TemplateCard extends StatelessWidget {
  final TattooTemplate template;
  final VoidCallback onTap;

  const TemplateCard({super.key, required this.template, required this.onTap});

  void _handleToggle(BuildContext context) {
    final wishlist = context.read<WishlistService>();
    final wasInWishlist = wishlist.contains(template);
    final result = wishlist.toggle(template);

    if (result == AddToWishlistResult.limitReached) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
            'Du kannst maximal ${WishlistService.maxItems} Vorlagen auf die Wunschliste legen.',
          ),
        ));
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          wasInWishlist
              ? '${template.name} von der Wunschliste entfernt'
              : '${template.name} zur Wunschliste hinzugefügt',
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final isInWishlist = context.select<WishlistService, bool>(
      (service) => service.contains(template),
    );

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  TemplateThumbnail(template: template),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: _WishlistToggleButton(
                      isActive: isInWishlist,
                      onPressed: () => _handleToggle(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        template.category.label,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      Text(
                        template.formattedPrice,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
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

class _WishlistToggleButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const _WishlistToggleButton({required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      shape: const CircleBorder(),
      child: IconButton(
        iconSize: 20,
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        icon: Icon(
          isActive ? Icons.star : Icons.star_border,
          color: isActive ? Colors.amber[700] : Colors.grey[700],
        ),
      ),
    );
  }
}
