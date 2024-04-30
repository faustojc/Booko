import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

/// Represents a movie entity in the system.
///
/// The `Movie` class stores information about a movie, such as its title, description,
/// cinema name, location, release date, poster URL, price, genres, schedules, and timestamps.
/// It provides methods for converting the movie object to and from JSON format.
///
/// This class is used to manage movie data within the application, such as displaying movie details,
/// adding new movies, updating existing movie information, and retrieving movie data from the database.
///
/// Example of creating a `Movie` object:
/// ```dart
/// final movie = Movie(
///   title: 'Inception',
///   description: 'A mind-bending action thriller',
///   cinemaName: 'Cineplex',
///   location: 'New York',
///   releaseDate: DateTime(2010, 7, 16),
///   posterUrl: 'https://example.com/poster.jpg',
///   price: 10.99,
///   genres: ['Action', 'Sci-Fi', 'Thriller'],
///   schedules: [DateTime(2022, 9, 1, 18, 0), DateTime(2022, 9, 1, 21, 0)],
///   createdAt: DateTime.now(),
///   updatedAt: DateTime.now(),
/// );
/// ```
///
/// The `Movie` class is a core model used throughout the application to manage movie-related data
/// and facilitate interactions with movie information in various parts of the system.
class Movie with QueryBuilder<Movie>, FastEquatable {
  String? id;
  String? title;
  String? description;
  String? cinemaName;
  String? location;
  DateTime? releaseDate;
  String? posterUrl;
  num? price;
  List<String> genres = [];
  List<DateTime> schedules = [];
  DateTime? createdAt;
  DateTime? updatedAt;

  Movie({
    this.id,
    this.title,
    this.description,
    this.releaseDate,
    this.cinemaName,
    this.location,
    this.posterUrl,
    this.price,
    this.genres = const [],
    this.schedules = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json['release_date'] != null && json['release_date'] is Timestamp) {
      json['release_date'] = json['release_date'].toDate();
    }

    if (json['schedules'] != null) {
      json['schedules'] = json['schedules'].map((e) => e.toDate()).toList();
    }

    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      releaseDate: json['release_date'],
      cinemaName: json['cinema_name'],
      location: json['location'],
      posterUrl: json['poster_url'],
      price: json['price'],
      genres: List<String>.from(json['genres']),
      schedules: List<DateTime>.from(json['schedules']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// Converts the `Movie` object to a JSON map.
  ///
  /// Returns a map containing the movie's ID, title, description, cinema name, location, release date, poster URL,
  /// price, genres, schedules, creation timestamp, and update timestamp.
  ///
  /// Example:
  /// ```dart
  /// final movie = Movie(
  ///   id: '123',
  ///   title: 'Inception',
  ///   description: 'A mind-bending action thriller',
  ///   cinemaName: 'Cineplex',
  ///   location: 'New York',
  ///   releaseDate: DateTime(2010, 7, 16),
  ///   posterUrl: 'https://example.com/poster.jpg',
  ///   price: 10.99,
  ///   genres: ['Action', 'Sci-Fi', 'Thriller'],
  ///   schedules: [DateTime(2022, 9, 1, 18, 0), DateTime(2022, 9, 1, 21, 0)],
  ///   createdAt: DateTime.now(),
  ///   updatedAt: DateTime.now(),
  /// );
  /// final json = movie.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cinema_name': cinemaName,
      'location': location,
      'release_date': Timestamp.fromDate(releaseDate!),
      'poster_url': posterUrl,
      'price': price,
      'genres': genres,
      'schedule': schedules.map((e) => Timestamp.fromDate(e)),
      'created_at': Timestamp.fromDate(createdAt!),
      'updated_at': Timestamp.fromDate(updatedAt!),
    };
  }

  @override
  String get collectionName => 'movies';

  @override
  fromJson(Map<String, dynamic> json) {
    return Movie.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        id,
        title,
        description,
        releaseDate,
        cinemaName,
        location,
        posterUrl,
        price,
        genres,
        schedules,
        createdAt,
        updatedAt,
      ];
}
