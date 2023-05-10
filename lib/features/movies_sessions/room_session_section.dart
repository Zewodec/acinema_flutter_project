import 'package:acinema_flutter_project/core/widgets/loading_screen.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/session_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'presentation/widgets/room_session_widget.dart';

class RoomSessionSection extends StatefulWidget {
  const RoomSessionSection({Key? key}) : super(key: key);

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
