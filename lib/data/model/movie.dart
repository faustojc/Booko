import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Movie with QueryBuilder<Movie>, FastEquatable {
  String? title;
  String? description;
  String? producer;
  DateTime? releaseDate;
  String? posterUrl;
  num? price;
  List<String> genres = [];
  List<DateTime> schedules = [];
  DateTime? createdAt;
  DateTime? updatedAt;

  Movie({
    this.title,
    this.description,
    this.producer,
    this.releaseDate,
    this.posterUrl,
    this.price,
    this.genres = const [],
    this.schedules = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json['release_date'] != null && json['release_date'] is String) {
      json['release_date'] = DateTime.parse(json['release_date']);
    }

    if (json['schedules'] != null && json['schedules'] is List<String> && json['schedules'].isNotEmpty) {
      json['schedules'] = json['schedules'].map((e) => DateTime.parse(e)).toList();
    }

    if (json['created_at'] != null && json['created_at'] is String) {
      json['created_at'] = DateTime.parse(json['created_at']);
    }

    if (json['updated_at'] != null && json['updated_at'] is String) {
      json['updated_at'] = DateTime.parse(json['updated_at']);
    }

    return Movie(
      title: json['title'],
      description: json['description'],
      producer: json['producer'],
      releaseDate: json['release_date'],
      posterUrl: json['poster_url'],
      price: json['price'],
      genres: List<String>.from(json['genres']),
      schedules: List<DateTime>.from(json['schedules']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'producer': producer,
      'release_date': releaseDate,
      'poster_url': posterUrl,
      'price': price,
      'genres': genres,
      'schedule': schedules.map((e) => e.toIso8601String()),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
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
        title,
        description,
        producer,
        releaseDate,
        posterUrl,
        price,
        genres,
        schedules,
        createdAt,
        updatedAt,
      ];
}
