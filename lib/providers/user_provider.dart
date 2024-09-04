import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/user.dart';
import 'dart:developer';
import 'package:crypto/crypto.dart';

import '../env.dart';

class UserProvider extends Notifier<User> {
  @override
  User build() {
    log('user provider initialized');

    initMyDeviceId();
    return const User();
  }

  Future<void> initMyDeviceId() async {
    String deviceId = await getDeviceId();
    state = state.copyWith(deviceId: deviceId);
    generateAuthToken();
  }

  void generateAuthToken() {
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(secret));
    String digest = hmacSha256.convert(utf8.encode(state.deviceId!)).toString();

    state = state.copyWith(authToken: digest);
  }
}

final userNotifierProvider = NotifierProvider<UserProvider, User>(() {
  return UserProvider();
});
