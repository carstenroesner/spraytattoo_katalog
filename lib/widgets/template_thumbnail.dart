import 'package:flutter/material.dart';

import '../models/tattoo_template.dart';

/// Platzhalter-Vorschaubild für eine Vorlage, solange keine echten
/// Schablonen-Fotos hinterlegt sind. Sobald echte Bilder vorhanden sind,
/// kann dieses Widget einfach durch Image.asset(...)/Image.network(...)
/// ersetzt werden — die Nummer-Badge bleibt dabei erhalten.
class TemplateThumbnail extends StatelessWidget {
  final TattooTemplate template;
  final double iconSize;

  const TemplateThumbnail({
    super.key,
    required this.template,
    this.iconSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    final color = template.category.color;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.85), color],
            ),
          ),
          child: Center(
            child: Icon(template.category.icon, size: iconSize, color: Colors.white),
          ),
        ),
        Positioned(
          left: 6,
          top: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              template.templateNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
