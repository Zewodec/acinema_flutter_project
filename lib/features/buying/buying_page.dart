import 'package:acinema_flutter_project/features/buying/presentation/widgets/buying_ticket_widget.dart';
import 'package:acinema_flutter_project/features/buying/presentation/widgets/debit_card_widget.dart';
import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
  final List<Seat> sessionTickets;

  @override
  State<BuyingPage> createState() => _BuyingPageState();
}

class _BuyingPageState extends State<BuyingPage> {
  double totalPrice = 0;

  @override
  void initState() {
    for (Seat seat in widget.sessionTickets) {
      totalPrice += seat.price;
    }
    super.initState();
  }

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
              Expanded(
                child: ListView.builder(
                    itemCount: widget.sessionTickets.length,
                    itemBuilder: (context, index) {
                      int row = 1;
                      for (int i = 0;
                          i < widget.movieSessionModel.room.rows.length;
                          i++) {
                        for (int j = 0;
                            j <
                                widget.movieSessionModel.room.rows[i].seats
                                    .length;
                            j++) {
                          if (widget
                                  .movieSessionModel.room.rows[i].seats[j].id ==
                              widget.sessionTickets[index].id) {
                            row = i + 1;
                          }
                        }
                      }
                      return BuyingTicketWidget(
                          cinema: widget.movieSessionModel.room.name,
                          seat: widget.sessionTickets[index].index.toString(),
                          row: row.toString(),
                          price: widget.sessionTickets[index].price.toDouble());
                    }),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Text(
                "Total: $totalPrice₴",
                style: TextStyle(
                    fontFamily: "FixelDisplay",
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: DebitCardWidget(),
                          type: PageTransitionType.rightToLeft));
                },
                child: const Text(
                  "Buy Tickets!",
                  style: TextStyle(
                    fontFamily: "FixelDisplay",
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
