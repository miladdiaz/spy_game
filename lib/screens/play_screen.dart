import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SPY Game | Play'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'Hold the Box to see the word',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTapDown: (_) {
                  ref.read(gameNotifierProvider.notifier).showWord();
                },
                onTapUp: (_) {
                  ref.read(gameNotifierProvider.notifier).hideWord();
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.80,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: game.isShowWord
                        ? Text(
                            game.word!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
