import 'package:flutter/material.dart';

import '../models/mock_catalog.dart';
import '../models/tattoo_template.dart';
import '../widgets/template_card.dart';
import 'feature_overview_screen.dart';
import 'template_detail_screen.dart';

/// Durchblätterbarer Katalog aller Spraytattoo-Vorlagen als Thumbnail-Grid,
/// mit Filter nach Kategorie.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  TemplateCategory? _selectedCategory;

  List<TattooTemplate> get _filteredCatalog {
    if (_selectedCategory == null) return mockCatalog;
    return mockCatalog
        .where((template) => template.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final templates = _filteredCatalog;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vorlagen-Katalog'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'funktionsumfang') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FeatureOverviewScreen()),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'funktionsumfang',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Funktionsumfang'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              children: [
                _CategoryChip(
                  label: 'Alle',
                  selected: _selectedCategory == null,
                  onSelected: () => setState(() => _selectedCategory = null),
                ),
                for (final category in TemplateCategory.values)
                  _CategoryChip(
                    label: category.label,
                    selected: _selectedCategory == category,
                    onSelected: () => setState(() => _selectedCategory = category),
                  ),
              ],
            ),
          ),
          Expanded(
            child: templates.isEmpty
                ? const Center(child: Text('Keine Vorlagen in dieser Kategorie.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      final template = templates[index];
                      return TemplateCard(
                        template: template,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TemplateDetailScreen(template: template),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
