import 'package:booko/data/model/base_model.dart';

class Ticket extends BaseModel<Ticket> {
  String? id;
  String? customerId;
  String? movieId;
  String? seatId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.id,
    this.customerId,
    this.movieId,
    this.seatId,
    this.createdAt,
    this.updatedAt,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    movieId = json['movie_id'];
    seatId = json['seat_id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'movie_id': movieId,
      'seat_id': seatId,
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
}
