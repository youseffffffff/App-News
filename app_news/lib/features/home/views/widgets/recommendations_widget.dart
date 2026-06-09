import 'package:app_news/core/utils/route/app_routes.dart';
import 'package:app_news/core/views/widgets/news_item.dart';
import 'package:app_news/features/home/cubit/home_cubit.dart';
import 'package:app_news/core/models/news_api_response.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationsWidget extends StatefulWidget {
  const RecommendationsWidget({super.key});

  @override
  State<RecommendationsWidget> createState() => _RecommendationsWidgetState();
}

class _RecommendationsWidgetState extends State<RecommendationsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is RecommendationsLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is RecommendationsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is RecommendationsLoaded) {
          final articles = state.articles;
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsItem(article: article);


            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: articles.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
