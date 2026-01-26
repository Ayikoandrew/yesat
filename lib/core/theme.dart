import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Main Color: Cream
  static const Color creamBackground = Color(0xFFFFFDD0);
  static const Color creamSurface = Color(0xFFF5F5DC);
  static const Color darkText = Color(0xFF2D2926);
  static const Color accentGold = Color(0xFFD4AF37);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: creamBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentGold,
        primary: darkText,
        surface: creamBackground,
        onSurface: darkText,
      ),
      textTheme: GoogleFonts.libreBaskervilleTextTheme().apply(
        bodyColor: darkText,
        displayColor: darkText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: creamSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkText,
          foregroundColor: creamBackground,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
