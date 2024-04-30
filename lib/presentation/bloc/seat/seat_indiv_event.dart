part of "seat_indiv_bloc.dart";

sealed class SeatIndividualEvent with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class SeatIndividualActivate extends SeatIndividualEvent {}

final class SeatIndividualDeactivate extends SeatIndividualEvent {}

final class SeatIndividualOccupy extends SeatIndividualEvent {}

final class SeatIndividualUnoccupy extends SeatIndividualEvent {}
