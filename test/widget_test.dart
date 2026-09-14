import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spraytattoo_katalog/main.dart';
import 'package:spraytattoo_katalog/screens/catalog_screen.dart';
import 'package:spraytattoo_katalog/screens/splash_screen.dart';

void main() {
  testWidgets('App zeigt zunächst den Startbildschirm', (WidgetTester tester) async {
    await tester.pumpWidget(const SprayTattooApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Spray Tattoo'), findsOneWidget);

    // Den Splash-Timer noch ablaufen lassen, bevor der Test endet — sonst
    // meldet flutter_test einen noch ausstehenden Timer ("!timersPending").
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  });

  testWidgets('App wechselt nach dem Startbildschirm zum Katalog-Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SprayTattooApp());

    // Über die Dauer des Startbildschirms hinweg pumpen, damit der Timer in
    // SplashGate feuert (ein reiner Future.delayed-Timer plant für sich
    // genommen keinen neuen Frame, daher reicht ein bloßes pumpAndSettle()
    // hier nicht aus).
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.byType(CatalogScreen), findsOneWidget);
    expect(find.text('Vorlagen-Katalog'), findsOneWidget);
  });
}
