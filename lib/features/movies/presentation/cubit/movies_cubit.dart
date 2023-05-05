import 'package:acinema_flutter_project/features/movies/data/repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.repository) : super(MoviesInitial());

  final MovieRepository repository;

  void loadMovies() async {
    emit(MoviesLoading());

    final moviesData = await repository.dioGetAllMovies();

    if (isErrorInData(moviesData)) {
      return;
    }

    final movies = MovieModelImpl.fromJson(moviesData);

    emit(MoviesLoaded(movies.data));
  }

  void loadMoviesWithSearch(String searchMovieName) async {
    emit(MoviesLoading());

    final moviesData = await repository.dioGetMoviesBySearch(searchMovieName);

    if (isErrorInData(moviesData)) {
      return;
    }

    final movies = MovieModelImpl.fromJson(moviesData);

    emit(MoviesLoaded(movies.data));
  }

  void loadMoviesWithDate(String searchMovieDate) async {
    emit(MoviesLoading());

    final moviesData = await repository.dioGetMoviesByDate(searchMovieDate);

    if (isErrorInData(moviesData)) {
      return;
    }

    final movies = MovieModelImpl.fromJson(moviesData);

    emit(MoviesLoaded(movies.data));
  }

  bool isErrorInData(Map<String, dynamic> moviesData) {
    if (moviesData.containsKey("error") &&
        moviesData['error'].toString().isNotEmpty &&
        moviesData['error'] != null) {
      emit(MoviesError(moviesData['error']));
      return true;
    } else if (moviesData.containsKey("error") &&
        (moviesData['error'].toString().isEmpty ||
            moviesData['error'] == null)) {
      emit(MoviesError(
          "Something went wrong when getting movies getting error!"));
      return true;
    }
    return false;
  }
}
