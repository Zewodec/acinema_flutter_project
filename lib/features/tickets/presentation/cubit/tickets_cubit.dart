import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_ticket_model.dart';
import '../../data/repository/tickets_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit(this.repository) : super(TicketsInitial());

  final TicketsRepository repository;

  void loadTickets() async {
    emit(TicketsLoading());
    final ticketsData = await repository.dioGetUserTickets();
    final tickets = UserTicketsImpl.fromJson(ticketsData);
    emit(TicketsLoaded(tickets.data));
  }
}
