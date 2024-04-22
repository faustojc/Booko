part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  MoviesLoaded(this.movies);
}

final class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
