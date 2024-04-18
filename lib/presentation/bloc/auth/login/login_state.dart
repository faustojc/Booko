part of 'login_bloc.dart';

final class LoginState with FastEquatable {
  final String? email;
  final String? password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isObscure;

  LoginState({
    this.email,
    this.password,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isObscure = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isObscure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [email, password, isEmailValid, isPasswordValid, isObscure];
}

final class LoginLoading extends LoginState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
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
