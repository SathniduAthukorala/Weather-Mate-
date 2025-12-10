import 'package:flutter/material.dart';

final Color bgColor = Color(0xFFECECEC);
final Color cardColor = Color(0xFFF2F2F2);
final Color lightShadow = Colors.white;
final Color darkShadow = Color(0xFFC9C9C9);
final Color accent = Color(0xFF4A90E2);

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: bgColor,
  primaryColor: accent,
  appBarTheme: AppBarTheme(
    backgroundColor: bgColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600)
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.black87),
  ),
);
