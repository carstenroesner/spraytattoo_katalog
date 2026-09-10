# SprayTattoo Katalog

Flutter-App (Android/iOS), mit der Kund:innen aus einem Katalog von
Spraytattoo-Vorlagen browsen, bis zu 5 Favoriten auf eine Wunschliste legen
und diese kaufen können. Jede Vorlage hat eine Schablonen-Nummer, mit der
der Sprayer vor Ort die passende physische Schablone findet.

## Funktionen

- **Katalog**: Grid mit Thumbnails, Kategorie-Filter (Tribal, Tier, Blumen,
  Schriftzug, Symbol, Fantasie), Preis und Schablonen-Nummer pro Vorlage.
- **Detailansicht**: größere Vorschau, Beschreibung, Nummer, Preis.
- **Wunschliste**: maximal 5 Vorlagen gleichzeitig, mit Gesamtpreis und
  Entfernen-Option.
- **Kauf-Flow**: Bestätigungsdialog → Bestellbestätigung mit Bestellnummer
  und allen Schablonen-Nummern der gekauften Vorlagen.

Die Thumbnails sind aktuell farbige Platzhalter mit Kategorie-Icon (siehe
`lib/widgets/template_thumbnail.dart`) — sobald echte Fotos der Schablonen
vorliegen, ersetzt du dort einfach den Platzhalter durch `Image.asset(...)`
oder `Image.network(...)`. Die Katalogdaten liegen als einfache Dart-Liste
in `lib/models/mock_catalog.dart`; für den Produktivbetrieb würdest du das
durch einen Backend-/API-Aufruf ersetzen.

## Projektstruktur

```
lib/
  models/       Datenmodell (TattooTemplate) + Mock-Katalog
  services/     WishlistService (State Management mit ChangeNotifier)
  screens/      Katalog, Detail, Wunschliste, Bestellbestätigung, Navigation
  widgets/      Wiederverwendbare UI-Bausteine (Karte, Thumbnail)
  theme/        App-weites Farbschema
test/
  wishlist_service_test.dart   Unit-Tests für die Wunschlisten-Logik
```

## Erste Schritte

Diese Dateien enthalten nur den plattformunabhängigen Dart-Code
(`lib/`, `pubspec.yaml`, `test/`) — die Android-/iOS-Projektordner fehlen
noch, weil sie das Flutter-SDK generiert. So richtest du das Projekt lokal
ein (Flutter-SDK muss installiert sein: <https://docs.flutter.dev/get-started/install>):

```bash
cd spraytattoo_katalog

# Erzeugt android/, ios/ (und optional web/, macos/, ...)
flutter create --platforms=android,ios,web .

# Abhängigkeiten laden
flutter pub get

# App starten (Emulator/Simulator oder angeschlossenes Gerät)
flutter run

# Tests laufen lassen
flutter test
```

## Hinweis zu GitHub

Der Code wurde lokal erstellt, aber **nicht automatisch zu GitHub gepusht** —
diese Sitzung hat keinen verbundenen GitHub-Zugriff. Um das Projekt selbst
hochzuladen:

```bash
cd spraytattoo_katalog
git init
git add .
git commit -m "Initial commit: SprayTattoo Katalog App"
git branch -M main
git remote add origin https://github.com/<dein-benutzername>/<repo-name>.git
git push -u origin main
```

## Nächste mögliche Schritte

- Echte Vorlagen-Fotos statt Platzhalter einbinden.
- Backend/API für Katalogdaten und Bestellungen anbinden.
- Echte Zahlungsabwicklung (z. B. Stripe) statt des simulierten Kauf-Buttons.
- Bestellhistorie persistieren (z. B. mit `shared_preferences` oder einer
  Datenbank), aktuell wird die Wunschliste nach dem Kauf nur zurückgesetzt.
