class User {
  final String? deviceId;
  final String? authToken;

  const User({
    this.deviceId,
    this.authToken,
  });

  User copyWith({String? deviceId, String? authToken}) {
    return User(
      deviceId: deviceId ?? this.deviceId,
      authToken: authToken ?? this.authToken,
    );
  }
}
