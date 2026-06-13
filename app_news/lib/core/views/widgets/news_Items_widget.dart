import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/core/views/widgets/news_item_widget.dart';
import 'package:app_news/features/favorite/cubit/favorite_cubit.dart';
import 'package:app_news/features/home/cubit/home_cubit.dart';
import 'package:app_news/features/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsItems extends StatefulWidget {
  final dynamic cubit;
  const NewsItems({super.key, required this.cubit});

  @override
  State<NewsItems> createState() => _NewsItemsState();
}

class _NewsItemsState extends State<NewsItems> {
  @override
  Widget build(BuildContext context) {
    if (widget.cubit is HomeCubit) {
      final homeCubit = widget.cubit as HomeCubit;

      return BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          if (state is RecommendationsLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is RecommendationsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is RecommendationsLoaded) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return Center(child: Text('No recommended articles found.'));
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Article article = articles[index];

                return NewsItem(
                  article: article,
                  onTapFavoriteIcon: () {
                    article = article.copyWith(isFavorite: !article.isFavorite);
                    homeCubit.toggleFavorite(article, articles);

                    //
                    //
                  },
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
    } else if (widget.cubit is FavoriteCubit) {
      final favoriteCubit = widget.cubit as FavoriteCubit;

      return BlocBuilder<FavoriteCubit, FavoriteState>(
        bloc: favoriteCubit,
        builder: (context, state) {
          if (state is FavoriteFetching) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FavoriteFetchingFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FavoriteFetched) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return Center(child: Text('No favorite articles found.'));
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Article article = articles[index];
                article = article.copyWith(isFavorite: true);
                return NewsItem(
                  article: article,
                  onTapFavoriteIcon: () {
                    article = article.copyWith(isFavorite: !article.isFavorite);

                    favoriteCubit.toggleFavorite(article);
                    //
                    //
                  },
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
    } else if (widget.cubit is SearchCubit) {
      final searchCubit = widget.cubit as SearchCubit;

      return BlocBuilder<SearchCubit, SearchState>(
        bloc: searchCubit,
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is SearchFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is SearchLoaded) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return Center(child: Text('No recommended articles found.'));
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Article article = articles[index];

                return NewsItem(
                  article: article,
                  onTapFavoriteIcon: () {
                    article = article.copyWith(isFavorite: !article.isFavorite);
                    searchCubit.toggleFavorite(article, articles);

                    //
                    //
                  },
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
    return Container();
  }
}
