import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/web_socket.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/providers/socket_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/counter.dart';
import 'package:spy_game/widgets/logo.dart';

class MultiDeviceScreen extends ConsumerWidget {
  const MultiDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    ref.listen(socketNotifierProvider, (previous, next) {
      if (previous?.status == next.status) {
        return;
      }

      // if joined game successfully, navigate to play screen
      if (next.status == WebSocketStatus.connected) {
        Navigator.pushNamed(context, '/play');
      }

      // show error message if game not found
      if (next.status == WebSocketStatus.error && next.message.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    return Scaffold(
      extendBody: true,
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Logo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Counter(
                    label: 'Spy',
                    count: 4,
                    startFrom: 1,
                    onChange: (i) => gameNotifier.setProperty(spyCount: i),
                  ),
                  Counter(
                    label: 'Citizens',
                    count: 30,
                    startFrom: 2,
                    onChange: (i) => gameNotifier.setProperty(citizenCount: i),
                  ),
                  Counter(
                    label: 'Time',
                    count: 30,
                    startFrom: 1,
                    onChange: (i) => gameNotifier.setProperty(
                      time: Duration(minutes: i),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Button(
                label:
                    'Create Game with ${game.spyCount} Spy & ${game.citizenCount} citizens',
                onPressed: () {
                  gameNotifier.createGame().then((res) {
                    if (res.type != 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res.message)),
                      );
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              Button(
                color: Colors.green,
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                label: "Back",
              )
            ],
          ),
        ),
      ),
    );
  }
}
