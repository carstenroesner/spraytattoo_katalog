import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spraytattoo_katalog/main.dart';
import 'package:spraytattoo_katalog/screens/catalog_screen.dart';

void main() {
  testWidgets('App startet und zeigt den Katalog-Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SprayTattooApp());
    await tester.pumpAndSettle();

    expect(find.byType(CatalogScreen), findsOneWidget);
    expect(find.text('Vorlagen-Katalog'), findsOneWidget);
  });
}
