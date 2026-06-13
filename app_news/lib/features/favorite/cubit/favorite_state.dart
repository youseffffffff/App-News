part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteFetching extends FavoriteState {}

final class  FavoriteFetched extends FavoriteState {
  final List<Article> articles;

  FavoriteFetched(this.articles);
}

final class FavoriteFetchingFailure extends FavoriteState {
  final String message;

  FavoriteFetchingFailure(this.message);
}

final class FavoriteAdding extends FavoriteState {}

final class FavoriteAdded extends FavoriteState {
  final List<Article> articles;

  FavoriteAdded(this.articles);
}

final class FavoriteAddingFailure extends FavoriteState {
  final String message;

  FavoriteAddingFailure(this.message);
}
