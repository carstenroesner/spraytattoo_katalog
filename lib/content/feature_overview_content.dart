/// Inhalt für den "Funktionsumfang"-Screen in der App.
///
/// Fachlich deckungsgleich mit FUNKTIONSUMFANG.md im Projekt-Root — Änderungen
/// bitte an beiden Stellen nachziehen.
class FeatureSection {
  final String title;
  final List<String> points;

  const FeatureSection({required this.title, required this.points});
}

const String featureOverviewIntro =
    'Diese App richtet sich an Kund:innen, die vor Ort (z. B. auf einem Markt, '
    'Festival oder im Shop) eine Spraytattoo-Vorlage auswählen und kaufen '
    'möchten, bevor sie zum Sprayer gehen.';

const List<FeatureSection> featureOverviewSections = [
  FeatureSection(
    title: '1. Katalog durchblättern',
    points: [
      'Alle Vorlagen werden als Kachel-Raster mit Vorschaubild angezeigt.',
      'Filter nach Kategorie: Tribal, Tier, Blumen, Schriftzug, Symbol, Fantasie.',
      'Auf einen Blick sichtbar: Name, Kategorie, Preis und Schablonen-Nummer.',
      'Detailansicht mit größerem Bild, Beschreibung, Preis und Nummer.',
    ],
  ),
  FeatureSection(
    title: '2. Wunschliste',
    points: [
      'Bis zu 5 Vorlagen gleichzeitig auf die Wunschliste legen (Stern-Symbol).',
      'Bei erreichtem Limit weist die App darauf hin, zuerst etwas zu entfernen.',
      'Anzeige aller gewählten Vorlagen mit Einzel- und Gesamtpreis.',
      'Einzelne Vorlagen lassen sich jederzeit wieder entfernen.',
    ],
  ),
  FeatureSection(
    title: '3. Kaufabschluss',
    points: [
      '"Zur Kasse" öffnet einen Bestätigungsdialog mit Anzahl und Gesamtpreis.',
      'Nach Bestätigung: Bestellbestätigung mit fortlaufender Bestellnummer.',
      'Die Wunschliste wird nach dem Kauf automatisch geleert.',
    ],
  ),
  FeatureSection(
    title: '4. Schablonen-Nummer',
    points: [
      'Jede Vorlage hat eine eindeutige Schablonen-Nummer (z. B. SPT-007).',
      'Sichtbar im Katalog, in der Detailansicht und auf der Bestellbestätigung.',
      'Zweck: Der Sprayer findet damit die passende physische Schablone.',
    ],
  ),
  FeatureSection(
    title: '5. Diese Übersicht',
    points: [
      'Über das Menü (⋮) auf dem Katalog-Bildschirm erreichbar.',
      'Zeigt denselben Funktionsumfang wie FUNKTIONSUMFANG.md im Repository.',
    ],
  ),
];

const List<String> featureOverviewKnownLimitations = [
  'Vorschaubilder sind aktuell farbige Platzhalter mit Kategorie-Icon.',
  'Der Katalog besteht aus 16 Beispiel-Vorlagen (Mock-Daten), noch kein Backend.',
  'Der Kaufabschluss ist simuliert, es gibt noch keine echte Zahlungsabwicklung.',
];
