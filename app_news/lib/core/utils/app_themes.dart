import 'package:app_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get mainTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.red),
    brightness: Brightness.light,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.red),
      ),
    ),
    
  );
}
