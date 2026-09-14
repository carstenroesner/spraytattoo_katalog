import 'package:flutter/material.dart';

import '../models/mock_catalog.dart';
import '../models/tattoo_template.dart';
import '../widgets/template_card.dart';
import 'about_dialog.dart';
import 'feature_overview_screen.dart';
import 'report_issue_dialog.dart';
import 'template_detail_screen.dart';

/// Durchblätterbarer Katalog aller Spraytattoo-Vorlagen als Thumbnail-Grid,
/// mit Filter nach Kategorie und Volltextsuche.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  TemplateCategory? _selectedCategory;
  bool _isSearching = false;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<TattooTemplate> get _filteredCatalog {
    Iterable<TattooTemplate> result = mockCatalog;

    if (_selectedCategory != null) {
      result = result.where((template) => template.category == _selectedCategory);
    }

    final query = _searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((template) {
        return template.name.toLowerCase().contains(query) ||
            template.description.toLowerCase().contains(query) ||
            template.templateNumber.toLowerCase().contains(query) ||
            template.category.label.toLowerCase().contains(query);
      });
    }

    return result.toList();
  }

  void _startSearch() {
    setState(() => _isSearching = true);
    // Fokus erst setzen, sobald das Textfeld im nächsten Frame existiert.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  /// Ab bestimmten Breiten mehr Spalten statt größerer Kacheln anzeigen.
  int _crossAxisCountForWidth(double width) {
    if (width >= 1400) return 5;
    if (width >= 1100) return 4;
    if (width >= 750) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final templates = _filteredCatalog;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Vorlagen durchsuchen …',
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.titleMedium,
                onChanged: (value) => setState(() => _searchQuery = value),
              )
            : const Text('Vorlagen-Katalog'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            tooltip: _isSearching ? 'Suche schließen' : 'Suchen',
            onPressed: _isSearching ? _stopSearch : _startSearch,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'funktionsumfang':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const FeatureOverviewScreen()),
                  );
                  break;
                case 'report_issue':
                  showReportIssueDialog(context);
                  break;
                case 'about':
                  showAboutAppDialog(context);
                  break;
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
              PopupMenuItem(
                value: 'report_issue',
                child: ListTile(
                  leading: Icon(Icons.flag_outlined),
                  title: Text('Problem melden'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.copyright_outlined),
                  title: Text('Über diese App'),
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
                ? Center(
                    child: Text(
                      _searchQuery.trim().isNotEmpty
                          ? 'Keine Vorlagen gefunden für "${_searchQuery.trim()}".'
                          : 'Keine Vorlagen in dieser Kategorie.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = _crossAxisCountForWidth(constraints.maxWidth);
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
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
