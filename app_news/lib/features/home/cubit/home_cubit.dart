import 'package:app_news/core/models/news_api_response.dart';
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

  Future<void> fetchRecommendations() async {
    emit(RecommendationsLoading());
    try {
      final body = TopHeadlinesBody(page: 1, pageSize: 15);
      final response = await HomeServices.getTopHeadlines(body);

      emit(RecommendationsLoaded(articles: response.articles ?? []));
    } catch (e) {
      emit(RecommendationsError(e.toString()));
    }
  }
}
