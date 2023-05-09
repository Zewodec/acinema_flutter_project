import 'package:acinema_flutter_project/features/movies_sessions/data/repository/movie_sessions_repository.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/sessions_cubit.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/widgets/session_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionSection extends StatefulWidget {
  const SessionSection({Key? key, required this.movieId, required this.date})
      : super(key: key);

  final String movieId;
  final DateTime? date;

  @override
  State<SessionSection> createState() => _SessionSectionState();
}

class _SessionSectionState extends State<SessionSection> {
  late SessionsCubit sessionsCubit;

  @override
  void initState() {
    ;
    sessionsCubit = SessionsCubit(MovieSessionsRepository(Dio()));
    sessionsCubit.loadSessions(widget.movieId, widget.date);
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
