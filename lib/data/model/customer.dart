import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (json['birthday'] != null && json['birthday'] is Timestamp) {
      json['birthday'] = json['birthday'].toDate();
    }

    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
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
      'birthday': Timestamp.fromDate(birthday!),
      'created_at': Timestamp.fromDate(createdAt!),
      'updated_at': Timestamp.fromDate(updatedAt!),
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
