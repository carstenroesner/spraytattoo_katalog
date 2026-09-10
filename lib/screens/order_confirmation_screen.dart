import 'package:flutter/material.dart';

import '../services/wishlist_service.dart';

/// Bestätigungsseite nach dem Kauf: zeigt Bestellnummer, Preis und vor
/// allem die Schablonen-Nummern, damit der Sprayer die richtigen
/// physischen Schablonen findet.
class OrderConfirmationScreen extends StatelessWidget {
  final PurchaseOrder order;

  const OrderConfirmationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bestellung abgeschlossen'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 72),
              const SizedBox(height: 16),
              Text(
                'Danke für deinen Kauf!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Bestellnummer: ${order.orderNumber}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zeige dem Sprayer diese Schablonen-Nummern:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final template in order.templates)
                            Chip(
                              avatar: const Icon(Icons.confirmation_number_outlined, size: 18),
                              label: Text(
                                '${template.templateNumber} – ${template.name}',
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gesamt', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '${order.total.toStringAsFixed(2)} €',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Zurück zum Katalog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
