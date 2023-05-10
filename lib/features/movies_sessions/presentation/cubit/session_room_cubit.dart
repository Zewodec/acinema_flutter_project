import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'session_room_state.dart';

class SessionRoomCubit extends Cubit<SessionRoomState> {
  SessionRoomCubit() : super(SessionRoomInitial());

  void loadRoomForSession(MovieSessionModel movieSessionModel) {
    emit(SessionRoomLoading());
    Future.delayed(const Duration(seconds: 1))
        .then((value) => emit(SessionRoomLoaded(movieSessionModel)));
  }
}
