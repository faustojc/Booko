import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  late String username;
  late String password;

  LoginBloc(this._authRepo) : super(LoginState()) {
    on<LoginOnUsernameChanged>((event, emit) {
      username = event.username;
      emit(state.copyWith(username: event.username));
    });

    on<LoginOnPasswordChanged>((event, emit) {
      password = event.password;
      emit(state.copyWith(password: event.password));
    });

    on<LoginRequesting>((event, emit) async {
      if (!state.isValid) {
        emit(LoginFailure('Invalid username or password'));
      } else {
        try {
          await _authRepo.login(username, password);
          emit(LoginSuccess());
        } on LoginException catch (e) {
          emit(LoginFailure(e.message));
        }
      }
    });
  }
}
