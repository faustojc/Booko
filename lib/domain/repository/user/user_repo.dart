import 'package:booko/data/model/customer.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';

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

  Future<void> createCustomer({required String firstname, required String lastname, required String birthday}) async {
    await Customer().insert({'firstname': firstname, 'lastname': lastname, 'birthday': birthday, 'user_id': _authRepo.currentUser!.uid});

    final json = {
      'user_id': _authRepo.currentUser!.uid,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    };

    customer = Customer.fromJson(json);
  }
}
