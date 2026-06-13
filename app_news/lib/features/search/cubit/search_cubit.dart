import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/features/favorite/services/favorite_service.dart';
import 'package:app_news/features/search/models/search_body.dart';
import 'package:app_news/features/search/services/search_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchArticles(String query, {List<Article>? articles}) async {
    emit(SearchLoading());

    try {
      final List<Article> newArticles;

      if (articles == null || articles.isEmpty) {
        final SearchBody searchBody = SearchBody(q: query);

        final NewsApiResponse response = await SearchService.search(searchBody);

        newArticles = response.articles ?? [];
      } else {
        newArticles = articles;
      }

      final favorites = await FavoriteService.fetchFavorites();
      //using for loop dolution

      for (int i = 0; i < newArticles.length; i++) {
        newArticles[i] = newArticles[i].copyWith(
          isFavorite: favorites.any((fav) => fav.title == newArticles[i].title),
        );

        print(
          'Article: ${newArticles[i].title}, isFavorite: ${newArticles[i].isFavorite}',
        );
      }

      emit(SearchLoaded(newArticles));
    } catch (e) {
      emit(SearchFailure('Failed to fetch articles. Please try again.'));
    }
  }

  

    Future<void> toggleFavorite(Article article, List<Article> articles) async {
    try {
      await FavoriteService.toggleFavorite(article);

      await searchArticles('', articles: articles);
    } catch (e) {
      emit(SearchFailure('Failed to toggle favorite. Please try again.'));
    }
  }


}
