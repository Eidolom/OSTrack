import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class OstrackColors {
  static const background = Color(0xFF0C0C0F);
  static const backgroundAlt = Color(0xFF141418);
  static const surface = Color(0xFF141418);
  static const surfaceAlt = Color(0xFF1C1C22);
  static const gold = Color(0xFFE8B84B);
  static const teal = Color(0xFF4ECDC4);
  static const coral = Color(0xFFE8624A);
  static const textHigh = Color(0xFFF0EDE8);
  static const textMuted = Color(0xFF8A8A9A);
  static const textLow = Color(0xFF4A4A5A);
}

ThemeData buildOstrackTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: OstrackColors.gold,
    brightness: Brightness.dark,
  ).copyWith(
    primary: OstrackColors.gold,
    secondary: OstrackColors.teal,
    surface: OstrackColors.surface,
    surfaceContainerHighest: OstrackColors.surfaceAlt,
    onPrimary: OstrackColors.background,
    onSecondary: OstrackColors.background,
    onSurface: OstrackColors.textHigh,
    outline: OstrackColors.textMuted,
  );

  final baseTextTheme = GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).apply(
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
      backgroundColor: OstrackColors.backgroundAlt.withValues(alpha: 0.96),
      indicatorColor: OstrackColors.teal.withValues(alpha: 0.18),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0x1FFFFFFF),
    ),
    textTheme: baseTextTheme.copyWith(
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.05,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.1,
      ),
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.05,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        height: 1.45,
        color: OstrackColors.textMuted,
      ),
      labelLarge: GoogleFonts.spaceMono(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
      labelMedium: GoogleFonts.dmMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: OstrackColors.textMuted,
      ),
    ),
  );
}
