import 'package:app_news/core/utils/route/app_routes.dart';
import 'package:app_news/features/home/cubit/home_cubit.dart';
import 'package:app_news/features/home/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = HomeCubit();
              cubit.fetchTopHeadlines();
              cubit.fetchRecommendations();
              return cubit;
            },
            child: const HomePage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }
}
