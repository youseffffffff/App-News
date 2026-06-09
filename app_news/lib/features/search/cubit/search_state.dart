part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Article> articles;

  SearchLoaded(this.articles);
}

final class SearchFailure extends SearchState {
  final String errorMessage;

  SearchFailure(this.errorMessage);
}
