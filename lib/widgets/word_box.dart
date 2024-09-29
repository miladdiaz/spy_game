import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/providers/user_provider.dart';

class WordBox extends ConsumerWidget {
  const WordBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);
    final user = ref.watch(userNotifierProvider);

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: MediaQuery.of(context).size.width * 0.45,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 4,
          ),
        ),
        child: Center(
          child: Text(
            gameNotifier.getPlayerByDeviceId(user.deviceId!).role == "spy"
                ? "YOU ARE SPY!"
                : game.word!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
