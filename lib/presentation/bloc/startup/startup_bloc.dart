import 'dart:async';

import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final AppBloc _appBloc;
  late StreamSubscription<AppState> _appBlocSubscription;

  StartupBloc({required AppBloc appBloc})
      : _appBloc = appBloc,
        super(StartupInitial()) {
    _appBlocSubscription = _appBloc.stream.listen((state) {
      if (state.status == AppStatus.authenticated) {
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
