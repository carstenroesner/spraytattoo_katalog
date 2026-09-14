import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';
import 'services/wishlist_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SprayTattooApp());
}

class SprayTattooApp extends StatelessWidget {
  const SprayTattooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistService(),
      child: MaterialApp(
        title: 'SprayTattoo Katalog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashGate(),
      ),
    );
  }
}
