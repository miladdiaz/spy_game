import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;

import '../models/player.dart';

class GameNotifier extends Notifier<Game> {
  @override
  Game build() {
    return const Game();
  }

  void setCitizenCount(int value) {
    state = state.copyWith(citizenCount: value);
  }

  void setSpyCount(int value) {
    state = state.copyWith(spyCount: value);
  }

  void setGameTime(int value) {
    state = state.copyWith(time: Duration(minutes: value));
  }

  void startGame() {
    // set state of game
    state = state.copyWith(state: 'init');

    // reset current player index
    state = state.copyWith(currentPlayerIndex: 0);

    // set random word from constants
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];

    // generate players
    final citizens = List.generate(
      state.citizenCount,
      (_) => const Player(name: 'Player ', role: "player"),
    );

    // generate spies
    final spies = List.generate(
      state.spyCount,
      (_) => const Player(name: 'Player', role: "spy"),
    );

    // combine players and spies and shuffle
    final List<Player> players = [...citizens, ...spies];
    players.shuffle();

    state = state.copyWith(word: word, players: players);
  }

  void setShowWord(bool value) {
    state = state.copyWith(isShowWord: value);
  }

  void startTimer() {
    state = state.copyWith(state: "timer", isShowWord: false);
  }

  void nextPlayer() {
    final currentPlayer = state.currentPlayerIndex + 1;
    if (currentPlayer >= state.players.length) {
      return;
    }

    state = state.copyWith(currentPlayerIndex: currentPlayer);
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
