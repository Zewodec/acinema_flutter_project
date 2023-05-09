import 'package:flutter/material.dart';

class SessionButtonWidget extends StatelessWidget {
  final DateTime dateTime;

  const SessionButtonWidget({Key? key, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${dateTime.day}-${dateTime.month}",
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay",
                color: Colors.greenAccent),
          ),
          const SizedBox(
            width: 80,
          ),
          Text(
            "${dateTime.hour}:${dateTime.minute}",
            style: const TextStyle(
                fontSize: 14.0,
                fontFamily: "FixelDisplay",
                color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }
}
