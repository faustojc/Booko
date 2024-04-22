import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booko/data/model/movie.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepo movieRepo;

  MoviesBloc(this.movieRepo) : super(MoviesInitial()) {
    on<MoviesFetchInitialData>(
      (event, emit) async {
        if (movieRepo.movies.isEmpty) {
          emit(MoviesLoading(isFirstFetch: true));
          try {
            await movieRepo.fetchInitialData();
            emit(MoviesLoaded(movieRepo.movies));
          } catch (e) {
            emit(MoviesError(e.toString()));
          }
        }
      },
      transformer: droppable(),
    );

    on<MoviesFetchMoreData>(
      (event, emit) async {
        emit(MoviesLoading(isFirstFetch: false));
        try {
          await movieRepo.fetchMoreData();
          emit(MoviesLoaded(movieRepo.movies));
        } catch (e) {
          emit(MoviesError(e.toString()));
        }
      },
      transformer: droppable(),
    );

    on<MoviesFetchLatestData>(
      (event, emit) async {
        emit(MoviesLoading(isFirstFetch: false));
        try {
          await movieRepo.fetchLatestData();
          emit(MoviesLoaded(movieRepo.movies));
        } catch (e) {
          emit(MoviesError(e.toString()));
        }
      },
      transformer: droppable(),
    );
  }
}
