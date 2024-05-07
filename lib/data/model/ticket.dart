import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

/// Represents a ticket entity in the system.
///
/// The `Ticket` class stores information about a ticket, such as its ID, user ID, movie ID, seat ID, ticket number,
/// movie title, schedule, creation timestamp, and update timestamp. It provides methods for
/// converting the ticket object to and from JSON format.
///
/// The `Ticket` class includes reference IDs for the associated user, movie, and seat. These IDs provide
/// sufficient information for users to access their purchased tickets.
///
/// This class is used to manage ticket data within the application, such as generating QR codes for ticket verification,
/// updating ticket information, and retrieving ticket data from the database.
///
/// Example of creating a `Ticket` object:
/// ```dart
/// final ticket = Ticket(
///   id: '123',
///   userId: '456',
///   movieId: '789',
///   seatId: '101112',
///   ticketNumber: 'ABC123',
///   expired: false,
///   movieTitle: 'Movie Title',
///   schedule: Timestamp.fromDate(DateTime.now()),
///   createdAt: DateTime.now(),
///   updatedAt: DateTime.now(),
/// );
/// ```
///
/// The `Ticket` class is a core model used throughout the application to manage ticket-related data
/// and facilitate interactions with ticket information in various parts of the system.
class Ticket with QueryBuilder<Ticket>, FastEquatable {
  String? id;
  String? userId;
  String? movieId;
  int? seatNumber;
  String? ticketNumber;
  String? movieTitle;
  bool? expired;
  num? price;
  DateTime? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.id,
    this.userId,
    this.movieId,
    this.seatNumber,
    this.ticketNumber,
    this.movieTitle,
    this.expired = false,
    this.price = 0.0,
    this.schedule,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    if (json['schedule'] != null && json['schedule'] is Timestamp) {
      json['schedule'] = json['schedule'].toDate();
    }

    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Ticket(
      id: json['id'],
      userId: json['user_id'],
      movieId: json['movie_id'],
      seatNumber: json['seat_number'],
      ticketNumber: json['ticket_number'],
      movieTitle: json['movie_title'],
      expired: json['expired'],
      price: json['price'],
      schedule: json['schedule'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// Converts the `Ticket` object to a JSON map.
  ///
  /// Returns a map containing the ticket's ID, user ID, movie ID, seat ID, ticket number, movie title,
  /// schedule, creation timestamp, and update timestamp.
  ///
  /// Example:
  /// ```dart
  /// final ticket = Ticket(
  ///   id: '123',
  ///   userId: '456',
  ///   movieId: '789',
  ///   seatId: '101112',
  ///   ticketNumber: 'ABC123',
  ///   movieTitle: 'Movie Title',
  ///   expired: false,
  ///   price: 10.0,
  ///   schedule: Timestamp.fromDate(DateTime.now()),
  ///   createdAt: DateTime.now(),
  ///   updatedAt: DateTime.now(),
  /// );
  /// final json = ticket.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'movie_id': movieId,
      'seat_number': seatNumber,
      'ticket_number': ticketNumber,
      'movie_title': movieTitle,
      'expired': expired,
      'price': price,
      'schedule': Timestamp.fromDate(schedule!),
      'created_at': Timestamp.fromDate(createdAt!),
      'updated_at': Timestamp.fromDate(updatedAt!),
    };
  }

  @override
  String get collectionName => 'tickets';

  @override
  fromJson(Map<String, dynamic> json) {
    return Ticket.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        id,
        userId,
        movieId,
        seatNumber,
        ticketNumber,
        expired,
        price,
        schedule,
        createdAt,
        updatedAt,
      ];
}
