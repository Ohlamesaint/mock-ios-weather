import 'package:flutter/material.dart';

final ThemeData weatherTheme = ThemeData(
  primaryColor: Colors.black, // Sky Blue
  scaffoldBackgroundColor: const Color(0xFFE0F7FA), // Light Cyan
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Color(0xFFFFD700),
    surface: Color(0xFFE0F7FA),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4A90E2),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  textTheme: const TextTheme(
    displayLarge:
        TextStyle(color: Color(0xFF4A90E2), fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black87),
  ),
);
