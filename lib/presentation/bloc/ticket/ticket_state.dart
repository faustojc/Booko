part of 'ticket_cubit.dart';

@immutable
sealed class TicketState {}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {}

class TicketError extends TicketState {
  final String message;

  TicketError({required this.message});
}
