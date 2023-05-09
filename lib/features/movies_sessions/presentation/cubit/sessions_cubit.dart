import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(SessionsInitial());
}
