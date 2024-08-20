import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/counter.dart';
import 'package:spy_game/widgets/logo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, t});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 13, 63),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/dark_house.png"),
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Logo(),
              const SizedBox(height: 64),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Counter(
                    label: 'Spy',
                    count: 4,
                    startFrom: 1,
                    onChange: gameNotifier.setSpyCount,
                  ),
                  Counter(
                    label: 'Citizens',
                    count: 30,
                    startFrom: 2,
                    onChange: gameNotifier.setCitizenCount,
                  ),
                  Counter(
                    label: 'Time',
                    count: 30,
                    startFrom: 1,
                    onChange: gameNotifier.setGameTime,
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Button(
                label:
                    'Start with ${game.spyCount} Spy & ${game.citizenCount} citizens',
                onPressed: () {
                  gameNotifier.startGame();
                  Navigator.pushNamed(context, '/play');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
