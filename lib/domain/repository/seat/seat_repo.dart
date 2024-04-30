import 'package:booko/data/model/movie.dart';
import 'package:booko/data/model/seat.dart';

class SeatRepo {
  final Movie movie;
  final Set<Seat> seats = {};
  final Set<int> selectedSeats = {};
  late DateTime? selectedDate;

  late int quantity = 0;
  late double totalPrice = 0.0;

  SeatRepo({required this.movie});

  Future<void> getSeatsData() async {
    seats.addAll(await Seat().where('movie_id', isEqualTo: movie.id).get());
  }

  void setInputData({DateTime? schedule, int? seatNumber}) {
    if (schedule != null) {
      selectedDate = schedule;
    }

    if (seatNumber != null) {
      // check if seat is already selected
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    }
    
    quantity = selectedSeats.length;
    totalPrice = quantity * movie.price!.toDouble();
  }
}
