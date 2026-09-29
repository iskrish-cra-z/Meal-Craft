import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF15422E);
  static const Color primaryContainer = Color(0xFF2E5A44);
  static const Color onPrimary = Color(0xFFFFFFFF);
  
  static const Color secondary = Color(0xFFA23E18);
  static const Color secondaryContainer = Color(0xFFFE8357);
  static const Color onSecondary = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFCF9F3);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3ED);
  static const Color surfaceContainer = Color(0xFFF0EEE8);
  static const Color surfaceContainerHigh = Color(0xFFEBE8E2);
  
  static const Color onSurface = Color(0xFF1C1C18);
  static const Color onSurfaceVariant = Color(0xFF414943);
  static const Color outline = Color(0xFF717973);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final serifTextTheme = GoogleFonts.newsreaderTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        surfaceContainerLowest: surfaceContainerLowest,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: baseTextTheme.copyWith(
        displayLarge: serifTextTheme.displayLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w500, letterSpacing: -0.02),
        headlineLarge: serifTextTheme.headlineLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w600, letterSpacing: -0.015),
        headlineMedium: serifTextTheme.headlineMedium?.copyWith(color: onSurface, fontWeight: FontWeight.w600, letterSpacing: -0.01),
        titleLarge: serifTextTheme.titleLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w600),
      ),
      cardTheme: CardTheme(
        color: surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
