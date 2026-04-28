import 'package:flutter/material.dart';

import 'portfolio_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

/// Teal accent — dark default; optional light mode from navbar (moon / sun).
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  static const Color accent = Color(0xFF3DD6C6);
  static const Color bgDark = Color(0xFF0A0E14);

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  static ThemeData _darkTheme() {
    const accent = PortfolioApp.accent;
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        surface: const Color(0xFF121922),
        primary: accent,
        onPrimary: const Color(0xFF04120F),
        secondary: accent,
        surfaceContainerHighest: const Color(0xFF161D27),
      ),
      scaffoldBackgroundColor: PortfolioApp.bgDark,
      fontFamily: 'Roboto',
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: const Color(0xFFE8EDF4),
        displayColor: const Color(0xFFE8EDF4),
      ),
      dividerTheme: const DividerThemeData(color: Color(0x22FFFFFF)),
      cardTheme: CardThemeData(
        color: base.colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0x14FFFFFF)),
        ),
      ),
    );
  }

  static ThemeData _lightTheme() {
    const accent = PortfolioApp.accent;
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: accent,
        onPrimary: const Color(0xFF04120F),
        surface: Colors.white,
        surfaceContainerHighest: const Color(0xFFF0F3F8),
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      fontFamily: 'Roboto',
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: const Color(0xFF1A2332),
        displayColor: const Color(0xFF1A2332),
      ),
      dividerTheme: const DividerThemeData(color: Color(0x22000000)),
      cardTheme: CardThemeData(
        color: base.colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0x14000000)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ali Usman',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      home: PortfolioPage(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: () {
          setState(() {
            _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
          });
        },
      ),
    );
  }
}
