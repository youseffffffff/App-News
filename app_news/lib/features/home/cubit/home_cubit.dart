import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/core/services/local_database_service.dart';
import 'package:app_news/core/utils/app_constants.dart';
import 'package:app_news/features/favorite/services/favorite_service.dart';
import 'package:app_news/features/home/models/top_headlines_body.dart';
import 'package:app_news/features/home/services/home_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchTopHeadlines() async {
    emit(TopHeaderlinesLoading());
    try {
      final body = TopHeadlinesBody(page: 2, pageSize: 7, country: 'us');
      final response = await HomeServices.getTopHeadlines(body);

      emit(TopHeaderlinesLoaded(articles: response.articles ?? []));
    } catch (e) {
      emit(TopHeaderlinesError(e.toString()));
    }
  }

  Future<void> fetchRecommendations({List<Article>? articles}) async {
    emit(RecommendationsLoading());
    try {
      final newArticles;
      if (articles == null || articles.isEmpty) {
        final body = TopHeadlinesBody(page: 1, pageSize: 15);
        final response = await HomeServices.getTopHeadlines(body);

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

      // final updatedArticles = newArticles.map((article) {
      //   final isFavorite = favorites.any((fav) => fav.title == article.title);
      //   return article.copyWith(isFavorite: isFavorite);
      // });

      emit(RecommendationsLoaded(articles: /*updatedArticles*/ newArticles));
    } catch (e) {
      emit(RecommendationsError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Article article, List<Article> articles) async {
    try {
      await FavoriteService.toggleFavorite(article);

      await fetchRecommendations(articles: articles);
    } catch (e) {
      emit(RecommendationsError(e.toString()));
    }
  }
}
