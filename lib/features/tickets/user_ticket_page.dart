import 'package:acinema_flutter_project/features/tickets/data/repository/tickets_repository.dart';
import 'package:acinema_flutter_project/features/tickets/presentation/cubit/tickets_cubit.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/model/user_ticket_model.dart';

class UserTicketPage extends StatefulWidget {
  const UserTicketPage({super.key});

  @override
  State<UserTicketPage> createState() => _UserTicketPageState();
}

class _UserTicketPageState extends State<UserTicketPage> {
  late TicketsCubit ticketsCubit;

  @override
  void initState() {
    ticketsCubit = TicketsCubit(TicketsRepository(Dio()));
    ticketsCubit.loadTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Display'),
      ),
      body: BlocConsumer<TicketsCubit, TicketsState>(
        bloc: ticketsCubit,
        listener: (context, state) {
          if (state is TicketsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(
                        fontFamily: "FixelText",
                        color: Theme.of(context).colorScheme.onError),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error),
            );
          }
        },
        builder: (context, state) {
          if (state is TicketsLoading) {
            return const CircularProgressIndicator(
              color: Colors.greenAccent,
            );
          } else if (state is TicketsLoaded) {
            return ListView.builder(
              itemCount: state.tickets.length,
              itemBuilder: (context, index) {
                UserTicketModel ticket = state.tickets[index];
                return ListTile(
                  title: Text(
                    ticket.name,
                    style: const TextStyle(
                        fontFamily: "FixelDisplay",
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Text(
                        'Date: ${DateTime.fromMillisecondsSinceEpoch(ticket.date * 1000)}',
                        style: const TextStyle(
                            fontFamily: "FixelText",
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                          child: Image.network(
                        ticket.smallImage,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 200,
                        fit: BoxFit.cover,
                      )),
                      const SizedBox(height: 8.0),
                      BarcodeWidget(
                          height: 100,
                          data: ticket.id.toString(),
                          barcode: Barcode.code39()),
                    ],
                  ),
                );
              },
            );
          }
          return const Text(
            "Check your internet connection",
            style: TextStyle(
                fontFamily: "FixelDisplay",
                fontSize: 20,
                color: Colors.redAccent),
          );
        },
      ),
    );
  }
}
