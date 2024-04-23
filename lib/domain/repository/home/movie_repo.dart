import 'package:booko/data/model/movie.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MovieRepo {
  final List<Movie> movies = [];
  final _storage = FirebaseStorage.instance;
  late Movie? _lastMovie;

  Future<void> addMovie(Movie movie) async {
    movies.insert(0, movie);
  }

  Future<void> fetchInitialData() async {
    final data = await Movie().orderBy('updated_at', descending: true).limit(6).get();

    for (final movie in data) {
      final url = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
      movie.posterUrl = url;
    }

    movies.addAll(data);

    if (movies.isNotEmpty) {
      _lastMovie = movies.last;
    }
  }

  Future<void> fetchMoreData() async {
    final data = await Movie()
        .where(
          'updated_at',
          isLessThan: _lastMovie!.updatedAt!.toIso8601String(),
        )
        .orderBy('updated_at', descending: true)
        .limit(6)
        .get();

    for (final movie in data) {
      final url = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
      movie.posterUrl = url;
    }

    movies.addAll(data);

    _lastMovie = data.last;
  }

  Future<void> fetchLatestData() async {
    final data = await Movie().orderBy('updated_at', descending: true).limit(6).get();

    for (final movie in data) {
      final url = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
      movie.posterUrl = url;
    }

    movies.replaceRange(0, movies.length, data);
  }
}
