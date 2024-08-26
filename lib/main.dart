import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/screens/home_screen.dart';
import 'package:spy_game/screens/play_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Spy Game',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/play': (context) => const PlayScreen(),
      },
    );
  }
}
