import 'package:flutter/material.dart';

import '../../data/models/movie_sessions.dart';

class SeatWidget extends StatefulWidget {
  final Seat seat;
  final int row;

  const SeatWidget({Key? key, required this.seat, required this.row})
      : super(key: key);

  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  Color color = Colors.greenAccent;
  Color textColor = Colors.black;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      color = Colors.amberAccent;
    } else {
      color = widget.seat.isAvailable
          ? Colors.greenAccent
          : Theme.of(context).colorScheme.errorContainer;
    }

    textColor = widget.seat.isAvailable
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onErrorContainer;

    return InkWell(
      splashColor: Colors.amber,
      onTap: () {
        if (widget.seat.isAvailable) {
          setState(() {
            isSelected = !isSelected;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '${widget.row}-${widget.seat.index}',
            style: TextStyle(
                fontFamily: 'FixelText', color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
