import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/session_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SessionButtonWidget extends StatelessWidget {
  final DateTime dateTime;
  final MovieSessionModel movieSessionModel;

  const SessionButtonWidget(
      {Key? key, required this.dateTime, required this.movieSessionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          GetIt.I.get<SessionRoomCubit>().loadRoomForSession(movieSessionModel);
        },
        borderRadius: BorderRadius.circular(6.0),
        splashColor: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay",
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "FixelDisplay",
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              movieSessionModel.type,
              style: const TextStyle(fontFamily: "FixelText"),
            ),
          ],
        ),
      ),
    );
  }
}
