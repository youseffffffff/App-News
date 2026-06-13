import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/core/services/local_database_service.dart';
import 'package:app_news/core/utils/app_constants.dart';

class FavoriteService {
  static Future<void> toggleFavorite(Article article) async {
    try {
      final favoriteArticlesString = await LocalDatabaseService.getStringList(
        AppConstants.favoriteArticlesKey,
      );

      final favoriteArticlesList = convertListToArticles(
        favoriteArticlesString ?? [],
      );

      if (favoriteArticlesList.any((e) => e.title == article.title)) {
        if (!article.isFavorite) {
          final newFavoriteArticlesList = favoriteArticlesList
              .where((e) => e.title != article.title)
              .toList();

          final newFavoriteArticlesString = convertListToString(
            newFavoriteArticlesList,
          );

          // If the article is already in favorites, remove it
          await LocalDatabaseService.setStringList(
            AppConstants.favoriteArticlesKey,
            newFavoriteArticlesString,
          );
        }
      } else {
        if (article.isFavorite) {
          // If the article is not in favorites, add it
          favoriteArticlesList.add(article);

          final newFavoriteArticlesString = convertListToString(
            favoriteArticlesList,
          );

          // If the article is already in favorites, remove it
          await LocalDatabaseService.setStringList(
            AppConstants.favoriteArticlesKey,
            newFavoriteArticlesString,
          );
        }
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  static List<Article> convertListToArticles(List<String> favoriteArticles) {
    final List<Article> articles = [];

    for (var favoriteArticle in favoriteArticles ?? []) {
      final article = Article.fromJson(favoriteArticle as String);

      print('Favorite Article: $favoriteArticle');
      articles.add(article);
    }
    return articles;
  }

  static List<String> convertListToString(List<Article> articles) {
    final List<String> favoriteArticles = [];

    for (var article in articles ?? []) {
      final articleJson = article.toJson();

      print('Favorite Article JSON: $articleJson');
      favoriteArticles.add(articleJson);
    }
    return favoriteArticles;
  }

  static Future<List<Article>> fetchFavorites() async {
    try {
      final favoriteArticles = await LocalDatabaseService.getStringList(
        AppConstants.favoriteArticlesKey,
      );

      return convertListToArticles(favoriteArticles ?? []);
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }

  // Implement your favorite service logic here
}
