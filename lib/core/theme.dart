import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebTheme {
  // Brand Colors - Professional NGO Palette
  static const Color primary = Color(
    0xFF1565C0,
  ); // Blue 800 - Trust & Stability
  static const Color primaryDark = Color(
    0xFF0D47A1,
  ); // Blue 900 - Deep Authority
  static const Color primaryLight = Color(
    0xFFE3F2FD,
  ); // Blue 50 - Soft Background

  static const Color secondary = Color(
    0xFF2E7D32,
  ); // Green 800 - Growth & Impact
  static const Color secondaryLight = Color(
    0xFFE8F5E9,
  ); // Green 50 - Fresh Background

  static const Color accentGold = Color(0xFFF57C00); // Orange 700 - Warm CTA
  static const Color accentGoldLight = Color(
    0xFFFFF3E0,
  ); // Orange 50 - Subtle Highlight

  // Neutral Colors
  static const Color darkText = Color(
    0xFF212121,
  ); // Grey 900 - Strong Readability
  static const Color lightColor = Color(
    0xFFFAFAFA,
  ); // Grey 50 - Clean Background
  static const Color grayBorder = Color(
    0xFFE0E0E0,
  ); // Grey 300 - Subtle Borders

  static const Duration animationDuration = Duration(milliseconds: 1500);
  static const Curve animationCurve = Curves.easeOutExpo;
  static const double animationSlide = 0.3;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: accentGold,
        onTertiary: Colors.white,
        surface: Colors.white,
        onSurface: darkText,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.interTextTheme()
          .copyWith(
            displayLarge: GoogleFonts.libreBaskerville(
              color: darkText,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: GoogleFonts.libreBaskerville(
              color: darkText,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: GoogleFonts.libreBaskerville(
              color: darkText,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: GoogleFonts.libreBaskerville(
              color: darkText,
              fontWeight: FontWeight.bold,
            ),
          )
          .apply(bodyColor: darkText, displayColor: darkText),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: TextStyle(
          color: primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: grayBorder),
        ),
      ),
    );
  }
}
