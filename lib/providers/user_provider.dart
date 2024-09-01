import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/user.dart';
import 'dart:developer';

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
  }
}

final userNotifierProvider = NotifierProvider<UserProvider, User>(() {
  return UserProvider();
});
