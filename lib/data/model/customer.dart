import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Customer with QueryBuilder<Customer>, FastEquatable {
  String? userId;
  String? firstname;
  String? lastname;
  DateTime? birthday;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer({
    this.userId,
    this.firstname,
    this.lastname,
    this.birthday,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    if (json['birthday'] != null && json['birthday'] is int) {
      json['birthday'] = DateTime.fromMillisecondsSinceEpoch(json['birthday']);
    }

    if (json['created_at'] != null && json['created_at'] is int) {
      json['created_at'] = DateTime.fromMillisecondsSinceEpoch(json['created_at']);
    }

    if (json['updated_at'] != null && json['updated_at'] is int) {
      json['updated_at'] = DateTime.fromMillisecondsSinceEpoch(json['updated_at']);
    }

    return Customer(
      userId: json['user_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      birthday: json['birthday'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday?.millisecondsSinceEpoch,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  @override
  String get collectionName => 'customers';

  @override
  fromJson(Map<String, dynamic> json) {
    return Customer.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [userId, firstname, lastname, birthday, createdAt, updatedAt];
}
