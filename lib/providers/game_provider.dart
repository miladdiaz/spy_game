import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/env.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:spy_game/models/player.dart';
import 'package:spy_game/models/server_response.dart';
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
      players: players,
      status: status,
      time: time,
      token: token,
      creatorDeviceId: creatorDeviceId,
    );
  }

  void startTimer() {
    state = state.copyWith(status: GameStatus.timer);
  }

  void resetGame() {
    state = const Game();
  }

  Future<ServerResponseStatus> createGame() async {
    // set state of game
    state = state.copyWith(status: GameStatus.waiting);

    // set random word from constants
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];
    final deviceId = await getDeviceId();

    state = state.copyWith(word: word, creatorDeviceId: deviceId);

    ServerResponse response = await createGameOnServer();

    if (response.status.type == 'success' && response.data['token'] != null) {
      ref.read(socketNotifierProvider.notifier).start(response.data['token']);
    }

    return response.status;
  }

  Future<List<Game>> getGames() async {
    final response = await http.get(Uri.http('localhost:3000', 'games'));

    final result = jsonDecode(response.body);

    return List.from(result.map((e) => Game.fromJson(e)));
  }

  Future<ServerResponse> createGameOnServer() async {
    // state = state.copyWith(players: []);

    final response = await http.post(
      isHttps ? Uri.https(backendUrl, 'games') : Uri.http(backendUrl, 'games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(state.toJSON()),
    );

    ServerResponse result = ServerResponse.fromJson(jsonDecode(response.body));

    return result;

    // if(newStatus.type == 'error') {
    //   throw Exception(newStatus.message);
    // }

    // Game newGame = Game.fromJson(result['data']);

    //   if (result['data']['token'] == null ||
    //       result['data']['word'] == null ||
    //       result['data']['creatorDeviceId'] == null) {
    //     throw Exception(result.status.message);
    //   }

    //   state = state.copyWith(
    //     token: result['data']['token'],
    //     word: result['data']['word'],
    //     creatorDeviceId: result['data']['creatorDeviceId'],
    //   );
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
