import 'package:acinema_flutter_project/features/buying/presentation/cubit/buying_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    IconData iconType = Icons.chair_alt;
    switch (widget.seat.type) {
      case 0:
        iconType = Icons.chair_alt;
        break;
      case 1:
        iconType = Icons.star;
        break;
      case 2:
        iconType = Icons.chair;
        break;
    }

    return InkWell(
      splashColor: Colors.amber,
      onTap: () {
        if (widget.seat.isAvailable) {
          setState(() {
            isSelected = !isSelected;
          });
          if (isSelected) {
            BlocProvider.of<BuyingCubit>(context).addSelectedSeat(widget.seat);
          } else {
            BlocProvider.of<BuyingCubit>(context)
                .removeSelectedSeat(widget.seat);
          }
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
          child: Column(
            children: [
              Icon(
                iconType,
                color: Colors.deepOrangeAccent,
                size: 15,
              ),
              Text(
                '${widget.row}-${widget.seat.index}',
                style: TextStyle(
                    fontFamily: 'FixelText', color: textColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
