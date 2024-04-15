import 'package:firebase_auth/firebase_auth.dart';

class StartupRepo {
  bool isLoggedIn() {
    final currentUser = FirebaseAuth.instance.currentUser;

    return currentUser != null;
  }
}
