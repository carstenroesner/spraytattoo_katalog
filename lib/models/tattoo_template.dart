import 'package:flutter/material.dart';

/// Kategorie einer Spraytattoo-Vorlage, bestimmt u. a. Icon und Platzhalterfarbe.
enum TemplateCategory {
  tribal,
  tier,
  blumen,
  schriftzug,
  symbol,
  fantasie,
  ski,
  bike,
  bob,
  getraenke,
}

extension TemplateCategoryLabel on TemplateCategory {
  String get label {
    switch (this) {
      case TemplateCategory.tribal:
        return 'Tribal';
      case TemplateCategory.tier:
        return 'Tier';
      case TemplateCategory.blumen:
        return 'Blumen';
      case TemplateCategory.schriftzug:
        return 'Schriftzug';
      case TemplateCategory.symbol:
        return 'Symbol';
      case TemplateCategory.fantasie:
        return 'Fantasie';
      case TemplateCategory.ski:
        return 'Ski';
      case TemplateCategory.bike:
        return 'Bike';
      case TemplateCategory.bob:
        return 'Bob';
      case TemplateCategory.getraenke:
        return 'Getränke';
    }
  }

  IconData get icon {
    switch (this) {
      case TemplateCategory.tribal:
        return Icons.auto_awesome_motion;
      case TemplateCategory.tier:
        return Icons.pets;
      case TemplateCategory.blumen:
        return Icons.local_florist;
      case TemplateCategory.schriftzug:
        return Icons.text_fields;
      case TemplateCategory.symbol:
        return Icons.hexagon_outlined;
      case TemplateCategory.fantasie:
        return Icons.auto_fix_high;
      case TemplateCategory.ski:
        return Icons.downhill_skiing;
      case TemplateCategory.bike:
        return Icons.pedal_bike;
      case TemplateCategory.bob:
        return Icons.speed;
      case TemplateCategory.getraenke:
        return Icons.sports_bar;
    }
  }

  Color get color {
    switch (this) {
      case TemplateCategory.tribal:
        return const Color(0xFF37474F);
      case TemplateCategory.tier:
        return const Color(0xFF6D4C41);
      case TemplateCategory.blumen:
        return const Color(0xFFAD1457);
      case TemplateCategory.schriftzug:
        return const Color(0xFF283593);
      case TemplateCategory.symbol:
        return const Color(0xFF00695C);
      case TemplateCategory.fantasie:
        return const Color(0xFF6A1B9A);
      case TemplateCategory.ski:
        return const Color(0xFF0277BD);
      case TemplateCategory.bike:
        return const Color(0xFF2E7D32);
      case TemplateCategory.bob:
        return const Color(0xFF1A237E);
      case TemplateCategory.getraenke:
        return const Color(0xFFFF8F00);
    }
  }
}

/// Eine Spraytattoo-Vorlage aus dem Katalog.
///
/// [templateNumber] ist die eindeutige Schablonen-Nummer, mit der der
/// Sprayer die passende physische Schablone im Bestand wiederfindet.
@immutable
class TattooTemplate {
  final String id;
  final String templateNumber;
  final String name;
  final TemplateCategory category;
  final double price;
  final String description;

  /// Optionales, individuelles Vorschau-Icon für diese eine Vorlage.
  ///
  /// Ist keins gesetzt, fällt [effectiveIcon] auf das Standard-Icon der
  /// [category] zurück — so sehen ältere/unvollständige Einträge nie leer
  /// aus.
  final IconData? icon;

  const TattooTemplate({
    required this.id,
    required this.templateNumber,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    this.icon,
  });

  /// Das Icon, das im Katalog tatsächlich angezeigt wird: das individuelle
  /// [icon] der Vorlage, sonst das Kategorie-Standard-Icon.
  IconData get effectiveIcon => icon ?? category.icon;

  String get formattedPrice => '${price.toStringAsFixed(2)} €';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TattooTemplate && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
