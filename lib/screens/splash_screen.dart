import 'package:flutter/material.dart';

import 'home_shell.dart';

/// Zeigt beim App-Start kurz einen Startbildschirm ([SplashScreen]) an und
/// wechselt danach automatisch zum eigentlichen Katalog ([HomeShell]).
class SplashGate extends StatefulWidget {
  const SplashGate({super.key});

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  static const _splashDuration = Duration(seconds: 1);

  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(_splashDuration, () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash ? const SplashScreen() : const HomeShell();
  }
}

/// Optischer Startbildschirm mit App-Logo und -Name, passend zum
/// dunklen App-Icon/Manifest-Branding ("Spray Tattoo").
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF212121),
      child: _SplashContent(),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.star_rounded, size: 84, color: Colors.white),
                Positioned(
                  top: 2,
                  right: 4,
                  child: _SprayDot(color: colorScheme.primary, size: 14),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  child: _SprayDot(color: colorScheme.secondary, size: 9),
                ),
                Positioned(
                  bottom: 0,
                  right: 14,
                  child: _SprayDot(color: colorScheme.tertiary, size: 7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Spray Tattoo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Vorlagen-Katalog',
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _SprayDot extends StatelessWidget {
  final Color color;
  final double size;

  const _SprayDot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
