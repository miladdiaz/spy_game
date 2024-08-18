import 'package:spy_game/models/player.dart';

class Game {
  final List<Player> players;
  final List<Player> spies;
  final String? word;
  final bool isShowWord;
  final int currentPlayer;

  const Game({
    this.players = const [
      Player(name: "Player 1", role: "player"),
      Player(name: "Player 2", role: "player"),
    ],
    this.spies = const [
      Player(name: "Player 3", role: "spy"),
    ],
    this.word,
    this.isShowWord = false,
    this.currentPlayer = 1,
  });

  Game copyWith({
    List<Player>? players,
    List<Player>? spies,
    String? word,
    bool? isShowWord,
    int? currentPlayer,
  }) {
    return Game(
      players: players ?? this.players,
      word: word ?? this.word,
      isShowWord: isShowWord ?? this.isShowWord,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      spies: spies ?? this.spies,
    );
  }
}
