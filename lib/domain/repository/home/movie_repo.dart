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
      final url = await _storage.ref().child("movies/spider_man_beyond_the_spider_verse.jpg").getDownloadURL();
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

    movies.addAll(data);

    _lastMovie = data.last;
  }

  Future<void> fetchLatestData() async {
    final data = await Movie().orderBy('updated_at', descending: true).limit(6).get();

    if (data.length < 6) {
      movies.insertAll(0, data);

      if (movies.length > 6) {
        movies.removeRange(7, movies.length);
      }
    } else {
      movies.replaceRange(0, 6, data);
    }
  }
}
