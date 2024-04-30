part of 'seat_cubit.dart';

@immutable
sealed class SeatState {}

final class SeatInitial extends SeatState {}

final class SeatInputChanged extends SeatState {}

final class SeatTicketBought extends SeatState {}
