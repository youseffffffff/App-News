import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/core/utils/route/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTapFavoriteIcon;
  const NewsItem({super.key, required this.article, required this.onTapFavoriteIcon});

  @override
  Widget build(BuildContext context) {
    String formatted = DateFormat.MMMd().format(
      article.publishedAt ?? DateTime.now(),
    );

    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.articleDetails,
              arguments: article,
            );
          },
          child: Row(
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
                        Center(child: CircularProgressIndicator.adaptive()),
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
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        PositionedDirectional(
          child: GestureDetector(
            onTap: onTapFavoriteIcon,
            child: DecoratedBox(
              
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(article.isFavorite ? Icons.favorite : Icons.favorite_border, size: 16),
            ),
          ),
                    ),)
      ],
    );
  }
}
