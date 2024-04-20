import 'dart:async';

import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final AppBloc _appBloc;
  final UserRepo _userRepo;
  late StreamSubscription<AppState> _appBlocSubscription;

  StartupBloc({required AppBloc appBloc, required UserRepo userRepo})
      : _appBloc = appBloc,
        _userRepo = userRepo,
        super(StartupInitial()) {
    _appBlocSubscription = _appBloc.stream.listen((state) async {
      if (state.status == AppStatus.authenticated) {
        await _userRepo.fetchData();
        add(NavigateToHome());
      } else if (state.status == AppStatus.unauthenticated) {
        add(NavigateToLogin());
      }
    });

    on<NavigateToHome>((event, emit) {
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
