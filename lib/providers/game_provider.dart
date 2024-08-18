import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;
import 'package:spy_game/models/player.dart';

class GameNotifier extends Notifier<Game> {
  @override
  Game build() {
    return const Game();
  }

  void setPlayerCount(int value) {
    final players = List.generate(
      value,
      (index) => Player(
        name: 'Player ${index + 1}',
        role: "player",
      ),
    );
    state = state.copyWith(players: players);
  }

  void setSpyCount(int value) {
    final spies = List.generate(
      value,
      (index) => Player(
        name: 'Player ${index + 1}',
        role: "spy",
      ),
    );
    state = state.copyWith(spies: spies);
  }

  void startGame() {
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];

    state = state.copyWith(word: word);
  }

  void showWord() {
    state = state.copyWith(isShowWord: true);
  }

  void hideWord() {
    state = state.copyWith(isShowWord: false);
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
