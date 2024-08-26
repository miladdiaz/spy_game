import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/widgets/logo.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/play_screen_header.dart';
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
              const PlayScreenHeader(),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Sidebar(position: "left", players: game.players),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Logo(),
                          const SizedBox(height: 16),
                          // show waiting for players
                          if (game.state == GameState.waiting)
                            const Text(
                              "Waiting for players",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          // show Timer
                          if (game.state == GameState.timer)
                            TimerWidget(
                              time: game.time,
                            ),
                          // show word
                          if (game.state == GameState.started) const WordBox(),
                        ],
                      ),
                    ),
                    Sidebar(position: "right", players: game.players),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
