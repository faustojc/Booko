import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;

  RegisterCubit({required this.authRepo, required this.userRepo}) : super(RegisterState());

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
    emit(state.copyWith(
      email: email,
      isEmailValid: isEmailValid,
      password: password,
      isPasswordValid: isPasswordValid,
      confirmPassword: confirmPassword,
      isConfirmPasswordValid: isConfirmPasswordValid,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday,
    ));
  }

  void onPasswordObscureChanged({bool? isPasswordObscure, bool? isConfirmPasswordObscure}) {
    emit(state.copyWith(isPasswordObscure: isPasswordObscure, isConfirmPasswordObscure: isConfirmPasswordObscure));
  }

  Future<void> register() async {
    if (state.isEmailValid && state.isPasswordValid && state.isConfirmPasswordValid && state.firstname != null && state.lastname != null && state.birthday != null) {
      final email = state.email!.trim();
      final password = state.password!.trim();
      final firstname = state.firstname!.trim();
      final lastname = state.lastname!.trim();
      final birthday = state.birthday!.toIso8601String();

      emit(RegisterLoading());

      try {
        await authRepo.register(email, password);
        await userRepo.createCustomer(firstname: firstname, lastname: lastname, birthday: birthday);

        emit(RegisterSuccess());
      } on RegisterException catch (e) {
        emit(RegisterFailed(message: e.message));
      }
    } else {
      emit(RegisterFailed(message: 'Please fill in all required fields'));
    }
  }
}
