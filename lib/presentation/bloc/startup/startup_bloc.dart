import 'dart:async';

import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final AppBloc _appBloc;
  final UserRepo _userRepo;
  final AuthRepo _authRepo;
  late StreamSubscription<AppState> _appBlocSubscription;

  StartupBloc({required AppBloc appBloc, required UserRepo userRepo, required AuthRepo authRepo})
      : _appBloc = appBloc,
        _userRepo = userRepo,
        _authRepo = authRepo,
        super(StartupInitial()) {
    _appBlocSubscription = _appBloc.stream.listen((state) async {
      if (state.status == AppStatus.authenticated) {
        await _userRepo.fetchData(id: authRepo.currentUser!.uid);
        add(NavigateToHome());
      } else if (state.status == AppStatus.unauthenticated) {
        add(NavigateToLogin());
      }
    });

    on<NavigateToHome>((event, emit) async {
      await _userRepo.fetchData(id: authRepo.currentUser!.uid);
      emit(StartupHome());
    });
    on<NavigateToLogin>((event, emit) {
      emit(StartupLogin());
    });
  }

  @override
  Future<void> close() {
    _appBlocSubscription.cancel();
    return super.close();
  }
}
