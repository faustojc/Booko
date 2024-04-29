import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/movie.dart';

part 'seat_plan_event.dart';
part 'seat_plan_state.dart';

class SeatPlanBloc extends Bloc<SeatPlanEvent, SeatPlanState> {
  SeatPlanBloc() : super(SeatPlanInitial()) {
    on<SeatPlanUpdate>((event, emit) async {
      emit(SeatPlanChanged(
          seatsOccupied: event.seatsOccupied,
          seatsActivated: event.seatsActivated));
    });

    on<SeatPlanSetDate>((event, emit) async {
      emit(SeatPlanDateChanged(time: event.time, date: event.date));
    });
  }
}
