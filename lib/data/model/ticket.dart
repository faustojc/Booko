import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Ticket with QueryBuilder<Ticket>, FastEquatable {
  String? userId;
  String? movieId;
  String? seatId;
  String? ticketNumber;
  String? movieTitle;
  DateTime? startDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.userId,
    this.movieId,
    this.seatId,
    this.ticketNumber,
    this.movieTitle,
    this.startDateTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    if (json['start_date_time'] != null && json['start_date_time'] is Timestamp) {
      json['start_date_time'] = json['start_date_time'].toDate();
    }

    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Ticket(
      userId: json['user_id'],
      movieId: json['movie_id'],
      seatId: json['seat_id'],
      ticketNumber: json['ticket_number'],
      movieTitle: json['movie_title'],
      startDateTime: json['start_date_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'movie_id': movieId,
      'seat_id': seatId,
      'ticket_number': ticketNumber,
      'movie_title': movieTitle,
      'start_date_time': Timestamp.fromDate(startDateTime!),
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
  List<Object?> get hashParameters => [userId, movieId, seatId, ticketNumber, createdAt, updatedAt];
}
