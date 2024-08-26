import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';

class PlayerWidget extends ConsumerWidget {
  final int index;
  const PlayerWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);
    final isActive = game.currentPlayerIndex == index;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.02),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.person, color: Colors.black),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  (index + 1).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        isActive ? Colors.white : Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 16,
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  index > game.currentPlayerIndex
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
