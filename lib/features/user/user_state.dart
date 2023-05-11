part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  UserLoaded(this.user);

  final UserModel user;

  @override
  List<Object?> get props => [user];
}
