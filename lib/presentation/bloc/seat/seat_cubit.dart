import 'package:booko/domain/repository/seat/seat_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  final SeatRepo seatRepo;

  SeatCubit(this.seatRepo) : super(SeatInitial());

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

  void onBuyTicket() {
    emit(SeatTicketBought());
  }
}
