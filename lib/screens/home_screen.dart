import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/counter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, t});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SPY Game'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Image.asset(
          //   'assets/images/spy.png',
          //   height: 200,
          // ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Counter(
                  label: 'Spy',
                  count: 4,
                  startFrom: 1,
                  onChange: (value) {
                    ref.read(gameNotifierProvider.notifier).setSpyCount(value);
                  }),
              Counter(
                label: 'Players',
                count: 30,
                startFrom: 2,
                onChange: (value) {
                  ref.read(gameNotifierProvider.notifier).setPlayerCount(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 64),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              ref.read(gameNotifierProvider.notifier).startGame();
              Navigator.pushNamed(context, '/play');
            },
            child: Text(
              'Start with ${game.players.length} Players and ${game.spies.length} Spy',
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // game.players.map((e) => Text(e.name)).toList(),
          Column(
            children:
                game.players.map((e) => Text('${e.name}-${e.role}')).toList(),
          ),
          Column(
            children:
                game.spies.map((e) => Text('${e.name}-${e.role}')).toList(),
          )
        ],
      ),
    );
  }
}
