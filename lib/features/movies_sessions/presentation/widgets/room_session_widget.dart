import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

class RoomSessionWidget extends StatelessWidget {
  const RoomSessionWidget({Key? key, required this.movieSessionModel})
      : super(key: key);

  final MovieSessionModel movieSessionModel;

  @override
  Widget build(BuildContext context) {
    List<RoomRow> rows = movieSessionModel.room.rows;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: rows.map((seatRow) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: seatRow.seats.map((seat) {
                  return SeatWidget(
                    seat: seat,
                    row: seatRow.index,
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
