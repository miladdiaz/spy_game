class User {
  final String? deviceId;

  const User({
    this.deviceId,
  });

  User copyWith({String? deviceId}) {
    return User(
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
