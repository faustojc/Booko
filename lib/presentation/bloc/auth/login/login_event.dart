part of 'login_bloc.dart';

sealed class LoginEvent with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class LoginOnUsernameChanged extends LoginEvent {
  final String username;

  LoginOnUsernameChanged(this.username);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [username];
  }
}

final class LoginOnPasswordChanged extends LoginEvent {
  final String password;

  LoginOnPasswordChanged(this.password);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [password];
  }
}

final class LoginRequesting extends LoginEvent {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}
