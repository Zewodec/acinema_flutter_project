import 'package:acinema_flutter_project/features/movies/data/repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.repository) : super(MoviesInitial());

  final MovieRepository repository;

  void loadMovies() async {}
}
