import 'package:booko/data/model/movie.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MovieRepo {
  final Set<Movie> movies = {};
  late Movie currentMovie = Movie();

  final _storage = FirebaseStorage.instance;
  late Movie? _lastMovie;

  Future<void> fetchInitialData() async {
    final data = await Movie().orderBy('updated_at', descending: true).limit(6).get();

    for (final movie in data) {
      movie.posterUrl = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
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
          isLessThan: _lastMovie!.updatedAt!,
        )
        .orderBy('updated_at', descending: true)
        .limit(6)
        .get();

    for (final movie in data) {
      movie.posterUrl = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
    }

    movies.addAll(data);

    _lastMovie = data.last;
  }

  Future<void> fetchLatestData() async {
    final data = await Movie().orderBy('updated_at', descending: true).limit(6).get();

    for (final movie in data) {
      movie.posterUrl = await _storage.ref().child(movie.posterUrl!).getDownloadURL();
    }

    movies.addAll(data);
  }
}
