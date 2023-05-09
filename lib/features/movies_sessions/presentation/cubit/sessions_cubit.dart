import 'package:acinema_flutter_project/features/movies_sessions/data/repository/movie_sessions_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie_sessions.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit(this.repository) : super(SessionsInitial());

  final MovieSessionsRepository repository;

  void loadSessions(String movieId, DateTime? date) async {
    emit(SessionsLoading());

    final sessionsData = await repository.dioGetSessions(movieId, date);

    if (isErrorInData(sessionsData)) {
      return;
    }

    final sessions = MovieSessionsImpl.fromJson(sessionsData);

    emit(SessionsLoaded(sessions.data));
  }

  bool isErrorInData(Map<String, dynamic> sessionsData) {
    if (sessionsData.containsKey("error") &&
        sessionsData['error'].toString().isNotEmpty &&
        sessionsData['error'] != null) {
      emit(SessionsError(sessionsData['error']));
      return true;
    } else if (sessionsData.containsKey("error") &&
        (sessionsData['error'].toString().isEmpty ||
            sessionsData['error'] == null)) {
      emit(SessionsError("Something went wrong when getting sessions!"));
      return true;
    }
    return false;
  }
}
