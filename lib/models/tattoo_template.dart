import 'package:flutter/material.dart';

/// Kategorie einer Spraytattoo-Vorlage, bestimmt u. a. Icon und Platzhalterfarbe.
enum TemplateCategory { tribal, tier, blumen, schriftzug, symbol, fantasie }

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

  const TattooTemplate({
    required this.id,
    required this.templateNumber,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
  });

  String get formattedPrice => '${price.toStringAsFixed(2)} €';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TattooTemplate && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
