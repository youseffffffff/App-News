import 'package:app_news/core/utils/app_colors.dart';
import 'package:app_news/core/views/widgets/app_bar_widget.dart';
import 'package:app_news/core/models/news_api_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;

  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final publishedAt = article.publishedAt != null
        ? DateTime.tryParse(article.publishedAt.toString())
        : null;

    final formattedDate = publishedAt != null
        ? DateFormat.MMMd().format(publishedAt)
        : '';

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    article.urlToImage ??
                    'https://th.bing.com/th/id/OIP.amm3ZIOTM2TuVcP-wu96gwHaHa?w=154&h=180&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3',
                width: double.infinity,
                height: size.height * 0.5,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                width: double.infinity,

                height: size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.transparent,
                      AppColors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarWidget(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                        hasPaddingBetween: true,
                      ),
                      Row(
                        children: [
                          AppBarWidget(
                            icon: Icons.share,
                            onTap: () => Navigator.pop(context),
                            hasPaddingBetween: true,
                          ),
                          const SizedBox(width: 16),

                          AppBarWidget(
                            icon: Icons.bookmark_border,
                            onTap: () => Navigator.pop(context),
                            hasPaddingBetween: true,
                          ),
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.bookmark_border,
                          //     color: AppColors.white,
                          //   ),
                          //   onPressed: () {
                          //     // Implement bookmark functionality
                          //   },
                          // ),
                          const SizedBox(width: 32),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * 0.01,
                left: 0,
                right: 0,

                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            'General',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 4.0),

                      Text(
                        article.title ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'trending • ${formattedDate.isNotEmpty ? formattedDate : 'Unknown Source'}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: size.height * 0.47),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                            article.urlToImage ??
                                'https://th.bing.com/th/id/OIP.amm3ZIOTM2TuVcP-wu96gwHaHa?w=154&h=180&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            article.source!.name ?? 'No Author Available',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '${article.description ?? 'No Description Available'}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
