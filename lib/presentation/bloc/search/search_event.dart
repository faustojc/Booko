part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchQueried extends SearchEvent {
  final String query;

  SearchQueried(this.query);
}
