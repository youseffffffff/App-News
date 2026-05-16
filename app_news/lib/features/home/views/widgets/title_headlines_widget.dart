import 'package:app_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TitleHeadlinesWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const TitleHeadlinesWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'See All',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
