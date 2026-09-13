import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../services/settings_service.dart';

/// Theme definitions for the app — refined to match a clean modern
/// church-admin aesthetic (soft white surfaces, strong blue accent,
/// generous rounded cards, minimal elevation).
class AppThemes {
  // Primary brand blue (inspired by the reference dashboard)
  static const Color brandBlue = Color(0xFF2563EB);       // strong blue
  static const Color brandBlueDark = Color(0xFF1E40AF);   // deeper for sidebar
  static const Color brandBlueSoft = Color(0xFFDBEAFE);   // very light tint

  // Light theme surfaces
  static const Color _lightPrimary = brandBlue;
  static const Color _lightSurface = Color(0xFFF8FAFC);   // cool grey-white
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightCard = Color(0xFFFFFFFF);

  // Dark theme
  static const Color _darkPrimary = Color(0xFF60A5FA);
  static const Color _darkSurface = Color(0xFF0F172A);
  static const Color _darkCard = Color(0xFF1E293B);

  /// Light theme data
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _lightPrimary,
      brightness: Brightness.light,
      primary: _lightPrimary,
      surface: _lightSurface,
      onSurface: const Color(0xFF0F172A),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _lightSurface,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: _lightBackground,
        foregroundColor: Color(0xFF0F172A),
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        titleTextStyle: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _lightCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brandBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: brandBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: brandBlue,
        foregroundColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: brandBlue, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide.none,
      ),
    );
  }

  /// Dark theme data
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _darkPrimary,
      brightness: Brightness.dark,
      primary: _darkPrimary,
      surface: _darkSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _darkSurface,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: _darkSurface,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _darkCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: brandBlue,
        foregroundColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }

  /// Chart colors for light theme
  static List<Color> get lightChartColors => [
    brandBlue,
    const Color(0xFF10B981), // Emerald
    const Color(0xFFF59E0B), // Amber
    const Color(0xFF8B5CF6), // Violet
    const Color(0xFFEF4444), // Red
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFFEC4899), // Pink
    const Color(0xFF64748B), // Slate
  ];

  /// Chart colors for dark theme
  static List<Color> get darkChartColors => [
    const Color(0xFF60A5FA),
    const Color(0xFF34D399),
    const Color(0xFFFBBF24),
    const Color(0xFFA78BFA),
    const Color(0xFFF87171),
    const Color(0xFF22D3EE),
    const Color(0xFFF472B6),
    const Color(0xFF94A3B8),
  ];
}

/// Theme provider that watches app settings
final themeProvider = Provider<ThemeData>((ref) {
  final settings = ref.watch(appSettingsProvider);
  final brightness = ref.watch(platformBrightnessProvider);

  switch (settings.themeMode) {
    case AppThemeMode.light:
      return AppThemes.lightTheme;
    case AppThemeMode.dark:
      return AppThemes.darkTheme;
    case AppThemeMode.system:
      return brightness == Brightness.dark
          ? AppThemes.darkTheme
          : AppThemes.lightTheme;
  }
});

/// Dark theme provider
final darkThemeProvider = Provider<ThemeData>((ref) {
  return AppThemes.darkTheme;
});

/// Light theme provider
final lightThemeProvider = Provider<ThemeData>((ref) {
  return AppThemes.lightTheme;
});

/// Provider for current platform brightness
final platformBrightnessProvider = Provider<Brightness>((ref) {
  // This will be overridden in main.dart with actual brightness
  return Brightness.light;
});

/// Theme mode provider
final themeModeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(appSettingsProvider);
  return settings.themeMode.toThemeMode();
});

/// Chart colors provider that adapts to current theme
final chartColorsProvider = Provider<List<Color>>((ref) {
  final settings = ref.watch(appSettingsProvider);
  final brightness = ref.watch(platformBrightnessProvider);

  switch (settings.themeMode) {
    case AppThemeMode.light:
      return AppThemes.lightChartColors;
    case AppThemeMode.dark:
      return AppThemes.darkChartColors;
    case AppThemeMode.system:
      return brightness == Brightness.dark
          ? AppThemes.darkChartColors
          : AppThemes.lightChartColors;
  }
});

/// Check if current theme is dark
final isDarkThemeProvider = Provider<bool>((ref) {
  final settings = ref.watch(appSettingsProvider);
  final brightness = ref.watch(platformBrightnessProvider);

  switch (settings.themeMode) {
    case AppThemeMode.light:
      return false;
    case AppThemeMode.dark:
      return true;
    case AppThemeMode.system:
      return brightness == Brightness.dark;
  }
});
