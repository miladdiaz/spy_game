class Player {
  final String name;
  final String role;

  const Player({
    this.name = "",
    this.role = "",
  });

  Player copyWith({String? id, String? name, String? role}) {
    return Player(
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }
}
