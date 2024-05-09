part of 'movies_bloc.dart';

sealed class MoviesState with FastEquatable {
  late Set<Movie> movies = {};
  late bool isFirstFetch = true;

  MoviesState({this.movies = const {}, this.isFirstFetch = false});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [movies, isFirstFetch];
}

final class MoviesInitial extends MoviesState {
  MoviesInitial({super.movies, super.isFirstFetch});

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class MoviesLoading extends MoviesState {
  @override
  bool get cacheHash => false;

  MoviesLoading({Set<Movie>? movies, bool? isFirstFetch}) : super(movies: movies ?? {}, isFirstFetch: isFirstFetch ?? true);

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class MoviesLoaded extends MoviesState {
  MoviesLoaded({required super.movies, super.isFirstFetch});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [movies, isFirstFetch];
  }
}

final class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message, {super.movies, super.isFirstFetch});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [message];
  }
}
