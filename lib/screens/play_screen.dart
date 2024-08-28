import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/providers/socket_provider.dart';
import 'package:spy_game/providers/user_provider.dart';
import 'package:spy_game/widgets/button.dart';
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
    final user = ref.watch(userNotifierProvider);
    final socketNotifier = ref.read(socketNotifierProvider.notifier);

    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are You Sure To Exit?'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //TODO: fix text
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  socketNotifier.disconnect();
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 13, 63),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/dark_house.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
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
                          Text(game.creatorDeviceId == user.deviceId
                              ? "You are the creator"
                              : "You are a player"),
                          const SizedBox(height: 16),
                          switch (game.status) {
                            GameStatus.idle => const Text('Idle'),
                            GameStatus.waiting =>
                              const Text('Waiting for players'),
                            GameStatus.timer => Column(
                                children: [
                                  const WordBox(),
                                  TimerWidget(time: game.time)
                                ],
                              ),
                            GameStatus.finished => const Text('Finished'),
                          },
                          const SizedBox(height: 16),
                          game.token != null &&
                                  game.creatorDeviceId == user.deviceId &&
                                  game.status == GameStatus.waiting
                              ? Button(
                                  color: Colors.green,
                                  label: "Start Game",
                                  onPressed: () {
                                    socketNotifier.startGame(game.token!);
                                  },
                                )
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          Button(
                            color: Colors.red,
                            label: "Exit Game",
                            onPressed: () {
                              showMyDialog();
                            },
                          )
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
