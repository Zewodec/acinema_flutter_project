part of 'sessions_cubit.dart';

@immutable
abstract class SessionsState extends Equatable {}

class SessionsInitial extends SessionsState {
  @override
  List<Object?> get props => [];
}

class SessionsLoading extends SessionsState {
  @override
  List<Object?> get props => [];
}

class SessionsLoaded extends SessionsState {
  SessionsLoaded(this.sessions);

  final List<MovieSessionModel> sessions;

  @override
  List<Object?> get props => [sessions];
}

class SessionsError extends SessionsState {
  SessionsError(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [];
}
