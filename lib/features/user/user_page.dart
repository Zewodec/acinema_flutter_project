import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${user.id}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Name: ${user.name}'),
            Text('Phone Number: ${user.phoneNumber}'),
            const SizedBox(height: 16.0),
            Text(
                'Created At: ${DateTime.fromMillisecondsSinceEpoch(user.createdAt * 1000)}'),
            Text(
                'Updated At: ${DateTime.fromMillisecondsSinceEpoch(user.updatedAt * 1000)}'),
          ],
        ),
      ),
    );
  }
}
