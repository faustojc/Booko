import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Seat with QueryBuilder<Seat>, FastEquatable {
  String? id;
  String? movieId;
  String? seatNumber;
  bool occupied = false;
  DateTime? createdAt;
  DateTime? updatedAt;

  Seat({
    this.id,
    this.movieId,
    this.seatNumber,
    this.occupied = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      movieId: json['movie_id'],
      seatNumber: json['seat_number'],
      occupied: json['occupied'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movie_id': movieId,
      'seat_number': seatNumber,
      'occupied': occupied,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String get documentName => 'seats';

  @override
  fromJson(Map<String, dynamic> json) {
    return Seat.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [id, movieId, seatNumber, occupied, createdAt, updatedAt];
}
