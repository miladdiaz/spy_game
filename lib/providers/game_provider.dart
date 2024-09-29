import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/constants/words.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/helpers/random_string.dart';
import 'package:spy_game/models/game.dart';
import 'package:spy_game/models/player.dart';
import 'package:spy_game/models/response.dart';

class GameNotifier extends Notifier<Game> {
  @override
  Game build() {
    setDeviceId();
    return const Game();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? stream;
  String? deviceId;
  String? gameId;
  Query<Map<String, dynamic>>? collectionReference;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> setDeviceId() async {
    deviceId = await getDeviceId();
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

  Future joinGame(String token) async {
    Response response = Response();

    // set gameId
    await db
        .collection("games")
        .where("token", isEqualTo: token)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        response = Response(success: false, message: "Game not found");
      } else {
        response = Response(success: true);
      }

      gameId = value.docs.first.id;
    });

    if (response.success == false) {
      return response;
    }

    stream = db.collection('games').doc(gameId).snapshots().listen((event) {
      state = Game.fromFirestore(event.data()!);
    });

    // add player to game
    db.collection('games').doc(gameId).update({
      'players': FieldValue.arrayUnion([
        Player(
          name: "Player",
          deviceId: deviceId!,
          status: "connected",
        ).toJSON()
      ]),
    });
  }

  void leaveGame() {
    // disconnected player from game
    db.collection('games').doc(gameId).update({
      'players': state.players.map((p) {
        var x = p.toJSON();

        if (x['deviceId'] == deviceId) {
          x['status'] = "disconnected";
        }
        return x;
      }),
    });

    // close stream
    stream?.cancel();
  }

  Future<Response> createGame() async {
    state = state.copyWith(
      creatorDeviceId: deviceId,
      status: GameStatus.waiting,
      token: getRandomString(6),
    );

    Response response = Response();

    await db.collection('games').add(state.toJSON()).then((value) {
      joinGame(state.token!);
      response = Response(success: true);
    }).catchError((e) {
      response = Response(success: false, message: e.toString());
    });

    return response;
  }

  void startGame() {
    db.collection('games').doc(gameId).update({
      'status': "timer",
      'word': words[Random().nextInt(words.length)],
      'players': assignPlayersRole(state.players, state.spyCount)
          .map((p) => p.toJSON()),
    });
  }

  Player getPlayerByDeviceId(String deviceId) {
    return state.players.firstWhere((p) => p.deviceId == deviceId);
  }

  List<Player> assignPlayersRole(List<Player> players, int spyCount) {
    List<Player> output = players;
    List<int> spyIndexes = [];

    // assign all players as citizen
    output = output.map((p) => p.copyWith(role: "citizen")).toList();

    for (int i = 0; i < spyCount; i++) {
      int index = Random().nextInt(players.length);
      if (spyIndexes.contains(index)) {
        i--;
        continue;
      }
      spyIndexes.add(index);
      output[index] = output[index].copyWith(role: "spy");
    }
    return output;
  }
}

final gameNotifierProvider = NotifierProvider<GameNotifier, Game>(() {
  return GameNotifier();
});
