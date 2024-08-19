import 'package:spy_game/models/player.dart';

class Game {
  final int citizenCount;
  final int spyCount;
  final String? word;
  final bool isShowWord;
  final int currentPlayerIndex;
  final List<Player> players;
  final String state;

  const Game({
    this.citizenCount = 2,
    this.spyCount = 1,
    this.word,
    this.isShowWord = false,
    this.currentPlayerIndex = 0,
    this.players = const [],
    this.state = 'idle',
  });

  Game copyWith({
    int? citizenCount,
    int? spyCount,
    String? word,
    bool? isShowWord,
    int? currentPlayerIndex,
    List<Player>? players,
    String? state,
  }) {
    return Game(
      citizenCount: citizenCount ?? this.citizenCount,
      spyCount: spyCount ?? this.spyCount,
      word: word ?? this.word,
      isShowWord: isShowWord ?? this.isShowWord,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      players: players ?? this.players,
      state: state ?? this.state,
    );
  }
}
