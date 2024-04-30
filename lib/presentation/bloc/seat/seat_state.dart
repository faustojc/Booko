part of 'seat_cubit.dart';

@immutable
sealed class SeatState {}

final class SeatInitial extends SeatState {}

final class SeatLoading extends SeatState {}

final class SeatLoaded extends SeatState {}

final class SeatError extends SeatState {
  final String message;

  SeatError(this.message);
}

final class SeatInputChanged extends SeatState {}

final class SeatTicketBought extends SeatState {}
