part of 'login_bloc.dart';

final class LoginState with FastEquatable {
  final String? username;
  final String? password;
  final bool isValid;

  LoginState({
    this.username,
    this.password,
    this.isValid = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isValid,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [username, password, isValid];
}

final class LoginSuccess extends LoginState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [message];
  }
}
