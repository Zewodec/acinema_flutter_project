part of 'session_room_cubit.dart';

@immutable
abstract class SessionRoomState extends Equatable {}

class SessionRoomInitial extends SessionRoomState {
  @override
  List<Object?> get props => [];
}

class SessionRoomLoading extends SessionRoomState {
  @override
  List<Object?> get props => [];
}

class SessionRoomLoaded extends SessionRoomState {
  SessionRoomLoaded(this.movieSessionModel);

  final MovieSessionModel movieSessionModel;

  @override
  List<Object?> get props => [movieSessionModel];
}

class SessionRoomError extends SessionRoomState {
  SessionRoomError(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object> get props => [];
}
