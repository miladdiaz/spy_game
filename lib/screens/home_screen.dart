import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/counter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, t});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SPY Game'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/spy.png',
            height: 200,
          ),
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
    );
  }
}
