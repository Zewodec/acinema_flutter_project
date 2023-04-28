import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void SignIn() {
    emit(LoginSignIn());
    Future.delayed(const Duration(seconds: 4))
        .then((value) => emit(LoginSuccess()));
  }
}
