import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/constants/words.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:spy_game/models/player.dart';

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

  Future<void> setGameTime(int value) async {
    state = state.copyWith(time: Duration(minutes: value));
  }

  Future<void> startGame() async {
    // set state of game
    state = state.copyWith(state: 'init');

    // reset current player index
    state = state.copyWith(currentPlayerIndex: 0);

    // set random word from constants
    final random = Random();
    final word = constants.words[random.nextInt(constants.words.length)];
    state = state.copyWith(word: word);

    // generate players
    // final citizens = List.generate(
    //   state.citizenCount,
    //   (_) => const Player(name: 'Player ', role: "player"),
    // );

    // // generate spies
    // final spies = List.generate(
    //   state.spyCount,
    //   (_) => const Player(name: 'Player', role: "spy"),
    // );

    // combine players and spies and shuffle
    // final List<Player> players = [...citizens, ...spies];
    // players.shuffle();

    // state = state.copyWith(word: word, players: players);

    await createGameOnServer();
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

    state = state.copyWith(token: result['token']);
  }

  List<String> pls = [];

  void startSocket() {
    io.Socket socket = io.io('http://192.168.11.111:3000',
        io.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('connect');
      socket.emit('joinGame', {'token': state.token});
    });

    socket.on('event', (data) {
      List<Player> p = List.from(data['players']
          .map((e) => const Player(name: "player", role: "player")));

      state = state.copyWith(players: p);
    });

    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.on('error', (_) => print(_));
    socket.on('connect_error', (_) => print(_));
    socket.on('connecting', (_) => print(_));
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
