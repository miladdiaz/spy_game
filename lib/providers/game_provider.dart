import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:spy_game/models/player.dart';

class GameNotifier extends Notifier<Game> {
  @override
  Game build() {
    return const Game();
  }

  void setPlayers(List<Player> players) {
    state = state.copyWith(players: players);
  }

  void setToken(String token) {
    state = state.copyWith(token: token);
  }

  void setCitizenCount(int value) {
    state = state.copyWith(citizenCount: value);
  }

  void setSpyCount(int value) {
    state = state.copyWith(spyCount: value);
  }

  Future<void> setGameTime(int value) async {
    state = state.copyWith(time: Duration(minutes: value));
  }

  Future<void> startGame() async {
    // set state of game
    state = state.copyWith(state: GameState.waiting);

    // reset current player index
    state = state.copyWith(currentPlayerIndex: 0);

    // set random word from constants
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];
    state = state.copyWith(word: word);

    await createGameOnServer();
  }

  void setShowWord(bool value) {
    state = state.copyWith(isShowWord: value);
  }

  void startTimer() {
    state = state.copyWith(state: GameState.timer, isShowWord: false);
  }

  Future<List<Game>> getGames() async {
    final response = await http.get(Uri.http('localhost:3000', 'games'));

    final result = jsonDecode(response.body);

    return List.from(result.map((e) => Game.fromJson(e)));
  }

  Future<void> createGameOnServer() async {
    final response = await http.post(
      Uri.http('localhost:3000', 'games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "citizenCount": state.citizenCount,
        "spyCount": state.spyCount,
        "word": state.word,
      }),
    );

    final result = jsonDecode(response.body);

    state = state.copyWith(token: result['token'], word: result['word']);
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
