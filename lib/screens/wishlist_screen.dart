import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tattoo_template.dart';
import '../services/wishlist_service.dart';
import '../widgets/template_thumbnail.dart';
import 'order_confirmation_screen.dart';

/// Zeigt die aktuell gewählten Vorlagen (max. [WishlistService.maxItems])
/// und ermöglicht den Kauf-Abschluss.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  Future<void> _confirmPurchase(BuildContext context, WishlistService wishlist) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kauf bestätigen'),
        content: Text(
          'Möchtest du ${wishlist.count} Vorlage(n) für '
          '${wishlist.totalPrice.toStringAsFixed(2)} € kaufen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Jetzt kaufen'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final order = wishlist.checkout();
    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => OrderConfirmationScreen(order: order)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistService>();
    final items = wishlist.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wunschliste (${wishlist.count}/${WishlistService.maxItems})'),
      ),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_border, size: 56, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'Noch keine Vorlagen ausgewählt.\n'
                      'Wähle bis zu ${WishlistService.maxItems} Vorlagen aus dem Katalog aus.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final template = items[index];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: SizedBox(
                            width: 56,
                            height: 56,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TemplateThumbnail(template: template, iconSize: 26),
                            ),
                          ),
                          title: Text(template.name),
                          subtitle: Text(
                            'Nr. ${template.templateNumber} · ${template.category.label}',
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                template.formattedPrice,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20,
                                icon: const Icon(Icons.close),
                                onPressed: () => wishlist.remove(template),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gesamt', style: Theme.of(context).textTheme.bodySmall),
                            Text(
                              '${wishlist.totalPrice.toStringAsFixed(2)} €',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: () => _confirmPurchase(context, wishlist),
                          icon: const Icon(Icons.shopping_bag_outlined),
                          label: const Text('Zur Kasse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
