part of 'startup_bloc.dart';

@immutable
abstract class StartupEvent {}

final class StartupCheckAuth extends StartupEvent {}
