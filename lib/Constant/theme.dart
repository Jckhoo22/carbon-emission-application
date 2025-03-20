// theme.dart
import 'package:flutter/material.dart';

const backgroundColor = Color(0XFFF1F3F7);
const white = Color(0XFFFFFFFF);
const black = Color(0XFF000000);
const error = Color(0XFFBC5148);

const primaryGreen = Color(0XFF007E77);
const primaryBlue = Color(0XFF2382BA);
const primaryYellow = Color(0XFFFF9B56);

const secondaryGreen = Color(0XFF009B90);
const secondaryBlue = Color(0XFF00ADFB);
const secondaryYellow = Color(0XFFFDB584);

// theme.dart
TextStyle displayLarge() => const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: black,
    );

TextStyle displayMedium({bool bold = false, Color color = black}) => TextStyle(
      fontSize: 24,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );

TextStyle normal({bool bold = false, Color color = black}) => TextStyle(
      fontSize: 16,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );

TextStyle label({bool bold = false, Color color = black}) => TextStyle(
      fontSize: 12,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );

// theme.dart
AppBarTheme appBarTheme() => AppBarTheme(
      color: secondaryGreen,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: white),
      titleTextStyle: displayMedium(bold: true, color: white),
    );

InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
      fillColor: white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: white),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: white),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error),
        borderRadius: BorderRadius.circular(16),
      ),
    );
