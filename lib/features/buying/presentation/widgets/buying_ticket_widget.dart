import 'package:flutter/material.dart';

class BuyingTicketWidget extends StatelessWidget {
  const BuyingTicketWidget(
      {Key? key, required this.ticket, required this.index})
      : super(key: key);

  final Map<int, String> ticket;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(ticket[index] ?? "Err")],
    );
  }
}
