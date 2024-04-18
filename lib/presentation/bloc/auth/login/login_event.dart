part of 'login_bloc.dart';

sealed class LoginEvent with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class LoginOnEmailChanged extends LoginEvent {
  final String email;
  final bool isValid;

  LoginOnEmailChanged(this.email, this.isValid);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [email, isValid];
  }
}

final class LoginOnPasswordChanged extends LoginEvent {
  final String password;
  final bool isValid;

  LoginOnPasswordChanged(this.password, this.isValid);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [password, isValid];
  }
}

final class LoginToggleObscure extends LoginEvent {
  final bool isObscure;

  LoginToggleObscure(this.isObscure);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [isObscure];
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
