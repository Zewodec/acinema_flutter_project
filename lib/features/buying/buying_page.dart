import 'package:acinema_flutter_project/features/buying/presentation/widgets/buying_ticket_widget.dart';
import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:flutter/material.dart';

import '../movies/data/models/movie_model.dart';

class BuyingPage extends StatefulWidget {
  const BuyingPage(
      {Key? key,
      required this.movieSessionModel,
      required this.movie,
      required this.sessionTickets})
      : super(key: key);

  final MovieSessionModel movieSessionModel;
  final MovieModel movie;
  final Map<int, String> sessionTickets;

  @override
  State<BuyingPage> createState() => _BuyingPageState();
}

class _BuyingPageState extends State<BuyingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                widget.movie.name,
                style: TextStyle(
                    fontFamily: "FixelDisplay",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.tertiary),
              )),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                  itemCount: widget.sessionTickets.length,
                  itemBuilder: (context, index) {
                    return BuyingTicketWidget(
                        ticket: widget.sessionTickets, index: index);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
