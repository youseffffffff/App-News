import 'package:app_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
              // Handle navigation to Home
            },
            leading: Icon(Icons.home),
            title: Text('Home', style: Theme.of(context).textTheme.bodyMedium),
          ),
          ListTile(
            onTap: () {
              // Handle navigation to Profile
            },
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
