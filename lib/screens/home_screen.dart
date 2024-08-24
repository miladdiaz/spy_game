import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/button.dart';
import 'package:spy_game/widgets/counter.dart';
import 'package:spy_game/widgets/logo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, t});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 13, 63),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/dark_house.png"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Logo(),
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
                    gameNotifier.startGame().then((value) {
                      Navigator.pushNamed(context, '/play');
                    });
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.3),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Enter token',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1231),
                        ),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 16),
                      Button(
                        label: 'Join a game',
                        onPressed: () {
                          gameNotifier.startGame().then((value) {
                            // join the game
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
