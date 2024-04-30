import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seat_indiv_event.dart';
part 'seat_indiv_state.dart';

class SeatIndividual extends Bloc<SeatIndividualEvent, SeatIndividualState> {
  SeatIndividual() : super(SeatIndividualInitial()) {
    on<SeatIndividualActivate>((event, emit) async {
      emit(SeatIndividualActivated(activated: true));
    });

    on<SeatIndividualDeactivate>((event, emit) async {
      emit(SeatIndividualDeactivated(activated: false));
    });

    on<SeatIndividualOccupy>((event, emit) async {
      emit(SeatIndividualOccupied(occupied: true));
    });

    on<SeatIndividualUnoccupy>((event, emit) async {
      emit(SeatIndividualUnoccupied(occupied: false));
    });
  }
}
