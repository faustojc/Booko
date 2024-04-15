import 'package:booko/data/model/base_model.dart';

class Customer extends BaseModel<Customer> {
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

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    address = json['address'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  @override
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
}
