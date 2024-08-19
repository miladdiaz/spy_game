import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/timer.dart';
import 'package:spy_game/widgets/word_box.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SPY Game | Play'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              game.state == "init"
                  ? Column(
                      children: [
                        const WordBox(),
                        Text(
                          '${game.players[game.currentPlayerIndex].name} ${game.currentPlayerIndex}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        game.currentPlayerIndex + 1 == game.players.length
                            ? Button(
                                label: 'Start Timer',
                                onPressed: () {
                                  gameNotifier.startTimer();
                                },
                                color: Colors.green,
                              )
                            : Button(
                                label: 'Next Player',
                                onPressed: gameNotifier.nextPlayer,
                              ),
                      ],
                    )
                  : const SizedBox(),
              game.state == "timer"
                  ? TimerWidget(
                      time: game.time,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
