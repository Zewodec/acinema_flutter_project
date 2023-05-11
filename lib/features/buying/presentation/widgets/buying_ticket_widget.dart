import 'package:flutter/material.dart';

class BuyingTicketWidget extends StatelessWidget {
  final String cinema;
  final String row;
  final String seat;
  final double price;

  const BuyingTicketWidget({
    super.key,
    required this.cinema,
    required this.seat,
    required this.row,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cinema: $cinema'),
          const SizedBox(height: 8),
          Text(
            'Seat: $row-$seat',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 8),
          Text('Price: ₴${price.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
