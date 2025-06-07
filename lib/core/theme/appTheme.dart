import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Colors.indigo;
  static final Color backgroundColor = Colors.grey[100]!;
  static final Color cardBackground = Colors.white;
  static final Color accentColor = Colors.indigoAccent;

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.indigo,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}