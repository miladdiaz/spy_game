import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/counter.dart';
import 'package:spy_game/widgets/logo.dart';

class MultiDeviceScreen extends ConsumerWidget {
  const MultiDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

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
            children: [
              const Logo(),
              // Text(game)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                onPressed: () async {
                  await gameNotifier.createGame().then((res) {
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, '/play');
                  }).catchError((e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
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
