import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/providers/game_provider.dart';
import 'package:spy_game/widgets/player_widget.dart';

class Sidebar extends ConsumerWidget {
  final String position;
  const Sidebar({super.key, required this.position});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameNotifierProvider);

    return Expanded(
      child: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.only(
          top: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 2,
            ),
            left: position == "right"
                ? BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 2,
                  )
                : BorderSide.none,
            right: position == "left"
                ? BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 2,
                  )
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(position == "right" ? 0 : 32),
            topLeft: Radius.circular(position == "left" ? 0 : 32),
            bottomRight: const Radius.circular(0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              position == "left"
                  ? (game.players.length / 2).ceil()
                  : (game.players.length / 2).floor(),
              (i) => PlayerWidget(
                index: (position == "left"
                    ? i
                    : i + (game.players.length / 2).ceil()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
