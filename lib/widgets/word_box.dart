import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';

class WordBox extends ConsumerWidget {
  const WordBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);

    return Column(
      children: [
        const Text(
          'Hold the Box to see the word',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTapDown: (_) {
            ref.read(gameNotifierProvider.notifier).setShowWord(true);
          },
          onTapUp: (_) {
            ref.read(gameNotifierProvider.notifier).setShowWord(false);
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
                      game.players[game.currentPlayerIndex].role == 'spy'
                          ? 'SPY'
                          : game.word!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
