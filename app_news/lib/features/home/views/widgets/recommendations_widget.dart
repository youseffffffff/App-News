import 'package:app_news/features/home/cubit/home_cubit.dart';
import 'package:app_news/features/home/models/top_headlines_api_response.dart';
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
          return Center(child: CircularProgressIndicator());
        } else if (state is RecommendationsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is RecommendationsLoaded) {
          final articles = state.articles;
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final article = articles[index];

              String formatted = DateFormat.MMMd().format(
                article.publishedAt ?? DateTime.now(),
              );

              return Row(
                children: [
                  if (article.urlToImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            article.urlToImage ??
                            'https://th.bing.com/th/id/OIP.amm3ZIOTM2TuVcP-wu96gwHaHa?w=154&h=180&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  else
                    Container(width: 150, height: 150, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.source?.name ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),

                        Text(
                          article.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          formatted,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
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
