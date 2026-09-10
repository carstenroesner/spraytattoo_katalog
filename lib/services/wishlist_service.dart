import 'package:flutter/foundation.dart';

import '../models/tattoo_template.dart';

/// Ergebnis eines Versuchs, eine Vorlage zur Wunschliste hinzuzufügen.
enum AddToWishlistResult { added, alreadyInWishlist, limitReached }

/// Verwaltet die Wunschliste des Nutzers: maximal [maxItems] Vorlagen,
/// aus denen später gekauft werden kann.
class WishlistService extends ChangeNotifier {
  static const int maxItems = 5;

  final List<TattooTemplate> _items = [];

  List<TattooTemplate> get items => List.unmodifiable(_items);

  int get count => _items.length;

  bool get isFull => _items.length >= maxItems;

  bool contains(TattooTemplate template) => _items.contains(template);

  double get totalPrice =>
      _items.fold(0, (sum, template) => sum + template.price);

  AddToWishlistResult add(TattooTemplate template) {
    if (_items.contains(template)) {
      return AddToWishlistResult.alreadyInWishlist;
    }
    if (isFull) {
      return AddToWishlistResult.limitReached;
    }
    _items.add(template);
    notifyListeners();
    return AddToWishlistResult.added;
  }

  void remove(TattooTemplate template) {
    if (_items.remove(template)) {
      notifyListeners();
    }
  }

  /// Fügt die Vorlage hinzu, falls noch nicht enthalten, entfernt sie
  /// andernfalls wieder. Praktisch für einen Herz-/Stern-Toggle-Button.
  AddToWishlistResult toggle(TattooTemplate template) {
    if (_items.contains(template)) {
      remove(template);
      return AddToWishlistResult.added; // wurde entfernt, kein Fehlerfall
    }
    return add(template);
  }

  /// Schließt den Kauf ab: erzeugt eine [PurchaseOrder] mit fortlaufender
  /// Bestellnummer und leert danach die Wunschliste.
  PurchaseOrder checkout() {
    final order = PurchaseOrder(
      orderNumber: _generateOrderNumber(),
      templates: List.unmodifiable(_items),
      total: totalPrice,
      timestamp: DateTime.now(),
    );
    _items.clear();
    notifyListeners();
    return order;
  }

  String _generateOrderNumber() {
    final now = DateTime.now();
    return 'BEST-${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch % 10000}';
  }
}

/// Abgeschlossene Bestellung: enthält alle Vorlagen-Nummern, damit der
/// Sprayer die passenden physischen Schablonen im Bestand findet.
@immutable
class PurchaseOrder {
  final String orderNumber;
  final List<TattooTemplate> templates;
  final double total;
  final DateTime timestamp;

  const PurchaseOrder({
    required this.orderNumber,
    required this.templates,
    required this.total,
    required this.timestamp,
  });

  List<String> get templateNumbers =>
      templates.map((t) => t.templateNumber).toList();
}
