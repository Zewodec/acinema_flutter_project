import 'package:acinema_flutter_project/core/main_navigation.dart';
import 'package:flutter/material.dart';

import 'core/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACinema',
      theme: ThemeData(/*useMaterial3: true,*/ colorScheme: lightColorScheme),
      darkTheme: ThemeData(
          /*useMaterial3: true,*/
          colorScheme: darkColorScheme),
      home: const MainNavigation(), //const MyHomePage(title: 'Кінопокази'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}
