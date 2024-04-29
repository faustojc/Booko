import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seat_state.dart';

class SeatCubit extends Cubit<SeatState> {
  SeatCubit() : super(SeatInitial());

  void onInputChanged({DateTime? date, DateTime? time, String? seatNumber}) {
    if (state is! SeatOnInput) {
      emit(SeatOnInput(
        date: date,
        time: time,
        seatNumbers: seatNumber == null ? [] : [seatNumber],
      ));
    } else {
      final state = this.state as SeatOnInput;

      emit(state.copyWith(
        date: date,
        time: time,
        seatNumbers: seatNumber == null ? state.seatNumbers : [...?state.seatNumbers, seatNumber],
      ));
    }
  }
}
