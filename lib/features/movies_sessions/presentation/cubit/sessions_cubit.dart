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

  String lastMovieId = "";
  DateTime? lastDateTime = DateTime.now();

  void loadSessionsForNext3Days(String movieId, DateTime? date) async {
    emit(SessionsLoading());

    lastMovieId = movieId;
    lastDateTime = date;

    Map<String, dynamic> sessionsData = {};

    var gotSessionData = await repository.dioGetSessions(
        movieId, DateTime(date!.year, date.month, date.day));
    sessionsData.addAll(gotSessionData);
    if (isErrorInData(sessionsData)) {
      return;
    }

    MovieSessionsImpl sessions = MovieSessionsImpl.fromJson(sessionsData);

    for (int i = 1; i <= 3; i++) {
      gotSessionData = await repository.dioGetSessions(
          movieId, DateTime(date.year, date.month, date.day + i));
      if (isErrorInData(gotSessionData)) {
        return;
      }
      MovieSessionsImpl tempSeesionsModel =
          MovieSessionsImpl.fromJson(gotSessionData);
      sessions.data.addAll(tempSeesionsModel.data);
    }

    int milisecSinceEpoch = date.millisecondsSinceEpoch;
    int currentTimeStamp = (milisecSinceEpoch / 1000).floor();

    sessions.sortFromNewToOld();
    sessions.data.removeWhere(
        (element) => (element.date < currentTimeStamp) ? true : false);

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

  void loadSessionsForNext3DaysLast() {
    loadSessionsForNext3Days(lastMovieId, lastDateTime);
  }
}
