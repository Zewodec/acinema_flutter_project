part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSignIn extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  LoginError(this.errorMessage);

  final String errorMessage;

// String get errorMessage => _errorMessage;
}
