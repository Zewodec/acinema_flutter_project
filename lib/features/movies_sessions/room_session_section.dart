import 'package:acinema_flutter_project/core/widgets/loading_screen.dart';
import 'package:acinema_flutter_project/features/buying/buying_page.dart';
import 'package:acinema_flutter_project/features/buying/presentation/cubit/buying_cubit.dart';
import 'package:acinema_flutter_project/features/movies/data/models/movie_model.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/session_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

import 'presentation/widgets/room_session_widget.dart';

class RoomSessionSection extends StatefulWidget {
  const RoomSessionSection({Key? key, required this.movie}) : super(key: key);
  final MovieModel movie;

  @override
  State<RoomSessionSection> createState() => _RoomSessionSectionState();
}

class _RoomSessionSectionState extends State<RoomSessionSection> {
  late SessionRoomCubit sessionRoomCubit;

  @override
  void initState() {
    sessionRoomCubit = GetIt.I.get<SessionRoomCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: sessionRoomCubit,
        listener: (context, state) {
          if (state is SessionRoomError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Error room showing!\n${state.errorMessage}",
                style: TextStyle(
                    fontFamily: "FixelText",
                    color: Theme.of(context).colorScheme.onError),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          if (state is SessionRoomLoading) {
            return const LoadingScreen();
          } else if (state is SessionRoomLoaded) {
            BlocProvider.of<BuyingCubit>(context)
                .setSessionId(state.movieSessionModel.id);
            return Column(
              children: [
                Text(
                  state.movieSessionModel.room.name,
                  style: const TextStyle(
                      fontFamily: "FixelText",
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.green, Colors.greenAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        border: Border.all(color: Colors.green)),
                    child: const Center(
                      child: Text(
                        "SCREEN",
                        style: TextStyle(
                            fontFamily: "FixelText",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context)
                        .size
                        .height, //TODO: Check this place for no error in debug
                    child: Expanded(
                      child: RoomSessionWidget(
                        movieSessionModel: state.movieSessionModel,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<BuyingCubit, BuyingState>(
                  builder: (context, state2) {
                    if (state2 is BookSeatsReadyState) {
                      return ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<BuyingCubit>(context).bookSeat();
                          },
                          child: const Text("Book Seats"));
                    } else if (state2 is BookingSeatsState) {
                      return const CircularProgressIndicator(
                        color: Colors.greenAccent,
                      );
                    } else if (state2 is BookingSuccessSeatsState) {
                      if (state2.bookResponse) {
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) => Navigator.push(
                                context,
                                PageTransition(
                                    child: BuyingPage(
                                      movieSessionModel:
                                          state.movieSessionModel,
                                      movie: widget.movie,
                                      sessionTickets:
                                          BlocProvider.of<BuyingCubit>(context)
                                              .selectedSeats,
                                    ),
                                    type: PageTransitionType.leftToRight)));
                        return const Text(
                          "Successful booking tickets!",
                          style: TextStyle(
                              fontFamily: "FixelText", color: Colors.green),
                        );
                      } else {
                        return const Text(
                          "Unsuccessful booking tickets!",
                          style: TextStyle(
                              fontFamily: "FixelText", color: Colors.redAccent),
                        );
                      }
                    } else if (state2 is BuyingErrorState) {
                      return const Text(
                        "Error booking tickets!",
                        style: TextStyle(
                            fontFamily: "FixelText", color: Colors.green),
                      );
                    }
                    return const Text("Select Seats to book and buy!");
                  },
                ),
              ],
            );
          }
          return const Text("Please, select date to show rooms!",
              style: TextStyle(
                  fontFamily: "FixelDisplay",
                  fontSize: 16,
                  color: Colors.greenAccent));
        });
  }
}
