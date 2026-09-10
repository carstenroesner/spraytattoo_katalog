import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/wishlist_service.dart';
import 'catalog_screen.dart';
import 'wishlist_screen.dart';

/// Enthält die Bottom-Navigation zwischen Katalog und Wunschliste.
/// Die Wunschliste zeigt als Badge, wie viele Vorlagen aktuell ausgewählt sind.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = [CatalogScreen(), WishlistScreen()];

  @override
  Widget build(BuildContext context) {
    final wishlistCount = context.select<WishlistService, int>((s) => s.count);

    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: wishlistCount > 0,
              label: Text('$wishlistCount'),
              child: const Icon(Icons.star_border),
            ),
            selectedIcon: Badge(
              isLabelVisible: wishlistCount > 0,
              label: Text('$wishlistCount'),
              child: const Icon(Icons.star),
            ),
            label: 'Wunschliste',
          ),
        ],
      ),
    );
  }
}
