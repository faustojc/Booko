import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Seat with QueryBuilder<Seat>, FastEquatable {
  String? movieId;
  String? seatNumber;
  bool occupied = false;
  DateTime? createdAt;
  DateTime? updatedAt;

  Seat({
    this.movieId,
    this.seatNumber,
    this.occupied = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Seat(
      movieId: json['movie_id'],
      seatNumber: json['seat_number'],
      occupied: json['occupied'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'seat_number': seatNumber,
      'occupied': occupied,
      'created_at': Timestamp.fromDate(createdAt!),
      'updated_at': Timestamp.fromDate(updatedAt!),
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
  List<Object?> get hashParameters => [movieId, seatNumber, occupied, createdAt, updatedAt];
}
