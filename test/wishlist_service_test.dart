import 'package:flutter_test/flutter_test.dart';
import 'package:spraytattoo_katalog/models/mock_catalog.dart';
import 'package:spraytattoo_katalog/services/wishlist_service.dart';

void main() {
  group('WishlistService', () {
    test('fügt Vorlagen bis zum Limit hinzu', () {
      final wishlist = WishlistService();

      for (var i = 0; i < WishlistService.maxItems; i++) {
        final result = wishlist.add(mockCatalog[i]);
        expect(result, AddToWishlistResult.added);
      }

      expect(wishlist.count, WishlistService.maxItems);

      final overLimitResult = wishlist.add(mockCatalog[WishlistService.maxItems]);
      expect(overLimitResult, AddToWishlistResult.limitReached);
      expect(wishlist.count, WishlistService.maxItems);
    });

    test('verhindert doppelte Einträge', () {
      final wishlist = WishlistService();
      wishlist.add(mockCatalog[0]);
      final result = wishlist.add(mockCatalog[0]);

      expect(result, AddToWishlistResult.alreadyInWishlist);
      expect(wishlist.count, 1);
    });

    test('berechnet den Gesamtpreis korrekt', () {
      final wishlist = WishlistService();
      wishlist.add(mockCatalog[0]);
      wishlist.add(mockCatalog[1]);

      final expectedTotal = mockCatalog[0].price + mockCatalog[1].price;
      expect(wishlist.totalPrice, expectedTotal);
    });

    test('checkout leert die Wunschliste und liefert Schablonen-Nummern', () {
      final wishlist = WishlistService();
      wishlist.add(mockCatalog[0]);
      wishlist.add(mockCatalog[1]);

      final order = wishlist.checkout();

      expect(wishlist.count, 0);
      expect(order.templates.length, 2);
      expect(order.templateNumbers, [
        mockCatalog[0].templateNumber,
        mockCatalog[1].templateNumber,
      ]);
      expect(order.total, mockCatalog[0].price + mockCatalog[1].price);
    });
  });
}
