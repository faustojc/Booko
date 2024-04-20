import 'package:booko/data/model/customer.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';

class UserRepo {
  final AuthRepo _authRepo;

  late Customer customer;

  final List<Ticket> tickets = [];

  UserRepo({required AuthRepo authRepo}) : _authRepo = authRepo;
  
  Future<void> fetchData() async {
    customer = (await Customer().where(field: 'user_id', operator: '==', value: _authRepo.currentUser!.uid).get()).first;
    tickets.addAll((await Ticket().where(field: 'customer_id', operator: '==', value: _authRepo.currentUser!.uid).get()).toList());
  }

  Future<void> createCustomer({required String firstname, required String lastname, required String birthday}) async {
    await Customer().insert({'firstname': firstname, 'lastname': lastname, 'birthday': birthday, 'user_id': _authRepo.currentUser!.uid});
    await fetchData();
  }
}