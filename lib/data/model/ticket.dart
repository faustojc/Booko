import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Ticket with QueryBuilder<Ticket>, FastEquatable {
  String? id;
  String? customerId;
  String? movieId;
  String? seatId;
  String? ticketNumber;
  String? movieTitle;
  DateTime? startDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.id,
    this.customerId,
    this.movieId,
    this.seatId,
    this.ticketNumber,
    this.movieTitle,
    this.startDateTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      customerId: json['customer_id'],
      movieId: json['movie_id'],
      seatId: json['seat_id'],
      ticketNumber: json['ticket_number'],
      movieTitle: json['movie_title'],
      startDateTime: json['start_date_time'] != null ? DateTime.parse(json['start_date_time']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
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
  String get documentName => 'tickets';

  @override
  fromJson(Map<String, dynamic> json) {
    return Ticket.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [id, customerId, movieId, seatId, ticketNumber, createdAt, updatedAt];
}
