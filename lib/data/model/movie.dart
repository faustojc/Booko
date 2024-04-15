import 'package:booko/data/model/base_model.dart';

class Movie extends BaseModel<Movie> {
  String? id;
  String? title;
  String? description;
  String? director;
  String? producer;
  String? releaseDate;
  String? imageUrl;
  num? price;
  List<String> genres = [];
  DateTime? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;

  Movie({
    this.id,
    this.title,
    this.description,
    this.director,
    this.producer,
    this.releaseDate,
    this.imageUrl,
    this.price,
    this.genres = const [],
    this.createdAt,
    this.schedule,
    this.updatedAt,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    director = json['director'];
    producer = json['producer'];
    releaseDate = json['release_date'];
    imageUrl = json['image_url'];
    price = json['price'];
    genres = json['genres'];
    schedule = DateTime.parse(json['schedule']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'director': director,
      'producer': producer,
      'release_date': releaseDate,
      'image_url': imageUrl,
      'price': price,
      'genres': genres,
      'schedule': schedule?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String get documentName => 'movies';

  @override
  fromJson(Map<String, dynamic> json) {
    return Movie.fromJson(json);
  }
}
