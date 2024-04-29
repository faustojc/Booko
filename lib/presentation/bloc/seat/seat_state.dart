part of 'seat_cubit.dart';

abstract class SeatState with FastEquatable {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SeatInitial extends SeatState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}

class SeatOnInput extends SeatState {
  final DateTime? date;
  final DateTime? time;
  final List<String>? seatNumbers;

  SeatOnInput({
    this.date,
    this.time,
    this.seatNumbers,
  });

  SeatOnInput copyWith({
    DateTime? date,
    DateTime? time,
    List<String>? seatNumbers,
  }) {
    return SeatOnInput(
      date: date ?? this.date,
      time: time ?? this.time,
      seatNumbers: seatNumbers ?? this.seatNumbers,
    );
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters {
    super.hashParameters;
    return [];
  }
}
