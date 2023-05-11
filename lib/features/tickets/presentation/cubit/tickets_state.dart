part of 'tickets_cubit.dart';

@immutable
abstract class TicketsState extends Equatable {}

class TicketsInitial extends TicketsState {
  @override
  List<Object?> get props => [];
}

class TicketsLoading extends TicketsState {
  @override
  List<Object?> get props => [];
}

class TicketsLoaded extends TicketsState {
  TicketsLoaded(this.tickets);

  final List<UserTicketModel> tickets;

  @override
  List<Object?> get props => [];
}
