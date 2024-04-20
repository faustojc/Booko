import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Seat with QueryBuilder<Seat>, FastEquatable {
  String? userId;
  String? movieId;
  String? seatNumber;
  bool occupied = false;
  DateTime? createdAt;
  DateTime? updatedAt;

  Seat({
    this.userId,
    this.movieId,
    this.seatNumber,
    this.occupied = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null && json['created_at'] is String) {
      json['created_at'] = DateTime.parse(json['created_at']);
    }

    if (json['updated_at'] != null && json['updated_at'] is String) {
      json['updated_at'] = DateTime.parse(json['updated_at']);
    }

    return Seat(
      userId: json['user_id'],
      movieId: json['movie_id'],
      seatNumber: json['seat_number'],
      occupied: json['occupied'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'movie_id': movieId,
      'seat_number': seatNumber,
      'occupied': occupied,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String get collectionName => 'seats';

  @override
  fromJson(Map<String, dynamic> json) {
    return Seat.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [userId, movieId, seatNumber, occupied, createdAt, updatedAt];
}
