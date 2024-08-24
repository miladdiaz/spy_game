import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/logo.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/sidebar.dart';
import 'package:spy_game/widgets/timer.dart';
import 'package:spy_game/widgets/word_box.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);
    gameNotifier.startSocket();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 13, 63),
      body: Container(
        padding: const EdgeInsets.only(top: 64),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/dark_house.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Sidebar(position: "left"),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const Logo(),
                  const SizedBox(height: 16),
                  Button(onPressed: gameNotifier.startSocket, label: "label"),
                  Text(
                    game.token ?? "No token",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const WordBox(),
                  Text(
                    game.players.isEmpty
                        ? "Waiting for players"
                        : "${game.players[game.currentPlayerIndex].name} ${game.currentPlayerIndex + 1}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  game.state == "timer"
                      ? TimerWidget(
                          time: game.time,
                        )
                      : game.isShowWord
                          ? Button(
                              color: Colors.green,
                              onPressed: () {
                                if (game.currentPlayerIndex + 1 ==
                                    game.players.length) {
                                  print('startTimer');
                                  // start timer
                                  gameNotifier.startTimer();
                                } else {
                                  gameNotifier.setShowWord(false);
                                  gameNotifier.nextPlayer();
                                }
                              },
                              label: "I got it, let's go",
                            )
                          : Button(
                              onPressed: () {
                                gameNotifier.setShowWord(true);
                              },
                              label: "show me my role",
                            ),
                ],
              ),
            ),
            const Sidebar(position: "right"),
          ],
        ),
      ),
    );
  }
}
