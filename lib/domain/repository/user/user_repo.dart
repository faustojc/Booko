import 'package:booko/data/model/customer.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final AuthRepo _authRepo;

  late Customer customer = Customer();

  final List<Ticket> tickets = [];

  UserRepo({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<void> fetchData() async {
    customer = (await Customer().where('user_id', isEqualTo: _authRepo.currentUser!.uid).get()).first;

    if (tickets.isEmpty) {
      tickets.addAll(await Ticket().where('user_id', isEqualTo: _authRepo.currentUser!.uid).get());
    }
  }

  Future<void> createCustomer({required String firstname, required String lastname, required DateTime birthday}) async {
    final json = {
      'user_id': _authRepo.currentUser!.uid,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': Timestamp.fromDate(birthday),
      'created_at': Timestamp.now(),
      'updated_at': Timestamp.now(),
    };

    final data = await Customer().insert({
      'user_id': json['user_id'],
      'firstname': json['firstname'],
      'lastname': json['lastname'],
      'birthday': json['birthday'],
    });

    json.addAll({'id': data.id});

    customer = Customer.fromJson(json);
  }
}
