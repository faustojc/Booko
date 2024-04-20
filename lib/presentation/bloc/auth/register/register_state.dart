part of 'register_cubit.dart';

final class RegisterState with FastEquatable {
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isPasswordObscure;
  final bool isConfirmPasswordObscure;

  RegisterState({
    this.email,
    this.password,
    this.confirmPassword,
    this.firstname,
    this.lastname,
    this.birthday,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isPasswordObscure = true,
    this.isConfirmPasswordObscure = true,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? firstname,
    String? lastname,
    DateTime? birthday,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isPasswordObscure,
    bool? isConfirmPasswordObscure,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthday: birthday ?? this.birthday,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isConfirmPasswordObscure: isConfirmPasswordObscure ?? this.isConfirmPasswordObscure,
    );
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        email,
        password,
        confirmPassword,
        firstname,
        lastname,
        birthday,
        isEmailValid,
        isPasswordValid,
        isConfirmPasswordValid,
        isPasswordObscure,
        isConfirmPasswordObscure,
      ];
}

final class RegisterLoading extends RegisterState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class RegisterSuccess extends RegisterState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed({required this.message});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [message];
  }
}
