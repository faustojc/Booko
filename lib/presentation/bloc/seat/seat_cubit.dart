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
    Set<String> seats = seatRepo.selectedSeats.map((e) => e.toString()).toSet();

    /// Format:
    /// List<String> data = [
    ///   schedule (from DateTime),
    ///   seats (from int),
    ///   price
    /// ]
    List<String> data = [];

    for (String seat in seats) {
      data.add([
        seatRepo.selectedSchedule!.toIso8601String(),
        seat,
        seatRepo.movie.price.toString(),
      ].join('/'));
    }

    emit(SeatTicketBought(data: data));
  }
}
