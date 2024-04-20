import 'package:booko/data/model/movie.dart';

class HomeRepo {
  final List<Movie> movies = [];

  Future<void> fetchData() async {
    movies.addAll((await Movie().orderBy('created_at', descending: true).limit(10).get()).toList());
  }
}
