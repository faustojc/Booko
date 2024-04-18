import 'package:booko/data/model/mixin/query_builder.dart';
import 'package:fast_equatable/fast_equatable.dart';

class Customer with QueryBuilder<Customer>, FastEquatable {
  String? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      address: json['address'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'address': address,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String get documentName => 'customers';

  @override
  fromJson(Map<String, dynamic> json) {
    return Customer.fromJson(json);
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [id, firstname, lastname, phone, address, createdAt, updatedAt];
}
