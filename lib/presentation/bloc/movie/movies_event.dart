part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

final class MoviesFetchInitialData extends MoviesEvent {}

final class MoviesFetchMoreData extends MoviesEvent {}

final class MoviesFetchLatestData extends MoviesEvent {}
