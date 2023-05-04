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
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const MainNavigation(), //const MyHomePage(title: 'Кінопокази'),
    );
  }
}
