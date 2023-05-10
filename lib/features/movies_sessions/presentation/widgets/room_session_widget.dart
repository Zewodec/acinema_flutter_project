import 'package:acinema_flutter_project/features/movies_sessions/data/models/movie_sessions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    return ResponsiveGridList(
        rowMainAxisAlignment: MainAxisAlignment.center,
        desiredItemWidth: 100,
        minSpacing: 10,
        children: [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20
        ].map((i) {
          return Container(
            height: ((i % 5) + 1) * 100.0,
            alignment: const Alignment(0, 0),
            color: Colors.cyan,
            child: Text(i.toString()),
          );
        }).toList());
  }
}
