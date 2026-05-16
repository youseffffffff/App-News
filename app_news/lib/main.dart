import 'package:app_news/core/utils/app_constants.dart';
import 'package:app_news/core/utils/app_themes.dart';
import 'package:app_news/core/utils/route/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppThemes.mainTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
