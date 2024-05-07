import 'package:booko/data/model/movie.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xid/xid.dart';

class SeatRepo {
  final Movie movie;
  final Set<int> occupiedSeats = {};
  final Set<int> selectedSeats = {};
  final Set<Ticket> boughtTickets = {};
  late DateTime? selectedSchedule;

  late int quantity = 0;
  late double totalPrice = 0.0;

  SeatRepo({required this.movie}) {
    selectedSchedule = null;
  }

  Future<void> getSeatsData() async {
    final data = await Ticket().where('movie_id', isEqualTo: movie.id).get();

    occupiedSeats.addAll(data.map((e) => e.seatNumber!));
  }

  void setInputData({DateTime? schedule, int? seatNumber}) {
    if (schedule != null) {
      selectedSchedule = schedule;
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

  Future<void> buyTicket(User user) async {
    final db = FirebaseFirestore.instance;
    final batch = db.batch();

    for (int seat in selectedSeats) {
      final ticketRef = db.collection(Ticket().collectionName).doc();
      final xid = Xid().toString();
      final ticket = Ticket(
        id: ticketRef.id,
        userId: user.uid,
        seatNumber: seat,
        ticketNumber: xid,
        movieId: movie.id,
        movieTitle: movie.title,
        price: movie.price,
        schedule: selectedSchedule,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      boughtTickets.add(ticket);
      batch.set(ticketRef, ticket.toJson());
    }

    await batch.commit().catchError((err) => boughtTickets.clear());
  }
}
