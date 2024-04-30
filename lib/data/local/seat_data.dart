class SeatData {
  final DateTime? schedule;
  final List<String>? seatNumbers;
  late bool occupied;

  SeatData({
    this.schedule,
    this.seatNumbers = const [],
    this.occupied = false,
  });

  SeatData copyWith({
    DateTime? schedule,
    List<String>? seatNumbers,
    bool? occupied,
  }) {
    return SeatData(
      schedule: schedule ?? this.schedule,
      seatNumbers: seatNumbers ?? this.seatNumbers,
      occupied: occupied ?? this.occupied,
    );
  }
}
