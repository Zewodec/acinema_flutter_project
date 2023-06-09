import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/sessions_cubit.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/widgets/session_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'presentation/cubit/session_room_cubit.dart';

class DateSessionSection extends StatefulWidget {
  const DateSessionSection(
      {Key? key, required this.movieId, required this.date})
      : super(key: key);

  final String movieId;
  final DateTime? date;

  @override
  State<DateSessionSection> createState() => _DateSessionSectionState();
}

class _DateSessionSectionState extends State<DateSessionSection> {
  late SessionsCubit sessionsCubit;
  late SessionRoomCubit sessionRoomCubit;

  @override
  void initState() {
    sessionsCubit = GetIt.I<SessionsCubit>();
    sessionsCubit.loadSessionsForNext3Days(widget.movieId, widget.date);
    sessionRoomCubit = GetIt.I.get<SessionRoomCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsCubit, SessionsState>(
      bloc: sessionsCubit,
      listener: (context, state) {
        if (state is SessionsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                "Sessions error!\n${state.errorMessage}",
                style: TextStyle(
                  fontFamily: "FixelText",
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SessionsLoading) {
          return const CircularProgressIndicator(
            color: Colors.greenAccent,
          );
        } else if (state is SessionsLoaded) {
          return SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: state.sessions.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SessionButtonWidget(
                    movieSessionModel: state.sessions[index],
                    dateTime: DateTime.fromMillisecondsSinceEpoch(
                        state.sessions[index].date * 1000,
                        isUtc: true));
              },
            ),
          );
        } else if (state is SessionsError) {
          return Text(
            "Error in getting sessions!",
            style: TextStyle(
                fontFamily: "FixelDisplay",
                fontSize: 24,
                color: Theme.of(context).colorScheme.error),
          );
        }
        return const Text("ERROR");
      },
    );
  }
}
