part of 'movies_bloc.dart';

sealed class MoviesState with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class MoviesInitial extends MoviesState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class MoviesLoading extends MoviesState {
  late bool isFirstFetch = false;

  MoviesLoading({this.isFirstFetch = false});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [isFirstFetch];
  }
}

final class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  MoviesLoaded(this.movies);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return movies;
  }
}

final class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [message];
  }
}
