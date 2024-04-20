import 'package:booko/data/model/mixin/query_builder.dart';
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
    if (json['start_date_time'] != null && json['start_date_time'] is String) {
      json['start_date_time'] = DateTime.parse(json['start_date_time']);
    }

    if (json['created_at'] != null && json['created_at'] is String) {
      json['created_at'] = DateTime.parse(json['created_at']);
    }

    if (json['updated_at'] != null && json['updated_at'] is String) {
      json['updated_at'] = DateTime.parse(json['updated_at']);
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
      'start_date_time': startDateTime?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
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
