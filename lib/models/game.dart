import 'package:spy_game/models/player.dart';

enum GameStatus { idle, waiting, started, timer, finished }

class Game {
  final int citizenCount;
  final int spyCount;
  final String? word;
  final bool isShowWord;
  final int currentPlayerIndex;
  final List<Player> players;
  final GameStatus status;
  final Duration time;
  final String? token;
  final String? creatorDeviceId;

  const Game({
    this.citizenCount = 2,
    this.spyCount = 1,
    this.word,
    this.isShowWord = false,
    this.currentPlayerIndex = 0,
    this.players = const [],
    this.status = GameStatus.idle,
    this.time = const Duration(minutes: 1),
    this.token,
    this.creatorDeviceId,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      citizenCount: json['citizenCount'],
      spyCount: json['spyCount'],
      word: json['word'],
      creatorDeviceId: json['creatorDeviceId'],
    );
  }

  Game copyWith({
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
    return Game(
      citizenCount: citizenCount ?? this.citizenCount,
      spyCount: spyCount ?? this.spyCount,
      word: word ?? this.word,
      isShowWord: isShowWord ?? this.isShowWord,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      players: players ?? this.players,
      status: status ?? this.status,
      time: time ?? this.time,
      token: token ?? this.token,
      creatorDeviceId: creatorDeviceId ?? this.creatorDeviceId,
    );
  }
}
