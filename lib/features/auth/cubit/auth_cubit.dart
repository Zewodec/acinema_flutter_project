import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void checkIfUserAuthorized() async {
    try {
      if (await TokenLocalDataSource.isSavedSessionToken() &&
          await TokenLocalDataSource.isSavedAccessToken()) {
        Future.delayed(const Duration(seconds: 2))
            .then((value) => emit(Authorized()));
      } else {
        Future.delayed(const Duration(seconds: 2))
            .then((value) => emit(NotAuthorized()));
      }
    } catch (e) {
      emit(ErrorAuthorization());
    }
  }
}
