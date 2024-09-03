import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light();
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide.none,
    )
  );
}