import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/env.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/game.dart';
import 'package:http/http.dart' as http;
import 'package:spy_game/models/player.dart';
import 'package:spy_game/models/server_response.dart';
import 'package:spy_game/providers/socket_provider.dart';
import 'package:spy_game/providers/user_provider.dart';

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

    // get device id
    final deviceId = await getDeviceId();

    state = state.copyWith(creatorDeviceId: deviceId);

    ServerResponse response = await createGameOnServer();

    if (response.status.type == 'success' && response.data['token'] != null) {
      ref.read(socketNotifierProvider.notifier).start(response.data['token']);
    }

    return response.status;
  }

  Future<ServerResponse> createGameOnServer() async {
    String? authToken = ref.read(userNotifierProvider.notifier).state.authToken;

    final response = await http.post(
      isHttps ? Uri.https(backendUrl, 'games') : Uri.http(backendUrl, 'games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authToken!,
        'device-id': state.creatorDeviceId!,
      },
      body: jsonEncode(state.toJSON()),
    );

    ServerResponse result = ServerResponse.fromJson(jsonDecode(response.body));

    return result;
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
