import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spy_game/helpers/device.dart';
import 'package:spy_game/models/user.dart';

class UserProvider extends Notifier<User> {
  @override
  User build() {
    print('user provider build');
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
