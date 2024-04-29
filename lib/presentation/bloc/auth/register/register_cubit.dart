import 'package:booko/data/local/registration_data.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  late RegistrationData data = RegistrationData();

  RegisterCubit({required AuthRepo authRepo, required UserRepo userRepo})
      : _userRepo = userRepo,
        _authRepo = authRepo,
        super(RegisterInitial());

  void onInputChanged({
    String? email,
    bool? isEmailValid,
    String? password,
    bool? isPasswordValid,
    String? confirmPassword,
    bool? isConfirmPasswordValid,
    String? firstname,
    String? lastname,
    DateTime? birthday,
  }) {
    emit(RegisterInputChanged());
    data = data.copyWith(
      email: email,
      isEmailValid: isEmailValid,
      password: password,
      isPasswordValid: isPasswordValid,
      confirmPassword: confirmPassword,
      isConfirmPasswordValid: isConfirmPasswordValid,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday,
    );
  }

  Future<void> register() async {
    if (data.isEmailValid && data.isPasswordValid && data.isConfirmPasswordValid && data.firstname != null && data.lastname != null && data.birthday != null) {
      emit(RegisterLoading());

      try {
        await _authRepo.register(data.email!.trim(), data.password!.trim());
        await _userRepo.createCustomer(
          firstname: data.firstname!.trim(),
          lastname: data.lastname!.trim(),
          birthday: data.birthday!,
        );

        emit(RegisterSuccess());
      } on RegisterException catch (e) {
        emit(RegisterFailed(e.message));
      }
    } else {
      emit(RegisterFailed("Please fill in all required fields"));
    }
  }
}
