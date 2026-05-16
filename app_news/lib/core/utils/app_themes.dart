import 'package:app_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get mainTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.red),
    brightness: Brightness.light,
  );
}
