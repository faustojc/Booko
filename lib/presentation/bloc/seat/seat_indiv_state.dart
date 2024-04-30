part of "seat_indiv_bloc.dart";

sealed class SeatIndividualState with FastEquatable {
  late bool occupied;
  late bool activated;

  SeatIndividualState({this.occupied = false, this.activated = false});

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

final class SeatIndividualInitial extends SeatIndividualState {
  SeatIndividualInitial({super.occupied, super.activated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class SeatIndividualActivated extends SeatIndividualState {
  SeatIndividualActivated({super.occupied, super.activated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class SeatIndividualDeactivated extends SeatIndividualState {
  SeatIndividualDeactivated({super.occupied, super.activated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class SeatIndividualOccupied extends SeatIndividualState {
  SeatIndividualOccupied({super.occupied, super.activated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

final class SeatIndividualUnoccupied extends SeatIndividualState {
  SeatIndividualUnoccupied({super.occupied, super.activated});

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}
