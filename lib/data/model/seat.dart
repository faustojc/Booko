import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

/// Represents a seat entity in the system.
///
/// The `Seat` class stores information about a seat, such as its ID, movie ID, seat number,
/// occupation status, creation timestamp, and update timestamp. It provides methods for
/// converting the seat object to and from JSON format.
///
/// Each `Seat` has a corresponding `Movie` data, indicating that each `Movie` object has its own set of associated `Seat` objects.
///
/// This class is used to manage seat data within the application, such as displaying seat details,
/// marking seats as occupied or available, updating seat information, and retrieving seat data from the database.
///
/// Example of creating a `Seat` object:
/// ```dart
/// final seat = Seat(
///   id: '123',
///   movieId: '456',
///   seatNumber: 'A1',
///   occupied: false,
///   createdAt: DateTime.now(),
///   updatedAt: DateTime.now(),
/// );
/// ```
///
/// The `Seat` class is a core model used throughout the application to manage seat-related data
/// and facilitate interactions with seat information in various parts of the system.
class Seat with QueryBuilder<Seat>, FastEquatable {
  String? id;
  String? movieId;
  int? seatNumber;
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
    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Seat(
      id: json['id'],
      movieId: json['movie_id'],
      seatNumber: json['seat_number'],
      occupied: json['occupied'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// Converts the `Seat` object to a JSON map.
  ///
  /// Returns a map containing the seat's ID, movie ID, seat number, occupation status,
  /// creation timestamp, and update timestamp.
  ///
  /// Example:
  /// ```dart
  /// final seat = Seat(
  ///   id: '123',
  ///   movieId: '456',
  ///   seatNumber: 'A1',
  ///   occupied: false,
  ///   createdAt: DateTime.now(),
  ///   updatedAt: DateTime.now(),
  /// );
  /// final json = seat.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  List<Object?> get hashParameters => [
        id,
        movieId,
        seatNumber,
        occupied,
        createdAt,
        updatedAt,
      ];
}
