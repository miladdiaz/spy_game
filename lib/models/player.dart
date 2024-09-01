class Player {
  final String name;
  final String deviceId;
  final String role;
  final String status;

  const Player({
    this.name = "",
    this.deviceId = "",
    this.role = "",
    this.status = "",
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      deviceId: json['deviceId'],
      role: json['role'],
      status: json['status'],
    );
  }

  Player copyWith(
      {String? id,
      String? name,
      String? deviceId,
      String? role,
      String? status}) {
    return Player(
      name: name ?? this.name,
      deviceId: id ?? this.deviceId,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  toJSON() {
    return {
      'name': name,
      'deviceId': deviceId,
      'role': role,
      'status': status,
    };
  }
}
