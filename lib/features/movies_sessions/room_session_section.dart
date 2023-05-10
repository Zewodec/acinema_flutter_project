import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/sessions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'presentation/cubit/session_room_cubit.dart';

class RoomSessionSection extends StatefulWidget {
  const RoomSessionSection({Key? key}) : super(key: key);

  @override
  State<RoomSessionSection> createState() => _RoomSessionSectionState();
}

class _RoomSessionSectionState extends State<RoomSessionSection> {
  late SessionsCubit sessionCubit;
  late SessionRoomCubit sessionRoomCubit;

  @override
  void initState() {
    sessionCubit = GetIt.I<SessionsCubit>();
    sessionRoomCubit = SessionRoomCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SessionsCubit>(),
      child: BlocBuilder(
          bloc: sessionRoomCubit,
          builder: (context, state) {
            if (state is SessionRoomLoading) {
              return const CircularProgressIndicator(
                color: Colors.greenAccent,
              );
            } else if (state is SessionRoomLoaded) {
              // GridView.builder(gridDelegate: , itemBuilder: itemBuilder)
            }

            return const Text("Please, select date to show rooms!",
                style: TextStyle(
                    fontFamily: "FixelDisplay",
                    fontSize: 16,
                    color: Colors.greenAccent));
          }),
    );
  }
}
