import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loading"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
