part of "seat_plan_bloc.dart";

sealed class SeatPlanEvent with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class SeatPlanUpdate extends SeatPlanEvent {
  final List<bool> seatsOccupied;
  final List<bool> seatsActivated;

  SeatPlanUpdate(this.seatsOccupied, this.seatsActivated);

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [seatsActivated, seatsOccupied];
  }
}

final class SeatPlanSetDate extends SeatPlanEvent {
  final DateTime? date;
  final DateTime? time;

  SeatPlanSetDate({this.date, this.time});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [date, time];
  }
}
