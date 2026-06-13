import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/features/favorite/services/favorite_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());


  Future<void> fetchFavorites() async {
    emit(FavoriteFetching());
    try {
      // Simulate fetching favorites
      final favorites = await FavoriteService.fetchFavorites();
      emit(FavoriteFetched(favorites));
    } catch (e) {
      emit(FavoriteFetchingFailure(e.toString()));
    }
  }


  Future<void> toggleFavorite(Article article) async {
    emit(FavoriteAdding());
    try {
      await FavoriteService.toggleFavorite(article);
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteAddingFailure(e.toString()));
    }
  }



  
}
