import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/firebase_options.dart';
import 'package:spy_game/screens/home_screen.dart';
import 'package:spy_game/screens/multi_device_screen.dart';
import 'package:spy_game/screens/play_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        '/multiDevice': (context) => const MultiDeviceScreen(),
        '/play': (context) => const PlayScreen(),
      },
    );
  }
}
