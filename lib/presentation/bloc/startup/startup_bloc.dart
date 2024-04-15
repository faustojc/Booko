import 'package:booko/presentation/repository/startup/startup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  late StartupRepo startupRepo;

  StartupBloc() : super(StartupInitial()) {
    on<StartupCheckAuth>((event, emit) {
      emit(StartupLoading());

      if (startupRepo.isLoggedIn()) {
        emit(StartupAuthenticated());
      } else {
        emit(StartupUnauthenticated());
      }
    });
  }

  // Fetch the
  void _fetchData() {

  }
}
