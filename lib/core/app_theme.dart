import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema global do FinTrack com suporte claro e escuro
class AppTheme {
  static const _primaryColor = Color(0xFF6C63FF);
  static const _incomeColor = Color(0xFF00C897);
  static const _expenseColor = Color(0xFFFF5C5C);
  static const _backgroundDark = Color(0xFF0F0E1A);
  static const _surfaceDark = Color(0xFF1C1B2E);
  static const _cardDark = Color(0xFF252438);

  static Color get incomeColor => _incomeColor;
  static Color get expenseColor => _expenseColor;
  static Color get primaryColor => _primaryColor;

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: _incomeColor,
      surface: _surfaceDark,
      error: _expenseColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    cardTheme: const CardThemeData(
      color: _cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _backgroundDark,
      elevation: 0,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _cardDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.white60),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
