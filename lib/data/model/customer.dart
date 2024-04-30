import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_equatable/fast_equatable.dart';

/// Represents a customer in the system.
///
/// The `Customer` class is responsible for storing information about a customer,
/// such as their ID, user ID, first name, last name, birthday, and timestamps. It provides methods for converting the customer object
/// to and from JSON format.
///
/// Example:
/// ```dart
/// final customer = Customer(
///   id: '123',
///   userId: '456',
///   firstname: 'John',
///   lastname: 'Doe',
///   birthday: DateTime(1990, 1, 1),
///   createdAt: DateTime.now(),
///   updatedAt: DateTime.now(),
/// );
/// ```
class Customer with QueryBuilder<Customer>, FastEquatable {
  String? id;
  String? userId;
  String? firstname;
  String? lastname;
  DateTime? birthday;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer({
    this.id,
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
      id: json['id'],
      userId: json['user_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      birthday: json['birthday'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// Converts the `Customer` object to a JSON map.
  ///
  /// Returns a map containing the customer's ID, user ID, first name, last name, birthday, creation timestamp, and update timestamp.
  ///
  /// Example:
  /// ```dart
  /// final customer = Customer(
  ///   id: '123',
  ///   userId: '456',
  ///   firstname: 'John',
  ///   lastname: 'Doe',
  ///   birthday: DateTime(1990, 1, 1),
  ///   createdAt: DateTime.now(),
  ///   updatedAt: DateTime.now(),
  /// );
  /// final json = customer.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  List<Object?> get hashParameters => [
        id,
        userId,
        firstname,
        lastname,
        birthday,
        createdAt,
        updatedAt,
      ];
}
