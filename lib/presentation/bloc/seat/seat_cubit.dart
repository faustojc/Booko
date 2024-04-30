import 'package:booko/data/local/seat_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  late SeatData seatData = SeatData();

  SeatCubit() : super(SeatInitial());

  void onInputChanged({DateTime? schedule, String? seatNumber}) {
    emit(SeatInputChanged());

    seatData = seatData.copyWith(
      schedule: schedule,
      seatNumbers: seatNumber == null ? seatData.seatNumbers : [...?seatData.seatNumbers, seatNumber],
      occupied: true,
    );
  }

  void onBuyTicket() {
    emit(SeatTicketBought());
  }
}
