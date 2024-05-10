import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/seat/seat_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  final SeatRepo seatRepo;
  final AuthRepo authRepo;
  final UserRepo userRepo;

  SeatCubit({required this.seatRepo, required this.authRepo, required this.userRepo}) : super(SeatInitial());

  Future<void> onFetchData() async {
    emit(SeatLoading());

    try {
      await seatRepo.getSeatsData();
      emit(SeatLoaded());
    } catch (e) {
      emit(SeatError(e.toString()));
    }
  }

  void onInputChanged({DateTime? schedule, int? seatNumber}) {
    emit(SeatInputChanged());

    seatRepo.setInputData(schedule: schedule, seatNumber: seatNumber);
  }

  void onConfirmSelection() {
    emit(SeatConfirmSelection());
  }

  Future<void> onBuyTicket() async {
    emit(SeatLoading());

    try {
      await seatRepo.buyTicket(authRepo.currentUser!);
      userRepo.tickets.addAll(seatRepo.boughtTickets);

      emit(SeatTicketBought(data: seatRepo.boughtTickets));
    } catch (err) {
      emit(SeatError(err.toString()));
    }
  }
}
