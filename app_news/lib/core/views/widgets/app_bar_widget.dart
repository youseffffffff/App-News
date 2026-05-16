import 'package:app_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool hasPaddingBetween;

  const AppBarWidget({
    super.key,
    required this.icon,
    this.onTap,
    this.hasPaddingBetween = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey2,
        ),

        child: Padding(
          padding: EdgeInsets.all(hasPaddingBetween ? 8.0 : 0.0),
          child: Icon(icon, color: AppColors.black),
        ),
      ),
    );
  }
}
