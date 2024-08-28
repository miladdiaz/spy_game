import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/env.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:spy_game/models/player.dart';
import 'package:spy_game/providers/socket_provider.dart';

class GameNotifier extends Notifier<Game> {
  @override
  Game build() {
    return const Game();
  }

  void setProperty({
    int? citizenCount,
    int? spyCount,
    String? word,
    bool? isShowWord,
    int? currentPlayerIndex,
    List<Player>? players,
    GameStatus? status,
    Duration? time,
    String? token,
    String? creatorDeviceId,
  }) {
    state = state.copyWith(
      citizenCount: citizenCount,
      spyCount: spyCount,
      word: word,
      isShowWord: isShowWord,
      currentPlayerIndex: currentPlayerIndex,
      players: players,
      status: status,
      time: time,
      token: token,
      creatorDeviceId: creatorDeviceId,
    );
  }

  void startTimer() {
    state = state.copyWith(status: GameStatus.timer, isShowWord: false);
  }

  Future<void> createGame() async {
    // set state of game
    state = state.copyWith(status: GameStatus.waiting);

    // reset current player index
    state = state.copyWith(currentPlayerIndex: 0);

    // set random word from constants
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];
    final deviceId = await getDeviceId();

    state = state.copyWith(word: word, creatorDeviceId: deviceId);

    await createGameOnServer();

    ref.read(socketNotifierProvider.notifier).start(state.token!);
  }

  Future<List<Game>> getGames() async {
    final response = await http.get(Uri.http('localhost:3000', 'games'));

    final result = jsonDecode(response.body);

    return List.from(result.map((e) => Game.fromJson(e)));
  }

  Future<void> createGameOnServer() async {
    //TODO: error handling

    final response = await http.post(
      isHttps ? Uri.https(backendUrl, 'games') : Uri.http(backendUrl, 'games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "citizenCount": state.citizenCount,
        "spyCount": state.spyCount,
        "word": state.word,
        "creatorDeviceId": state.creatorDeviceId,
      }),
    );

    final result = jsonDecode(response.body);

    state = state.copyWith(token: result['token'], word: result['word']);
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
