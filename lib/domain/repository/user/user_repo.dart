import 'package:booko/data/model/customer.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final AuthRepo _authRepo;

  late Customer customer = Customer();

  final Set<Ticket> tickets = {};

  UserRepo({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<void> fetchData({required String id}) async {
    customer = (await Customer().where('user_id', isEqualTo: id).get()).first;

    if (tickets.isEmpty) {
      tickets.addAll(await Ticket().where('user_id', isEqualTo: id).get());
    }
  }

  Future<void> fetchTickets({bool refresh = false}) async {
    if (refresh) {
      tickets.clear();
      tickets.addAll(await Ticket().where('user_id', isEqualTo: _authRepo.currentUser!.uid).orderBy('created_at', descending: true).get());
    } else if (tickets.isEmpty) {
      tickets.addAll(await Ticket().where('user_id', isEqualTo: _authRepo.currentUser!.uid).orderBy('created_at', descending: true).get());
    }
  }

  Future<void> createCustomer({required String firstname, required String lastname, required DateTime birthday}) async {
    final json = {
      'user_id': _authRepo.currentUser!.uid,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': Timestamp.fromDate(birthday),
    };

    final data = await Customer().insert(json);

    json.addAll({'id': data.id});

    customer = Customer.fromJson(json);
  }
}
