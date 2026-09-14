# Funktionsbeschreibung – SprayTattoo Katalog

Diese App richtet sich an Kund:innen, die vor Ort (z. B. auf einem Markt, Festival
oder im Shop) eine Spraytattoo-Vorlage auswählen und kaufen möchten, bevor sie zum
Sprayer gehen.

## 1. Katalog durchblättern

- Alle verfügbaren Vorlagen werden als Kachel-Raster mit Vorschaubild (Thumbnail)
  angezeigt.
- Die Vorlagen lassen sich nach Kategorie filtern: Tribal, Tier, Blumen,
  Schriftzug, Symbol, Fantasie, Ski, Bike, Bob, Getränke.
- Zu jeder Vorlage sind auf einen Blick sichtbar: Name, Kategorie, Preis und
  Schablonen-Nummer.
- Ein Tippen auf eine Vorlage öffnet die Detailansicht mit größerem Vorschaubild,
  ausführlicher Beschreibung, Preis und Schablonen-Nummer.

## 2. Wunschliste

- Kund:innen können aus dem Katalog **bis zu 5 Vorlagen** gleichzeitig auf eine
  Wunschliste legen (Stern-Symbol zum Hinzufügen/Entfernen).
- Ist das Limit erreicht, weist die App darauf hin, dass zuerst eine Vorlage
  entfernt werden muss, bevor eine weitere hinzugefügt werden kann.
- Die Wunschliste zeigt alle gewählten Vorlagen samt Einzelpreisen und
  Gesamtpreis; einzelne Vorlagen lassen sich jederzeit wieder entfernen.

## 3. Kaufabschluss

- Über den Button "Zur Kasse" wird der Kauf mit einem Bestätigungsdialog
  (Anzahl der Vorlagen, Gesamtpreis) abgeschlossen.
- Nach der Bestätigung erhält die Kundschaft eine Bestellbestätigung mit
  fortlaufender Bestellnummer und der Gesamtsumme.
- Die Wunschliste wird nach dem Kauf automatisch geleert.

## 4. Schablonen-Nummer

- Jede Vorlage besitzt eine eindeutige Schablonen-Nummer (z. B. `SPT-007`).
- Diese Nummer wird im Katalog, in der Detailansicht und auf der
  Bestellbestätigung angezeigt.
- Zweck: Die Kund:in nennt dem Sprayer vor Ort diese Nummer(n), damit er die
  passende **physische** Schablone im Bestand schnell und eindeutig findet.

## 5. Funktionsumfang in der App einsehen

- Über das Menü (⋮) auf dem Katalog-Bildschirm ist der Menüpunkt
  "Funktionsumfang" erreichbar.
- Dort wird genau diese Funktionsbeschreibung direkt in der App angezeigt, damit
  Nutzer:innen und das Entwicklungsteam jederzeit nachvollziehen können, was die
  App aktuell leistet.

## Aktueller Stand / bekannte Einschränkungen

- Die Vorschaubilder sind aktuell farbige Platzhalter mit Kategorie-Icon, da noch
  keine echten Fotos der Schablonen vorliegen.
- Der Katalog besteht aus 46 Beispiel-Vorlagen (Mock-Daten), u. a. eine
  Themenerweiterung rund um Winterberg (Ski, Bike, Bob, Getränke); eine
  Anbindung an ein echtes Backend ist noch nicht umgesetzt.
- Das "W-Monogramm Wintersport" (SPT-017) ist ein eigenständiges Design und
  kein Abbild eines echten Stadt- oder Vereinslogos.
- Der Kaufabschluss ist simuliert; es findet noch keine echte Zahlungsabwicklung
  statt.
- Eine automatisch aktualisierte Web-Vorschau der App ist unter
  <https://carstenroesner.github.io/spraytattoo_katalog/> erreichbar (wird bei
  jedem Push auf `master` per GitHub Actions neu gebaut und veröffentlicht).
