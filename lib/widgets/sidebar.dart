import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/helpers/number.dart';
import 'package:spy_game/models/player.dart';
import 'package:spy_game/widgets/player_widget.dart';

class Sidebar extends ConsumerWidget {
  final String position;
  final List<Player>? players;
  const Sidebar({
    super.key,
    required this.position,
    this.players,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: players != null
              ? Column(
                  children: List.generate(
                    players!.length,
                    (index) => position == "right"
                        ? isOdd(index)
                            ? PlayerWidget(index: index)
                            : const SizedBox()
                        : isEven(index)
                            ? PlayerWidget(index: index)
                            : const SizedBox(),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
