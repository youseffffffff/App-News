import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/features/search/models/search_body.dart';
import 'package:app_news/features/search/services/search_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchArticles(String query) async {
    emit(SearchLoading());

    try {
      final SearchBody searchBody = SearchBody(q: query);

      final NewsApiResponse response = await SearchService.search(searchBody);

      emit(SearchLoaded(response.articles ?? []));
    } catch (e) {
      emit(SearchFailure('Failed to fetch articles. Please try again.'));
    }
  }
}
