part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class NotAuthorized extends AuthState {}

class Authorized extends AuthState {}

class ErrorAuthorization extends AuthState {}
