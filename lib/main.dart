import 'package:flutter/material.dart';

import 'portfolio_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

/// Teal accent on dark background — similar vibe to common dev portfolios.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  static const Color _accent = Color(0xFF3DD6C6);
  static const Color _bg = Color(0xFF0A0E14);

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        surface: const Color(0xFF121922),
        primary: _accent,
        onPrimary: const Color(0xFF04120F),
        secondary: _accent,
        surfaceContainerHighest: const Color(0xFF161D27),
      ),
      scaffoldBackgroundColor: _bg,
      fontFamily: "Roboto",
    );

    return MaterialApp(
      title: "Ali Usman",
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: base.textTheme.apply(
          bodyColor: const Color(0xFFE8EDF4),
          displayColor: const Color(0xFFE8EDF4),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0x22FFFFFF),
        ),
        cardTheme: CardThemeData(
          color: base.colorScheme.surfaceContainerHighest,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0x14FFFFFF)),
          ),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}
