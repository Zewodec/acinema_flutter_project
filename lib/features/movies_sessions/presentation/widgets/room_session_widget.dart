import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:flutter/material.dart';

class RoomSessionWidget extends StatefulWidget {
  const RoomSessionWidget({Key? key, required this.movieSessionModel})
      : super(key: key);

  final MovieSessionModel movieSessionModel;

  @override
  State<RoomSessionWidget> createState() => _RoomSessionWidgetState();
}

class _RoomSessionWidgetState extends State<RoomSessionWidget> {
  @override
  Widget build(BuildContext context) {
    List<RoomRow> rows = widget.movieSessionModel.room.rows;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows.map((seatRow) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: seatRow.seats.map((seat) {
              return SeatWidget(seat: seat);
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class SeatWidget extends StatelessWidget {
  final Seat seat;

  const SeatWidget({super.key, required this.seat});

  @override
  Widget build(BuildContext context) {
    final color = seat.isAvailable ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.all(4),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('${seat.index}'),
    );
  }
}
