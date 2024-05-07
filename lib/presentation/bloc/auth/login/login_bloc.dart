import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;

  LoginBloc({required this.authRepo, required this.userRepo}) : super(LoginState()) {
    on<LoginOnEmailChanged>((event, emit) {
      if (state is LoginFailure) {
        emit(LoginState(email: event.email, isEmailValid: event.isValid));
      } else {
        emit(state.copyWith(email: event.email, isEmailValid: event.isValid));
      }
    });

    on<LoginOnPasswordChanged>((event, emit) {
      if (state is LoginFailure) {
        emit(LoginState(password: event.password, isPasswordValid: event.isValid));
      } else {
        emit(state.copyWith(password: event.password, isPasswordValid: event.isValid));
      }
    });

    on<LoginToggleObscure>((event, emit) {
      if (state is LoginFailure) {
        emit(LoginState(isObscure: event.isObscure));
      } else {
        emit(state.copyWith(isObscure: event.isObscure));
      }
    });

    on<LoginRequesting>((event, emit) async {
      if (state.isPasswordValid && state.isEmailValid) {
        final email = state.email!;
        final password = state.password!;

        emit(LoginLoading());
        try {
          await authRepo.login(email, password);
          await userRepo.fetchData(id: authRepo.currentUser!.uid);
          emit(LoginSuccess());
        } on LoginException catch (e) {
          emit(LoginFailure(e.message));
        }
      } else {
        emit(LoginFailure('Invalid username or password'));
      }
    });
  }
}
