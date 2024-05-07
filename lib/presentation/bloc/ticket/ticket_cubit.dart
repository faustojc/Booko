import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final UserRepo userRepo;

  TicketCubit({required this.userRepo}) : super(TicketInitial());

  Future<void> onFetchTickets() async {
    emit(TicketLoading());

    try {
      await userRepo.fetchTickets();
      emit(TicketLoaded());
    } catch (e) {
      emit(TicketError(message: e.toString()));
    }
  }
}
