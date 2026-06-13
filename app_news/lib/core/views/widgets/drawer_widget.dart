import 'package:app_news/core/utils/app_colors.dart';
import 'package:app_news/core/utils/route/app_routes.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final dynamic cubit; // Replace 'dynamic' with the actual type of your cubit

  const DrawerWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.blue),
            child: Text(
              'Drawer Header',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Handle navigation to Home
            },
            leading: Icon(Icons.home),
            title: Text('Home', style: Theme.of(context).textTheme.bodyMedium),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, AppRoutes.favorite).then((_) async {
                await cubit.fetchRecommendations(); // Refresh recommendations when returning
              }); // Navigate to Favorites
            },
            leading: Icon(Icons.favorite),
            title: Text(
              'Favorites',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
