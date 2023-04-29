part of 'movies_cubit.dart';

@immutable
abstract class MoviesState extends Equatable {}

class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  MoviesLoaded(this.movies);

  final List<MovieModel> movies;

  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  MoviesError(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object> get props => [];
}
