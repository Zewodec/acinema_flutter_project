import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:acinema_flutter_project/features/login/data/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository) : super(LoginInitial());

  final LoginRepository loginRepository;

  void signIn() async {
    emit(LoginSignIn());
    Future.delayed(const Duration(seconds: 1));
    String? errorMessage;
    if (!await TokenLocalDataSource.isSavedSessionToken()) {
      errorMessage = await loginRepository.dioGetSessionToken();
    }

    if (!await TokenLocalDataSource.isSavedAccessToken()) {
      errorMessage = await loginRepository.dioGetAccessToken();
    }

    if (await TokenLocalDataSource.isSavedSessionToken() &&
        await TokenLocalDataSource.isSavedAccessToken() &&
        errorMessage == null) {
      emit(LoginSuccess());
    } else {
      emit(LoginError(errorMessage!));
    }
  }
}
