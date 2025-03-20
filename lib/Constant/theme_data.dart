// theme.dart
import 'package:flutter/material.dart';
import 'package:workshop/Constant/theme.dart';

ThemeData theme() => ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      useMaterial3: true,
    );
