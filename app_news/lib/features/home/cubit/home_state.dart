part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class TopHeaderlinesLoading extends HomeState {}

final class TopHeaderlinesLoaded extends HomeState {
  final List<Article> articles;

  TopHeaderlinesLoaded({this.articles = const []});
}

final class TopHeaderlinesError extends HomeState {
  final String message;

  TopHeaderlinesError(this.message);
}

final class RecommendationsLoading extends HomeState {}

final class RecommendationsLoaded extends HomeState {
  final List<Article> articles;

  RecommendationsLoaded({this.articles = const []});
}

final class RecommendationsError extends HomeState {
  final String message;

  RecommendationsError(this.message);
}
