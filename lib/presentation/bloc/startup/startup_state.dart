part of 'startup_bloc.dart';


abstract class StartupState {}

class StartupInitial extends StartupState {}
class StartupLoading extends StartupState {}
class StartupAuthenticated extends StartupState {}
class StartupUnauthenticated extends StartupState {}
