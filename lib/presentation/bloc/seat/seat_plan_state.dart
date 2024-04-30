part of "seat_plan_bloc.dart";

sealed class SeatPlanState with FastEquatable {
  late List<bool> seatsOccupied = [];
  late List<bool> seatsActivated = [];
  late DateTime? time;
  late DateTime? date;
  late Movie? movie;

  SeatPlanState(
      {this.seatsOccupied = const [],
      this.seatsActivated = const [],
      this.date,
      this.time,
      this.movie});

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class SeatPlanInitial extends SeatPlanState {
  SeatPlanInitial(
      {super.seatsOccupied,
      super.seatsActivated,
      super.time,
      super.date,
      super.movie});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class SeatPlanChanged extends SeatPlanState {
  SeatPlanChanged(
      {required super.seatsOccupied, required super.seatsActivated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [seatsOccupied, seatsActivated];
  }
}

final class SeatPlanDateChanged extends SeatPlanState {
  SeatPlanDateChanged({super.time, required super.date});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [time, date];
  }
}
