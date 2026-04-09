import 'package:flutter/material.dart';

abstract final class OstrackColors {
  static const background = Color(0xFF071018);
  static const backgroundAlt = Color(0xFF0D1823);
  static const surface = Color(0xFF122131);
  static const surfaceAlt = Color(0xFF183145);
  static const gold = Color(0xFFFFD600);
  static const teal = Color(0xFF00FFCC);
  static const coral = Color(0xFFFF7A59);
  static const textHigh = Color(0xFFF6F4EF);
  static const textMuted = Color(0xFF9FB1C2);
}

ThemeData buildOstrackTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: OstrackColors.gold,
    brightness: Brightness.dark,
  ).copyWith(
    primary: OstrackColors.gold,
    secondary: OstrackColors.teal,
    background: OstrackColors.background,
    surface: OstrackColors.surface,
    onPrimary: OstrackColors.background,
    onSecondary: OstrackColors.background,
    onSurface: OstrackColors.textHigh,
    onBackground: OstrackColors.textHigh,
    outline: OstrackColors.textMuted,
  );

  final baseTextTheme = ThemeData.dark().textTheme.apply(
        bodyColor: OstrackColors.textHigh,
        displayColor: OstrackColors.textHigh,
      );

  return ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: OstrackColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: OstrackColors.background.withOpacity(0.92),
      indicatorColor: OstrackColors.teal.withOpacity(0.18),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0x1FFFFFFF),
    ),
    textTheme: baseTextTheme.copyWith(
      headlineMedium: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.05,
      ),
      headlineSmall: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.1,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        height: 1.45,
        color: OstrackColors.textMuted,
      ),
      labelLarge: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}
